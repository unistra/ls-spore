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

        it 'check client method specs', ->
            expect @client.methods-specs.add_product? .toBe true

        # #TODO
        # it 'check client methods specs details', ->
        #     expect(true).toBe(true)



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
                ,
                   (error) ~>
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
                ,
                   (error) ~>
                    void

            it 'No token add product', ->
                expect @route-post.error .toEqual "Wrong token"


        # ENABLE TOKEN MIDDLEWARE HERE !
        it 'enable middleware', ->
            @client.enable SporeMiddlewareAuthApiKey, {key_name:"Authorization", key_value:"Token S3CR3T"}
            expect(@client.middlewares[1].middleware-class.name).toBe("SporeMiddlewareAuthApiKey")
            expect(@client.middlewares[1].params.key_name).toBe("Authorization")
            expect(@client.middlewares[1].params.key_value).toBe("Token S3CR3T")


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
                ,
                   (error) ~>
                    void

            it 'add product', ->
                expect(@route-post.name).toEqual("voiture")
                expect(@route-post.sku).toEqual("206")
                expect(@route-post.price).toEqual(10000)


            describe 'Test get products',(x) ->

                before-all (done) ->
                    @client.methods.get_products {
                        name: "voiture",
                    }, (response) ~>
                        @route-get-list = response
                        done!
                    ,
                       (error) ~>
                        void

                it 'get products', ->
                    expect @route-get-list.length .toBeGreaterThan 0
                    expect(@route-get-list[0].name).toEqual("voiture")
                    expect(@route-get-list[0].sku).toEqual("206")
                    expect(@route-get-list[0].price).toEqual(10000)

            describe 'Test get one product',(x) ->

                before-all (done) ->
                    @client.methods.get_product {
                        id: @route-post._id,
                    }, (response) ~>
                        @route-get-one = response
                        done()
                    ,
                       (error) ~>
                        void

                it 'get one product', ->
                    expect(@route-get-one.name).toEqual("voiture")
                    expect(@route-get-one.sku).toEqual("206")
                    expect(@route-get-one.price).toEqual(10000)



            describe 'Test delete product',(x) ->

                before-all (done) ->
                    @client.methods.delete_product {
                        id: @route-post._id,
                    }, (response) ~>
                        @route-delete-one = response
                        done()
                    ,
                       (error) ~>
                        void

                it 'delete one product', ->
                    expect(@route-delete-one).toEqual("")

