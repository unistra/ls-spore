class SporeMiddleware
    ->
        @process_request=void
        @process_response=void

    call: (env) ->
        if @process_request?
        then @process_request env
        else if @process_response?
        then @process_response env


class SporeMiddlewareAuthApiKey extends SporeMiddleware
    (params) ->
        @key-name=params.key_name
        @key-value=params.key_value

    process_request: (env) ->
        env.spore.headers[@key-name] = @key-value

export SporeMiddlewareAuthApiKey