describe 'Spore',(...) !->

    before-all (done) ->
        jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000
        @route-get-list = void
        @route-post = void
        @route-get-one = void
        @route-delete-one = void
        @route-get-one-expected-not-found = void
        @route-delete-one-unexpected-not-found = void
        @client = new Spore  \/base/data/description.json, (->
            done!
        ),
        (->
            void
        ),
        base_url=\http://localhost:3000/api


    describe 'Test client',(...) !->

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
            expect @client.description.methods.add_product? .toBe true
            expect @client.description.methods.add_product.path .toBe "/products"
            expect @client.description.methods.add_product.required_params.length .toBe 0
            expect @client.description.methods.add_product.optional_params.length .toBe 0
            expect @client.description.methods.add_product.required_payload .toBe true
            expect @client.description.methods.add_product.method .toBe "POST"
            expect @client.description.methods.add_product.authentication .toBe true
            expect @client.description.methods.add_product.documentation .toBe "Add a product"
            #env
            expect @client.methods-env.add_product.REQUEST_METHOD .toBe "POST"
            expect @client.methods-env.add_product.SERVER_NAME .toBe "localhost"
            expect @client.methods-env.add_product.SERVER_PORT .toBe 3000
            expect @client.methods-env.add_product.SCRIPT_NAME .toBe "/api"
            expect @client.methods-env.add_product.PATH_INFO .toBe "/products"
            expect @client.methods-env.add_product.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-env.add_product.spore.expected_status.length .toBe 0
            expect @client.methods-env.add_product.spore.authentication .toBe true
            expect Object.keys(@client.methods-env.add_product.spore.params).length .toBe 0
            expect Object.keys(@client.methods-env.add_product.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-env.add_product.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-env.add_product.spore.headers).length .toBe 0
            expect @client.methods-env.add_product.spore.formats .toBe void
            expect @client.methods-env.add_product.spore.scheme .toBe "http"

        it 'check client methods specs get products', ->
            #basics
            expect @client.description.methods.get_products? .toBe true
            expect @client.description.methods.get_products.path .toBe "/products"
            expect @client.description.methods.get_products.required_params.length .toBe 0
            expect @client.description.methods.get_products.optional_params.length .toBe 3
            expect @client.description.methods.get_products.required_payload .toBe void
            expect @client.description.methods.get_products.method .toBe "GET"
            expect @client.description.methods.get_products.authentication .toBe true
            expect @client.description.methods.get_products.documentation .toBe "Get products"
            #env
            expect @client.methods-env.get_products.REQUEST_METHOD .toBe "GET"
            expect @client.methods-env.get_products.SERVER_NAME .toBe "localhost"
            expect @client.methods-env.get_products.SERVER_PORT .toBe 3000
            expect @client.methods-env.get_products.SCRIPT_NAME .toBe "/api"
            expect @client.methods-env.get_products.PATH_INFO .toBe "/products"
            expect @client.methods-env.get_products.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-env.get_products.spore.expected_status.length .toBe 0
            expect @client.methods-env.get_products.spore.authentication .toBe true
            expect Object.keys(@client.methods-env.get_products.spore.params).length .toBe 0
            expect Object.keys(@client.methods-env.get_products.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-env.get_products.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-env.get_products.spore.headers).length .toBe 0
            expect @client.methods-env.get_products.spore.formats .toBe void
            expect @client.methods-env.get_products.spore.scheme .toBe "http"

        it 'check client methods specs get product', ->
            #basics
            expect @client.description.methods.get_product? .toBe true
            expect @client.description.methods.get_product.path .toBe "/products/:id"
            expect @client.description.methods.get_product.required_params.length .toBe 1
            expect @client.description.methods.get_product.optional_params.length .toBe 0
            expect @client.description.methods.get_product.required_payload .toBe void
            expect @client.description.methods.get_product.method .toBe "GET"
            expect @client.description.methods.get_product.authentication .toBe true
            expect @client.description.methods.get_product.documentation .toBe "Get one product"
            #env
            expect @client.methods-env.get_product.REQUEST_METHOD .toBe "GET"
            expect @client.methods-env.get_product.SERVER_NAME .toBe "localhost"
            expect @client.methods-env.get_product.SERVER_PORT .toBe 3000
            expect @client.methods-env.get_product.SCRIPT_NAME .toBe "/api"
            expect @client.methods-env.get_product.PATH_INFO .toBe "/products/:id"
            expect @client.methods-env.get_product.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-env.get_product.spore.expected_status[0] .toBe 404
            expect @client.methods-env.get_product.spore.authentication .toBe true
            expect Object.keys(@client.methods-env.get_product.spore.params).length .toBe 0
            expect Object.keys(@client.methods-env.get_product.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-env.get_product.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-env.get_product.spore.headers).length .toBe 0
            expect @client.methods-env.get_product.spore.formats .toBe void
            expect @client.methods-env.get_product.spore.scheme .toBe "http"


        it 'check client methods specs delete product', ->
            #basics
            expect @client.description.methods.delete_product? .toBe true
            expect @client.description.methods.delete_product.path .toBe "/products/:id"
            expect @client.description.methods.delete_product.required_params.length .toBe 1
            expect @client.description.methods.delete_product.optional_params.length .toBe 0
            expect @client.description.methods.delete_product.required_payload .toBe void
            expect @client.description.methods.delete_product.method .toBe "DELETE"
            expect @client.description.methods.delete_product.authentication .toBe true
            expect @client.description.methods.delete_product.documentation .toBe "delete one product"
            #env
            expect @client.methods-env.delete_product.REQUEST_METHOD .toBe "DELETE"
            expect @client.methods-env.delete_product.SERVER_NAME .toBe "localhost"
            expect @client.methods-env.delete_product.SERVER_PORT .toBe 3000
            expect @client.methods-env.delete_product.SCRIPT_NAME .toBe "/api"
            expect @client.methods-env.delete_product.PATH_INFO .toBe "/products/:id"
            expect @client.methods-env.delete_product.QUERY_STRING .toBe ""
            #env spore
            expect @client.methods-env.delete_product.spore.expected_status.length .toBe 0
            expect @client.methods-env.delete_product.spore.authentication .toBe true
            expect Object.keys(@client.methods-env.delete_product.spore.params).length .toBe 0
            expect Object.keys(@client.methods-env.delete_product.spore.payload).length .toBe 0
            expect Object.keys(@client.methods-env.delete_product.spore.errors).length .toBe 0
            expect Object.keys(@client.methods-env.delete_product.spore.headers).length .toBe 0
            expect @client.methods-env.delete_product.spore.formats .toBe void
            expect @client.methods-env.delete_product.spore.scheme .toBe "http"

        describe 'No token',(...) !->

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


        describe 'Wrong token',(...) !->

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


        describe 'Test add product',(...) !->

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


            describe 'Test get products',(...) !->

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

            describe 'Test get one product',(...) !->

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


            describe 'Test delete product',(...) !->

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



            describe 'Test 404 one product expected',(...) !->

                before-all (done) ->
                    @client.methods.get_product {
                        id: "58986ddb9e7548077551d16f",
                    }, (response) ~>
                        @route-get-one-expected-not-found = response
                        done()
                    , (error) ~>
                        void

                it 'get one product 404', ->
                    expect @route-get-one-expected-not-found.error .toEqual undefined


            describe 'Test delete 404 one product unexpected',(...) !->

                before-all (done) ->
                    @client.methods.delete_product {
                        id: "58986ddb9e7548077551d16f",
                    }, (response) ~>
                       void
                    , (error) ~>
                        @route-delete-one-unexpected-not-found = error
                        done()

                it 'delete one product 404', ->
                    expect @route-delete-one-unexpected-not-found.error .toEqual 'Spore error 404 Not Found: {"status":404,"message":"Object not found","name":"ObjectNotFound","errors":{"_id":{"message":"Could not find object with specified attributes"}}}'
