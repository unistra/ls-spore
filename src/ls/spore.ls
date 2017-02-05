class SporeRequest
    (final-env) ->
        @env=^^final-env

    call: (success, error)->
        url-template = @_generate-url-template!
        url = @_generate-final-url url-template
        query = @_do-request url, success, error

    _generate-url-template: ->
        url-template = @env.spore.scheme + "://" + @env.SERVER_NAME
        if @env.SERVER_PORT!=443 and @env.SERVER_PORT!=80
        then url-template+=":"+@env.SERVER_PORT.to-string!
        url-template += @env.SCRIPT_NAME + @env.PATH_INFO
        url-template

    _generate-final-url: (url-template) ->

        query-string=""
        for k,v of @env.spore.params
            re = new RegExp ":("+ k + ")"
            if url-template.search(re)>=0
            then url-template=url-template.replace re, v
            else
                if query-string != ""
                then query-string+="&"
                query-string+=k+"="+v

        if query-string != "" then @env.QUERY_STRING="?"+query-string
        final-url = url-template + @env.QUERY_STRING

        final-url

    _do-request: (url, success, error) ->
        xhr = new XMLHttpRequest
        xhr.open @env.REQUEST_METHOD, url, true
        xhr.set-request-header "Content-Type", 'application/json'
        for k, v of @env.spore.headers
            if (k!="Authorization") or (k=="Authorization" and @env.spore.authentication == true)
                xhr.set-request-header k, v
        #TODO content type for xml and others
        xhr.override-mime-type 'application/json' if 'overrideMimeType' in xhr
        xhr.onreadystatechange = !~>
            if xhr.ready-state is 4
                if 200 <= xhr.status <= 299 or xhr.status in @env.spore.expected_status
                then
                    try
                        my-json = if xhr.response-text!="" then JSON.parse xhr.response-text else ""
                        success my-json
                    catch
                        error-msg = "Spore error: cannot parse json method response"
                        window.console.error error-msg
                        error {error:error-msg}
                else
                    error-msg = "Spore error #{xhr.status} #{xhr.statusText}: #{xhr.response-text}"
                    window.console.error error-msg
                    error {error:error-msg}
        if Object.keys(@env.spore.payload).length > 0
        then
            xhr.send JSON.stringify @env.spore.payload
        else xhr.send null
        xhr

class SporeMethodsFactory

    create-method: (name, desc, env, middlewares) ->

        method = (params, success, error) ->

            pop-payload = ->
                payload = if params.payload? then params.payload else {}
                delete params.payload
                if desc.required_payload? and desc.required_payload==true and Object.keys(payload).length==0
                    window.console.error "Spore error: payload is required"
                payload

            check-require-params = ->
                check-required-params=[k for k in desc.required-params]
                for k in desc.required-params
                    if params[k]?
                    then check-required-params.pop k
                check-required-params.length==0

            check-wrong-params = ->
                check = true
                for k,v of params
                    if desc.required-params.indexOf(k)>-1 or desc.optional-params.indexOf(k)>-1
                    then continue
                    else check=false
                check

            apply-middlewares = ->
                env.spore.headers = {}
                for m in middlewares
                    if m.predicate env
                        middleware-instance = new m['middlewareClass'] m['params']
                        middleware-instance.call env

            add-params = ->
                env.spore.params = params

            add-payload = (payload) ->
                env.spore.payload = payload

            add-headers = ->
                for k, v of desc.headers
                    if (not) env.spore.headers[k]?
                    then env.spore.headers[k] = v

            # call request
            payload = pop-payload!
            if check-require-params and check-wrong-params
            then
                add-params!
                add-payload payload
                add-headers!
                apply-middlewares!
                request = new SporeRequest env
                request.call success, error
            else window.console.error "Spore error: wrong parameters of #{name}"

        return method


class Spore
    (url, success, error, base_url=void) ->
        @url = url
        @base-url = base_url
        @is-ready = false
        @description = {}
        @create success, error
        @methods = {}
        @methods-env = {}
        @middlewares = []

    create: (success, error) ->
        xhr = new XMLHttpRequest
        xhr.open 'GET', @url, true
        xhr.override-mime-type 'application/json' if 'overrideMimeType' in xhr
        xhr.onreadystatechange = !~>
            if xhr.ready-state is 4
                if 200 <= xhr.status <= 299
                then
                    try
                        my-json = JSON.parse xhr.response-text
                        @_call-callback my-json, success
                    catch
                        error-msg = "Spore error: cannot parse json description file"
                        window.console.error error-msg
                        error {error:error-msg}
                else
                    error-msg = "Spore error: #{xhr.status} #{xhr.statusText}"
                    window.console.error error-msg
                    error {error:error-msg}
        xhr.send null
        xhr

    enable: (middleware-class, params)->
        @enable-if (request) ->
            return true
        , middleware-class, params

    enable-if: (predicate, middleware-class, params)->
        @middlewares.push {predicate: predicate, middleware-class: middleware-class, params:params}

    log-basic-infos: ->
        window.console.log "Name: " + @description.name
        window.console.log "Base url: " + @description.base_url
        window.console.log "Authority: " + @description.authority
        window.console.log "Formats: " + @description.formats
        window.console.log "Version: " + @description.version
        window.console.log "Meta: " + JSON.stringify @description.meta

    _generate-methods: (methods) ->
        my-factory = new SporeMethodsFactory!
        for key, value of methods
            @_generate-methods-env key, value
            @['methods'][key] = my-factory.create-method key,@description.methods[key], @methods-env[key], @middlewares

    _generate-methods-env: (method-key, method-value)->
        url_parser = document.createElement 'a'
        url_parser.href = @_get-base-url method-value

        @methods-env[method-key] = {}
        @methods-env[method-key].REQUEST_METHOD = @_get-request-method method-value.method
        @methods-env[method-key].SERVER_NAME = url_parser.hostname
        @methods-env[method-key].SERVER_PORT = @_get-server-port url_parser
        @methods-env[method-key].SCRIPT_NAME = @_get-script-name url_parser.pathname
        @methods-env[method-key].PATH_INFO = @_get-path-info @methods-env[method-key].SCRIPT_NAME, url_parser.pathname, method-value.path
        @methods-env[method-key].QUERY_STRING = ""

        @methods-env[method-key].spore = {}
        #TODO expected_status
        @methods-env[method-key].spore.expected_status = if method-value.expected_status? then method-value.expected_status else []
        @methods-env[method-key].spore.authentication = @_get-authentication method-value.authentication
        @methods-env[method-key].spore.params = {}
        @methods-env[method-key].spore.payload = {}
        #TODO errors
        @methods-env[method-key].spore.errors = {}
        @methods-env[method-key].spore.headers = {}
        #TODO formats
        @methods-env[method-key].spore.formats = method-value.formats
        @methods-env[method-key].spore.scheme = url_parser.protocol.split(":")[0]


    _get-authentication: (method-authentication)->
        if method-authentication?
        then method-authentication
        else if @description.authentication?
        then @description.authentication
        else false

    _get-path-info: (script_name, pathname, method_path) ->
        res = ""
        # from base url
        if script_name? and script_name!=""
        then res = pathname.replace script_name,""
        else res = pathname
        if res == "/" then res = ""
        # from method
        res+=method_path
        res

    _get-request-method: (method) ->
        if method? and method!=""
        then method
        else "GET"

    _get-script-name: (pathname) ->
        if pathname? and pathname!=""
            slice = pathname.split("/", 2).slice(1)
            if slice[0]? and slice[0] != ""
            then "/" + slice[0]
            else ""

    _get-server-port: (url_parser)->
        port=80
        if url_parser.port? and url_parser.port!=""
        then port=parse-int url_parser.port
        else if url_parser.protocol=="https:"
        then port=443
        port

    _call-callback: (response, callback)->
        @description = response
        @_generate-methods @description.methods
        @is-ready = true
        callback!

    _get-base-url: (value) ->
            if @base-url? then return @base-url
            else if value.base_url? then return value.base_url
            else if @description.base_url? then return @description.base_url
            else return void

export Spore
