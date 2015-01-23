class SporeRequest
    (final-env) ->
        @env=^^final-env

    call: (callback)->
        url-template = @_generate-url-template!
        url = @_generate-final-url url-template
        query = @_do-request(url, callback)

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
            then url-template=url-template.replace(re, v)
            else 
                if query-string != "" 
                then query-string+="&"
                query-string+=k+"="+v

        if query-string != "" then @env.QUERY_STRING="?"+query-string
        final-url = url-template + @env.QUERY_STRING

        final-url

    _do-request: (url, callback) ->
        xhr = new XMLHttpRequest
        xhr.open @env.REQUEST_METHOD, url, true
        xhr.set-request-header "Content-Type", 'application/json'
        for k, v of @env.spore.headers
            xhr.set-request-header k, v
        #TODO content type for xml and others
        xhr.override-mime-type 'application/json' if 'overrideMimeType' in xhr
        xhr.onreadystatechange = !~>
            if xhr.ready-state is 4
                if xhr.status in [200 201 202 203 204 205 206 0]
                then
                    try
                        my-json = if xhr.response-text!="" then JSON.parse(xhr.response-text) else ""
                        callback(my-json)
                    catch
                        window.console.error "Spore error: cannot parse json method response"
                else window.console.error "Spore error: Call #{url}"
        if Object.keys(@env.spore.payload).length > 0
        then
            xhr.send JSON.stringify @env.spore.payload
        else xhr.send null
        xhr

export SporeRequest