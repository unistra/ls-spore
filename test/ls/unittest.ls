describe 'Spore',(x) ->

    before-all (done) ->
        jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000
        @route-get-list = void
        @route-post = void
        @route-get-one = void
        @route-delete-one = void
        @client = new Spore  \/base/data/description.json, (->
            done!
        ), 
        (->
            void
        ),
        base_url=\http://localhost:3000/api


    describe 'Test client',(x) ->

        it 'initialize Spore client', ->
            expect @client.isReady .toBe true

        it 'log basic infos', ->
            @client.log-basic-infos!
            expect true .toBe true

        it 'check client base attrs', ->
            expect @client.url .toBe \/base/data/description.json
            expect @client.base-url .toBe \http://localhost:3000/api

            expect @client.description.name .toBe 'TEST API'
            expect @client.description.authority .toBe 'Unistra:DI'
            expect @client.description.base_url .toBe 'http://localhost:3000/api'
            expect @client.description.formats[0] .toBe "json"
            expect @client.description.authentication .toBe true
            expect @client.description.version .toBe "1.0.0"
            expect @client.description.meta.documentation .toBe ""
            expect @client.description.meta.authors .toBe "dip unistra"

        it 'check client methods specs add product', ->
            #basics
            expect @client.methods-specs.add_product? .toBe true
            expect @client.methods-specs.add_product.path .toBe "/products"
            expect @client.methods-specs.add_product.required_params.length .toBe 0
            expect @client.methods-specs.add_product.optional_params.length .toBe 0
            expect @client.methods-specs.add_product.required_payload .toBe true
            expect @client.methods-specs.add_product.method .toBe "POST"
            expect @client.methods-specs.add_product.authentication .toBe true
            expect @client.methods-specs.add_product.documentation .toBe "Add a product"
            #env
            expect @client.methods-specs.add_product.env.REQUEST_METHOD .toBe "POST"
            expect @client.methods-specs.add_product.env.SERVER_NAME .toBe "localhost"
            expect @client.methods-specs.add_product.env.SERVER_PORT .toBe 3000
            expect @client.methods-specs.add_product.env.SCRIPT_NAME .toBe "/api"
            expect @client.methods-specs.add_product.env.PATH_INFO .toBe "/products"
            expect @client.methods-specs.add_product.env.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-specs.add_product.env.spore.expected_status .toBe void
            expect @client.methods-specs.add_product.env.spore.authentication .toBe true
            expect Object.keys(@client.methods-specs.add_product.env.spore.params).length .toBe 0
            expect Object.keys(@client.methods-specs.add_product.env.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-specs.add_product.env.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-specs.add_product.env.spore.headers).length .toBe 0
            expect @client.methods-specs.add_product.env.spore.formats .toBe void
            expect @client.methods-specs.add_product.env.spore.scheme .toBe "http"

        it 'check client methods specs get products', ->
            #basics
            expect @client.methods-specs.get_products? .toBe true
            expect @client.methods-specs.get_products.path .toBe "/products"
            expect @client.methods-specs.get_products.required_params.length .toBe 0
            expect @client.methods-specs.get_products.optional_params.length .toBe 3
            expect @client.methods-specs.get_products.required_payload .toBe void
            expect @client.methods-specs.get_products.method .toBe "GET"
            expect @client.methods-specs.get_products.authentication .toBe true
            expect @client.methods-specs.get_products.documentation .toBe "Get products"
            #env
            expect @client.methods-specs.get_products.env.REQUEST_METHOD .toBe "GET"
            expect @client.methods-specs.get_products.env.SERVER_NAME .toBe "localhost"
            expect @client.methods-specs.get_products.env.SERVER_PORT .toBe 3000
            expect @client.methods-specs.get_products.env.SCRIPT_NAME .toBe "/api"
            expect @client.methods-specs.get_products.env.PATH_INFO .toBe "/products"
            expect @client.methods-specs.get_products.env.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-specs.get_products.env.spore.expected_status .toBe void
            expect @client.methods-specs.get_products.env.spore.authentication .toBe true
            expect Object.keys(@client.methods-specs.get_products.env.spore.params).length .toBe 0
            expect Object.keys(@client.methods-specs.get_products.env.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-specs.get_products.env.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-specs.get_products.env.spore.headers).length .toBe 0
            expect @client.methods-specs.get_products.env.spore.formats .toBe void
            expect @client.methods-specs.get_products.env.spore.scheme .toBe "http"

        it 'check client methods specs get product', ->
            #basics
            expect @client.methods-specs.get_product? .toBe true
            expect @client.methods-specs.get_product.path .toBe "/products/:id"
            expect @client.methods-specs.get_product.required_params.length .toBe 1
            expect @client.methods-specs.get_product.optional_params.length .toBe 0
            expect @client.methods-specs.get_product.required_payload .toBe void
            expect @client.methods-specs.get_product.method .toBe "GET"
            expect @client.methods-specs.get_product.authentication .toBe true
            expect @client.methods-specs.get_product.documentation .toBe "Get one product"
            #env
            expect @client.methods-specs.get_product.env.REQUEST_METHOD .toBe "GET"
            expect @client.methods-specs.get_product.env.SERVER_NAME .toBe "localhost"
            expect @client.methods-specs.get_product.env.SERVER_PORT .toBe 3000
            expect @client.methods-specs.get_product.env.SCRIPT_NAME .toBe "/api"
            expect @client.methods-specs.get_product.env.PATH_INFO .toBe "/products/:id"
            expect @client.methods-specs.get_product.env.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-specs.get_product.env.spore.expected_status .toBe void
            expect @client.methods-specs.get_product.env.spore.authentication .toBe true
            expect Object.keys(@client.methods-specs.get_product.env.spore.params).length .toBe 0
            expect Object.keys(@client.methods-specs.get_product.env.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-specs.get_product.env.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-specs.get_product.env.spore.headers).length .toBe 0
            expect @client.methods-specs.get_product.env.spore.formats .toBe void
            expect @client.methods-specs.get_product.env.spore.scheme .toBe "http"


        it 'check client methods specs delete product', ->
            #basics
            expect @client.methods-specs.delete_product? .toBe true
            expect @client.methods-specs.delete_product.path .toBe "/products/:id"
            expect @client.methods-specs.delete_product.required_params.length .toBe 1
            expect @client.methods-specs.delete_product.optional_params.length .toBe 0
            expect @client.methods-specs.delete_product.required_payload .toBe void
            expect @client.methods-specs.delete_product.method .toBe "DELETE"
            expect @client.methods-specs.delete_product.authentication .toBe true
            expect @client.methods-specs.delete_product.documentation .toBe "delete one product"
            #env
            expect @client.methods-specs.delete_product.env.REQUEST_METHOD .toBe "DELETE"
            expect @client.methods-specs.delete_product.env.SERVER_NAME .toBe "localhost"
            expect @client.methods-specs.delete_product.env.SERVER_PORT .toBe 3000
            expect @client.methods-specs.delete_product.env.SCRIPT_NAME .toBe "/api"
            expect @client.methods-specs.delete_product.env.PATH_INFO .toBe "/products/:id"
            expect @client.methods-specs.delete_product.env.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-specs.delete_product.env.spore.expected_status .toBe void
            expect @client.methods-specs.delete_product.env.spore.authentication .toBe true
            expect Object.keys(@client.methods-specs.delete_product.env.spore.params).length .toBe 0
            expect Object.keys(@client.methods-specs.delete_product.env.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-specs.delete_product.env.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-specs.delete_product.env.spore.headers).length .toBe 0
            expect @client.methods-specs.delete_product.env.spore.formats .toBe void
            expect @client.methods-specs.delete_product.env.spore.scheme .toBe "http"

        describe 'No token',(x) ->

            before-all (done) ->
                @client.methods.add_product {
                    payload: {
                        name: "voiture",
                        sku: "206",
                        price: 10000
                    },
                }, (response) ~>
                    @route-post = response
                    done!
                , (error) ~>
                    void

            it 'No token add product', ->
                expect @route-post.error .toEqual "No credentials sent!"


        describe 'Wrong token',(x) ->

            before-all (done) ->
                @client.enable SporeMiddlewareAuthApiKey, {key_name:"Authorization", key_value:"Token WRONG"}

                @client.methods.add_product {
                    payload: {
                        name: "voiture",
                        sku: "206",
                        price: 10000
                    },
                }, (response) ~>
                    @route-post = response
                    done!
                , (error) ~>
                    void

            it 'No token add product', ->
                expect @route-post.error .toEqual "Wrong token"


        # ENABLE TOKEN MIDDLEWARE HERE !
        it 'enable middleware', ->
            @client.enable SporeMiddlewareAuthApiKey, {key_name:"Authorization", key_value:"Token S3CR3T"}
            expect @client.middlewares[1].middleware-class.name .toBe "SporeMiddlewareAuthApiKey" 
            expect @client.middlewares[1].params.key_name .toBe "Authorization"
            expect @client.middlewares[1].params.key_value .toBe "Token S3CR3T"


        describe 'Test add product',(x) ->

            before-all (done) ->
                @client.methods.add_product {
                    payload: {
                        name: "voiture",
                        sku: "206",
                        price: 10000
                    },
                }, (response) ~>
                    @route-post = response
                    done()
                , (error) ~>
                    void

            it 'add product', ->
                expect @route-post.name .toEqual "voiture"
                expect @route-post.sku .toEqual "206"
                expect @route-post.price .toEqual 10000


            describe 'Test get products',(x) ->

                before-all (done) ->
                    @client.methods.get_products {
                        name: "voiture",
                    }, (response) ~>
                        @route-get-list = response
                        done!
                    , (error) ~>
                        void

                it 'get products', ->
                    expect @route-get-list.length .toBeGreaterThan 0
                    expect @route-get-list[0].name .toEqual "voiture"
                    expect @route-get-list[0].sku .toEqual "206"
                    expect @route-get-list[0].price .toEqual 10000

            describe 'Test get one product',(x) ->

                before-all (done) ->
                    @client.methods.get_product {
                        id: @route-post._id,
                    }, (response) ~>
                        @route-get-one = response
                        done()
                    , (error) ~>
                        void

                it 'get one product', ->
                    expect @route-get-one.name .toEqual "voiture"
                    expect @route-get-one.sku .toEqual "206"
                    expect @route-get-one.price .toEqual 10000


            describe 'Test delete product',(x) ->

                before-all (done) ->
                    @client.methods.delete_product {
                        id: @route-post._id,
                    }, (response) ~>
                        @route-delete-one = response
                        done()
                    , (error) ~>
                        void

                it 'delete one product', ->
                    expect @route-delete-one .toEqual ''

