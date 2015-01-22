// Generated by LiveScript 1.3.1
(function(){
  var SporeMethodsFactory, Spore, out$ = typeof exports != 'undefined' && exports || this;
  SporeMethodsFactory = (function(){
    SporeMethodsFactory.displayName = 'SporeMethodsFactory';
    var prototype = SporeMethodsFactory.prototype, constructor = SporeMethodsFactory;
    prototype.createMethod = function(name, methodSpecs, middlewares){
      var method;
      method = function(params, callable){
        var popPayload, checkRequireParams, checkWrongParams, applyMiddlewares, addParams, addPayload, addHeaders, payload, finalEnv, request;
        popPayload = function(){
          var payload;
          payload = params.payload != null
            ? params.payload
            : {};
          delete params.payload;
          if (methodSpecs.required_payload && (not$(params.payload != null) || (params.payload = ""))) {
            window.console.error("Spore error: payload is required");
          }
          return payload;
        };
        checkRequireParams = function(){
          var checkRequiredParams, res$, i$, ref$, len$, k;
          res$ = [];
          for (i$ = 0, len$ = (ref$ = methodSpecs.requiredParams).length; i$ < len$; ++i$) {
            k = ref$[i$];
            res$.push(k);
          }
          checkRequiredParams = res$;
          for (i$ = 0, len$ = (ref$ = methodSpecs.requiredParams).length; i$ < len$; ++i$) {
            k = ref$[i$];
            if (params[k] != null) {
              checkRequiredParams.pop(k);
            }
          }
          return checkRequiredParams.length === 0;
        };
        checkWrongParams = function(){
          var check, k, ref$, v;
          check = true;
          for (k in ref$ = params) {
            v = ref$[k];
            if (methodSpecs.requiredParams.indexOf(k) > -1 || methodSpecs.optionalParams.indexOf(k) > -1) {
              continue;
            } else {
              check = false;
            }
          }
          return check;
        };
        applyMiddlewares = function(){
          var i$, ref$, len$, m, middlewareInstance, results$ = [];
          methodSpecs.env.spore.headers = {};
          for (i$ = 0, len$ = (ref$ = middlewares).length; i$ < len$; ++i$) {
            m = ref$[i$];
            middlewareInstance = new m['middlewareClass'](m['params']);
            results$.push(middlewareInstance.call(methodSpecs.env));
          }
          return results$;
        };
        addParams = function(){
          return methodSpecs.env.spore.params = params;
        };
        addPayload = function(payload){
          return methodSpecs.env.spore.payload = payload;
        };
        addHeaders = function(){
          var k, ref$, v, results$ = [];
          for (k in ref$ = methodSpecs.headers) {
            v = ref$[k];
            if (not$(methodSpecs.env.spore.headers[k] != null)) {
              results$.push(methodSpecs.env.spore.headers[k] = v);
            }
          }
          return results$;
        };
        payload = popPayload();
        if (checkRequireParams && checkWrongParams) {
          applyMiddlewares();
          addParams();
          addPayload(payload);
          addHeaders();
          finalEnv = methodSpecs.env;
          request = new SporeRequest(finalEnv);
          return request.call(callable);
        } else {
          return window.console.error("Spore error: wrong parameters of " + name);
        }
      };
      return method;
    };
    function SporeMethodsFactory(){}
    return SporeMethodsFactory;
  }());
  Spore = (function(){
    Spore.displayName = 'Spore';
    var prototype = Spore.prototype, constructor = Spore;
    function Spore(url, callback, base_url){
      base_url == null && (base_url = void 8);
      this.url = url;
      this.baseUrl = base_url;
      this.isReady = false;
      this.description = {};
      this.create(callback);
      this.methods = {};
      this.methodsSpecs = {};
      this.middlewares = [];
    }
    prototype.create = function(callback){
      var xhr, this$ = this;
      xhr = new XMLHttpRequest;
      xhr.open('GET', this.url, true);
      if (in$('overrideMimeType', xhr)) {
        xhr.overrideMimeType('application/json');
      }
      xhr.onreadystatechange = function(){
        var ref$, myJson, e;
        if (xhr.readyState === 4) {
          if ((ref$ = xhr.status) === 200 || ref$ === 0) {
            try {
              myJson = JSON.parse(xhr.responseText);
              this$._callCallback(myJson, callback);
            } catch (e$) {
              e = e$;
              window.console.error("Spore error: cannot parse json description file");
            }
          } else {
            window.console.error("Spore error: " + xhr.status + " " + xhr.statusText);
          }
        }
      };
      xhr.send(null);
      return xhr;
    };
    prototype.enable = function(middlewareClass, params){
      return this.middlewares.push({
        middlewareClass: middlewareClass,
        params: params
      });
    };
    prototype.enableIf = function(middlewareClass, params){
      return window.console.log("TODO enable if");
    };
    prototype.logBasicInfos = function(){
      window.console.log("Name: " + this.name);
      window.console.log("Base url: " + this.base_url);
      window.console.log("Authority: " + this.authority);
      window.console.log("Formats: " + this.formats);
      window.console.log("Version: " + this.version);
      return window.console.log("Meta: " + JSON.stringify(this.meta));
    };
    prototype._generateMethods = function(methods){
      var myFactory, key, value, results$ = [];
      myFactory = new SporeMethodsFactory();
      for (key in methods) {
        value = methods[key];
        this._generateMethodsSpecs(key, value);
        this._generateMethodsEnv(key, value);
        results$.push(this['methods'][key] = myFactory.createMethod(key, this.methodsSpecs[key], this.middlewares));
      }
      return results$;
    };
    prototype._generateMethodsSpecs = function(methodKey, methodValue){
      var k, v, results$ = [];
      for (k in methodValue) {
        v = methodValue[k];
        if (k !== "env") {
          this.methodsSpecs[methodKey] = {};
          results$.push(this.methodsSpecs[k] = v);
        }
      }
      return results$;
    };
    prototype._generateMethodsEnv = function(methodKey, methodValue){
      var url_parser;
      url_parser = document.createElement('a');
      url_parser.href = this._getBaseUrl(methodKey, methodValue);
      this.methodsSpecs[methodKey].env = {};
      this.methodsSpecs[methodKey].env.REQUEST_METHOD = this._getRequestMethod(methodValue.method);
      this.methodsSpecs[methodKey].env.SERVER_NAME = url_parser.hostname;
      this.methodsSpecs[methodKey].env.SERVER_PORT = this._getServerPort(url_parser);
      this.methodsSpecs[methodKey].env.SCRIPT_NAME = this._getScriptName(url_parser.pathname);
      this.methodsSpecs[methodKey].env.PATH_INFO = this._getPathInfo(this.methodsSpecs[methodKey].env.SCRIPT_NAME, url_parser.pathname, methodValue.path);
      this.methodsSpecs[methodKey].env.QUERY_STRING = "";
      this.methodsSpecs[methodKey].env.spore = {};
      this.methodsSpecs[methodKey].env.spore.expected_status = methodValue.expected_status;
      this.methodsSpecs[methodKey].env.spore.authentication = methodValue.authentication != null ? methodValue.authentication : false;
      this.methodsSpecs[methodKey].env.spore.params = {};
      this.methodsSpecs[methodKey].env.spore.payload = {};
      this.methodsSpecs[methodKey].env.spore.errors = {};
      this.methodsSpecs[methodKey].env.spore.headers = {};
      this.methodsSpecs[methodKey].env.spore.formats = methodValue.formats;
      return this.methodsSpecs[methodKey].env.spore.scheme = url_parser.protocol.split(":")[0];
    };
    prototype._getPathInfo = function(script_name, pathname, method_path){
      var res;
      res = "";
      if (script_name != null && script_name !== "") {
        res = pathname.replace(script_name, "");
      } else {
        res = pathname;
      }
      if (res === "/") {
        res = "";
      }
      res += method_path;
      return res;
    };
    prototype._getRequestMethod = function(method){
      if (method != null && method !== "") {
        return method;
      } else {
        return "GET";
      }
    };
    prototype._getScriptName = function(pathname){
      var slice;
      if (pathname != null && pathname !== "") {
        slice = pathname.split("/", 2).slice(1);
        if (slice[0] != null && slice[0] !== "") {
          return "/" + slice[0];
        } else {
          return "";
        }
      }
    };
    prototype._getServerPort = function(url_parser){
      var port;
      port = 80;
      if (url_parser.port != null && url_parser.port !== "") {
        port = parseInt(url_parser.port);
      } else if (url_parser.protocol === "https:") {
        port = 443;
      }
      return port;
    };
    prototype._generateBasics = function(description){
      var key, value, results$ = [];
      for (key in description) {
        value = description[key];
        if (key !== 'methods') {
          results$.push(this[key] = value);
        }
      }
      return results$;
    };
    prototype._callCallback = function(response, callback){
      this.description = response;
      this._generateMethods(this.description.methods);
      this._generateBasics(this.description);
      this.isReady = true;
      return callback();
    };
    prototype._getBaseUrl = function(key, value){
      if (this.baseUrl != null) {
        return this.baseUrl;
      } else if (value.base_url != null) {
        return value.base_url;
      } else if (this.description.base_url != null) {
        return this.description.base_url;
      } else {}
    };
    return Spore;
  }());
  out$.Spore = Spore;
  function not$(x){ return !x; }
  function in$(x, xs){
    var i = -1, l = xs.length >>> 0;
    while (++i < l) if (x === xs[i]) return true;
    return false;
  }
}).call(this);