class SporeMethodsFactory

    create-method: (name, method-specs, middlewares) ->

        method = (params, success, error) ->

            pop-payload = ->
                payload = if params.payload? then params.payload else {}
                delete params.payload
                if method-specs.required_payload? and method-specs.required_payload==true and Object.keys(payload).length==0
                    window.console.error "Spore error: payload is required"
                payload

            check-require-params = ->
                check-required-params=[k for k in method-specs.required-params]
                for k in method-specs.required-params
                    if params[k]?
                    then check-required-params.pop k
                check-required-params.length==0

            check-wrong-params = ->
                check = true
                for k,v of params
                    if method-specs.required-params.indexOf(k)>-1 or method-specs.optional-params.indexOf(k)>-1
                    then continue
                    else check=false
                check

            apply-middlewares = ->
                method-specs.env.spore.headers = {}
                for m in middlewares
                    middleware-instance = new m['middlewareClass'] m['params']
                    middleware-instance.call method-specs.env


            add-params = ->
                method-specs.env.spore.params = params

            add-payload = (payload) ->
                method-specs.env.spore.payload = payload

            add-headers = ->
                for k, v of method-specs.headers
                    if (not) method-specs.env.spore.headers[k]?
                    then method-specs.env.spore.headers[k] = v

            # call request
            payload = pop-payload!
            if check-require-params and check-wrong-params
            then
                apply-middlewares!
                add-params!
                add-payload payload
                add-headers!
                final-env = method-specs.env
                request = new SporeRequest final-env
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
        @methods-specs = {}
        @middlewares = []

    create: (success, error) ->
        xhr = new XMLHttpRequest
        xhr.open 'GET', @url, true
        xhr.override-mime-type 'application/json' if 'overrideMimeType' in xhr
        xhr.onreadystatechange = !~>
            if xhr.ready-state is 4
                if xhr.status in [200 0]
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
        @middlewares.push {middleware-class: middleware-class, params:params}

    enable-if: (middleware-class, params)->
        window.console.log "TODO enable if"

    log-basic-infos: ->
        window.console.log "Name: " + @name
        window.console.log "Base url: " + @base_url
        window.console.log "Authority: " + @authority
        window.console.log "Formats: " + @formats
        window.console.log "Version: " + @version
        window.console.log "Meta: " + JSON.stringify @meta

    _generate-methods: (methods) ->
        my-factory = new SporeMethodsFactory!
        for key, value of methods
            @_generate-methods-specs key, value
            @_generate-methods-env key, value
            @['methods'][key] = my-factory.create-method key, @methods-specs[key], @middlewares

    _generate-methods-specs: (method-key, method-value)->
        @methods-specs[method-key] = {}
        for k, v of method-value
            if k!="env"
                @methods-specs[method-key][k] = v

    _generate-methods-env: (method-key, method-value)->
        url_parser = document.createElement 'a'
        url_parser.href = @_get-base-url method-key, method-value

        @methods-specs[method-key].env = {}
        @methods-specs[method-key].env.REQUEST_METHOD = @_get-request-method method-value.method
        @methods-specs[method-key].env.SERVER_NAME = url_parser.hostname
        @methods-specs[method-key].env.SERVER_PORT = @_get-server-port url_parser
        @methods-specs[method-key].env.SCRIPT_NAME = @_get-script-name url_parser.pathname
        @methods-specs[method-key].env.PATH_INFO = @_get-path-info @methods-specs[method-key].env.SCRIPT_NAME, url_parser.pathname, method-value.path
        @methods-specs[method-key].env.QUERY_STRING = ""

        @methods-specs[method-key].env.spore = {}
        #TODO expected_status
        @methods-specs[method-key].env.spore.expected_status = method-value.expected_status
        #TODO authentication
        @methods-specs[method-key].env.spore.authentication = if method-value.authentication? then method-value.authentication else false
        @methods-specs[method-key].env.spore.params = {}
        @methods-specs[method-key].env.spore.payload = {}
        #TODO errors
        @methods-specs[method-key].env.spore.errors = {}
        @methods-specs[method-key].env.spore.headers = {}
        #TODO formats
        @methods-specs[method-key].env.spore.formats = method-value.formats
        @methods-specs[method-key].env.spore.scheme = url_parser.protocol.split(":")[0]

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

    _generate-basics: (description) ->
        for key, value of description
            if key != 'methods'
                @[key] = value

    _call-callback: (response, callback)->
        @description = response
        @_generate-methods @description.methods
        @_generate-basics @description
        @is-ready = true
        callback!

    _get-base-url: (key, value) ->
            if @base-url? then return @base-url
            else if value.base_url? then return value.base_url
            else if @description.base_url? then return @description.base_url
            else return void

export Spore
