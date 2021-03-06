// Generated by LiveScript 1.5.0
(function(){
  describe('Spore', function(){
    beforeAll(function(done){
      var base_url;
      jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000;
      this.routeGetList = void 8;
      this.routePost = void 8;
      this.routeGetOne = void 8;
      this.routeDeleteOne = void 8;
      this.routeGetOneExpectedNotFound = void 8;
      this.routeDeleteOneUnexpectedNotFound = void 8;
      return this.client = new Spore('/base/data/description.json', function(){
        return done();
      }, function(){}, base_url = 'http://localhost:3000/api');
    });
    describe('Test client', function(){
      it('initialize Spore client', function(){
        return expect(this.client.isReady).toBe(true);
      });
      it('log basic infos', function(){
        this.client.logBasicInfos();
        return expect(true).toBe(true);
      });
      it('check client base attrs', function(){
        expect(this.client.url).toBe('/base/data/description.json');
        expect(this.client.baseUrl).toBe('http://localhost:3000/api');
        expect(this.client.description.name).toBe('TEST API');
        expect(this.client.description.authority).toBe('Unistra:DI');
        expect(this.client.description.base_url).toBe('http://localhost:3000/api');
        expect(this.client.description.formats[0]).toBe("json");
        expect(this.client.description.authentication).toBe(true);
        expect(this.client.description.version).toBe("1.0.0");
        expect(this.client.description.meta.documentation).toBe("");
        return expect(this.client.description.meta.authors).toBe("dip unistra");
      });
      it('check client methods specs add product', function(){
        expect(this.client.description.methods.add_product != null).toBe(true);
        expect(this.client.description.methods.add_product.path).toBe("/products");
        expect(this.client.description.methods.add_product.required_params.length).toBe(0);
        expect(this.client.description.methods.add_product.optional_params.length).toBe(0);
        expect(this.client.description.methods.add_product.required_payload).toBe(true);
        expect(this.client.description.methods.add_product.method).toBe("POST");
        expect(this.client.description.methods.add_product.authentication).toBe(true);
        expect(this.client.description.methods.add_product.documentation).toBe("Add a product");
        expect(this.client.methodsEnv.add_product.REQUEST_METHOD).toBe("POST");
        expect(this.client.methodsEnv.add_product.SERVER_NAME).toBe("localhost");
        expect(this.client.methodsEnv.add_product.SERVER_PORT).toBe(3000);
        expect(this.client.methodsEnv.add_product.SCRIPT_NAME).toBe("/api");
        expect(this.client.methodsEnv.add_product.PATH_INFO).toBe("/products");
        expect(this.client.methodsEnv.add_product.QUERY_STRING).toBe("");
        expect(this.client.methodsEnv.add_product.spore.expected_status.length).toBe(0);
        expect(this.client.methodsEnv.add_product.spore.authentication).toBe(true);
        expect(Object.keys(this.client.methodsEnv.add_product.spore.params).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.add_product.spore.payload).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.add_product.spore.errors).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.add_product.spore.headers).length).toBe(0);
        expect(this.client.methodsEnv.add_product.spore.formats).toBe(void 8);
        return expect(this.client.methodsEnv.add_product.spore.scheme).toBe("http");
      });
      it('check client methods specs get products', function(){
        expect(this.client.description.methods.get_products != null).toBe(true);
        expect(this.client.description.methods.get_products.path).toBe("/products");
        expect(this.client.description.methods.get_products.required_params.length).toBe(0);
        expect(this.client.description.methods.get_products.optional_params.length).toBe(3);
        expect(this.client.description.methods.get_products.required_payload).toBe(void 8);
        expect(this.client.description.methods.get_products.method).toBe("GET");
        expect(this.client.description.methods.get_products.authentication).toBe(true);
        expect(this.client.description.methods.get_products.documentation).toBe("Get products");
        expect(this.client.methodsEnv.get_products.REQUEST_METHOD).toBe("GET");
        expect(this.client.methodsEnv.get_products.SERVER_NAME).toBe("localhost");
        expect(this.client.methodsEnv.get_products.SERVER_PORT).toBe(3000);
        expect(this.client.methodsEnv.get_products.SCRIPT_NAME).toBe("/api");
        expect(this.client.methodsEnv.get_products.PATH_INFO).toBe("/products");
        expect(this.client.methodsEnv.get_products.QUERY_STRING).toBe("");
        expect(this.client.methodsEnv.get_products.spore.expected_status.length).toBe(0);
        expect(this.client.methodsEnv.get_products.spore.authentication).toBe(true);
        expect(Object.keys(this.client.methodsEnv.get_products.spore.params).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.get_products.spore.payload).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.get_products.spore.errors).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.get_products.spore.headers).length).toBe(0);
        expect(this.client.methodsEnv.get_products.spore.formats).toBe(void 8);
        return expect(this.client.methodsEnv.get_products.spore.scheme).toBe("http");
      });
      it('check client methods specs get product', function(){
        expect(this.client.description.methods.get_product != null).toBe(true);
        expect(this.client.description.methods.get_product.path).toBe("/products/:id");
        expect(this.client.description.methods.get_product.required_params.length).toBe(1);
        expect(this.client.description.methods.get_product.optional_params.length).toBe(0);
        expect(this.client.description.methods.get_product.required_payload).toBe(void 8);
        expect(this.client.description.methods.get_product.method).toBe("GET");
        expect(this.client.description.methods.get_product.authentication).toBe(true);
        expect(this.client.description.methods.get_product.documentation).toBe("Get one product");
        expect(this.client.methodsEnv.get_product.REQUEST_METHOD).toBe("GET");
        expect(this.client.methodsEnv.get_product.SERVER_NAME).toBe("localhost");
        expect(this.client.methodsEnv.get_product.SERVER_PORT).toBe(3000);
        expect(this.client.methodsEnv.get_product.SCRIPT_NAME).toBe("/api");
        expect(this.client.methodsEnv.get_product.PATH_INFO).toBe("/products/:id");
        expect(this.client.methodsEnv.get_product.QUERY_STRING).toBe("");
        expect(this.client.methodsEnv.get_product.spore.expected_status[0]).toBe(404);
        expect(this.client.methodsEnv.get_product.spore.authentication).toBe(true);
        expect(Object.keys(this.client.methodsEnv.get_product.spore.params).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.get_product.spore.payload).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.get_product.spore.errors).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.get_product.spore.headers).length).toBe(0);
        expect(this.client.methodsEnv.get_product.spore.formats).toBe(void 8);
        return expect(this.client.methodsEnv.get_product.spore.scheme).toBe("http");
      });
      it('check client methods specs delete product', function(){
        expect(this.client.description.methods.delete_product != null).toBe(true);
        expect(this.client.description.methods.delete_product.path).toBe("/products/:id");
        expect(this.client.description.methods.delete_product.required_params.length).toBe(1);
        expect(this.client.description.methods.delete_product.optional_params.length).toBe(0);
        expect(this.client.description.methods.delete_product.required_payload).toBe(void 8);
        expect(this.client.description.methods.delete_product.method).toBe("DELETE");
        expect(this.client.description.methods.delete_product.authentication).toBe(true);
        expect(this.client.description.methods.delete_product.documentation).toBe("delete one product");
        expect(this.client.methodsEnv.delete_product.REQUEST_METHOD).toBe("DELETE");
        expect(this.client.methodsEnv.delete_product.SERVER_NAME).toBe("localhost");
        expect(this.client.methodsEnv.delete_product.SERVER_PORT).toBe(3000);
        expect(this.client.methodsEnv.delete_product.SCRIPT_NAME).toBe("/api");
        expect(this.client.methodsEnv.delete_product.PATH_INFO).toBe("/products/:id");
        expect(this.client.methodsEnv.delete_product.QUERY_STRING).toBe("");
        expect(this.client.methodsEnv.delete_product.spore.expected_status.length).toBe(0);
        expect(this.client.methodsEnv.delete_product.spore.authentication).toBe(true);
        expect(Object.keys(this.client.methodsEnv.delete_product.spore.params).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.delete_product.spore.payload).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.delete_product.spore.errors).length).toBe(0);
        expect(Object.keys(this.client.methodsEnv.delete_product.spore.headers).length).toBe(0);
        expect(this.client.methodsEnv.delete_product.spore.formats).toBe(void 8);
        return expect(this.client.methodsEnv.delete_product.spore.scheme).toBe("http");
      });
      describe('No token', function(){
        beforeAll(function(done){
          var this$ = this;
          return this.client.methods.add_product({
            payload: {
              name: "voiture",
              sku: "206",
              price: 10000
            }
          }, function(response){
            this$.routePost = response;
            return done();
          }, function(error){});
        });
        it('No token add product', function(){
          return expect(this.routePost.error).toEqual("No credentials sent!");
        });
      });
      describe('Wrong token', function(){
        beforeAll(function(done){
          var this$ = this;
          this.client.enable(SporeMiddlewareAuthApiKey, {
            key_name: "Authorization",
            key_value: "Token WRONG"
          });
          return this.client.methods.add_product({
            payload: {
              name: "voiture",
              sku: "206",
              price: 10000
            }
          }, function(response){
            this$.routePost = response;
            return done();
          }, function(error){});
        });
        it('No token add product', function(){
          return expect(this.routePost.error).toEqual("Wrong token");
        });
      });
      it('enable middleware', function(){
        this.client.enable(SporeMiddlewareAuthApiKey, {
          key_name: "Authorization",
          key_value: "Token S3CR3T"
        });
        expect(this.client.middlewares[1].middlewareClass.name).toBe("SporeMiddlewareAuthApiKey");
        expect(this.client.middlewares[1].params.key_name).toBe("Authorization");
        return expect(this.client.middlewares[1].params.key_value).toBe("Token S3CR3T");
      });
      describe('Test add product', function(){
        beforeAll(function(done){
          var this$ = this;
          return this.client.methods.add_product({
            payload: {
              name: "voiture",
              sku: "206",
              price: 10000
            }
          }, function(response){
            this$.routePost = response;
            return done();
          }, function(error){});
        });
        it('add product', function(){
          expect(this.routePost.name).toEqual("voiture");
          expect(this.routePost.sku).toEqual("206");
          return expect(this.routePost.price).toEqual(10000);
        });
        describe('Test get products', function(){
          beforeAll(function(done){
            var this$ = this;
            return this.client.methods.get_products({
              name: "voiture"
            }, function(response){
              this$.routeGetList = response;
              return done();
            }, function(error){});
          });
          it('get products', function(){
            expect(this.routeGetList.length).toBeGreaterThan(0);
            expect(this.routeGetList[0].name).toEqual("voiture");
            expect(this.routeGetList[0].sku).toEqual("206");
            return expect(this.routeGetList[0].price).toEqual(10000);
          });
        });
        describe('Test get one product', function(){
          beforeAll(function(done){
            var this$ = this;
            return this.client.methods.get_product({
              id: this.routePost._id
            }, function(response){
              this$.routeGetOne = response;
              return done();
            }, function(error){});
          });
          it('get one product', function(){
            expect(this.routeGetOne.name).toEqual("voiture");
            expect(this.routeGetOne.sku).toEqual("206");
            return expect(this.routeGetOne.price).toEqual(10000);
          });
        });
        describe('Test delete product', function(){
          beforeAll(function(done){
            var this$ = this;
            return this.client.methods.delete_product({
              id: this.routePost._id
            }, function(response){
              this$.routeDeleteOne = response;
              return done();
            }, function(error){});
          });
          it('delete one product', function(){
            return expect(this.routeDeleteOne).toEqual('');
          });
        });
        describe('Test 404 one product expected', function(){
          beforeAll(function(done){
            var this$ = this;
            return this.client.methods.get_product({
              id: "58986ddb9e7548077551d16f"
            }, function(response){
              this$.routeGetOneExpectedNotFound = response;
              return done();
            }, function(error){});
          });
          it('get one product 404', function(){
            return expect(this.routeGetOneExpectedNotFound.error).toEqual(undefined);
          });
        });
        describe('Test delete 404 one product unexpected', function(){
          beforeAll(function(done){
            var this$ = this;
            return this.client.methods.delete_product({
              id: "58986ddb9e7548077551d16f"
            }, function(response){}, function(error){
              this$.routeDeleteOneUnexpectedNotFound = error;
              return done();
            });
          });
          it('delete one product 404', function(){
            return expect(this.routeDeleteOneUnexpectedNotFound.error).toEqual('Spore error 404 Not Found: {"status":404,"message":"Object not found","name":"ObjectNotFound","errors":{"_id":{"message":"Could not find object with specified attributes"}}}');
          });
        });
      });
    });
  });
}).call(this);
