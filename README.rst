ls-spore
=========

.. image:: https://travis-ci.org/unistra/ls-spore.svg?branch=master
    :target: https://travis-ci.org/unistra/ls-spore

A client-side livescript/javascript spore client


Usage
=====
Include and use "spore-client.min.js".

Example :

.. code-block:: html

    <!DOCTYPE html>
    <html>
    <head>
        <title>ls-spore example</title>
        <script src="build/spore-client.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            s = new Spore("http://serverurl/spore-description.json", function(){
            if (s.isReady) {
              s.enable(SporeMiddlewareAuthApiKey, {key_name:"Authorization", key_value:"Token S3CR3T"});
              s.logBasicInfos()

              s.methods.get_user({
                format: "json",
                username: "toto"
              }, function(response){
                console.log("Recuperation de toto ... :");
                return console.log(response);
              }, 
              function(){
                console.log("Error with the spore method");
              });
            }
          },
          function(){
            console.log("Error with the spore client creation");
          },
          base_url = "http://127.0.0.1:8000");
        </script>
    </head>
    <body>
    </body>
    </html>


Developement
============

Use Livescript
--------------
use the following lines to compile livescript to javascript :

.. code-block:: bash

    sudo npm install -g LiveScript
    lsc -wc src/ls/*.ls -o src/js/
    lsc -wc test/ls/*.ls -o test/js/

use the following line to create a minified JS

.. code-block:: bash

    sudo npm install -g uglify-js
    uglifyjs src/js/request.js src/js/middleware.js src/js/spore.js -o build/spore-client.min.js


Unit test with karma
--------------------
Install nodejs and mongodb :

.. code-block:: bash

    sudo apt-get install nodejs npm
    sudo apt-get install mongodb

Run a test WS and install and run karma :

.. code-block:: bash

    cd test
    sudo npm install
    npm start
    npm test


Implemented
-----------

* base_url
* description
* version
* authority
* meta
* name
* methods
* methods -> name
* methods -> path
* methods -> required_params
* methods -> optional_params
* methods -> headers
* methods -> base_url
* methods -> payload
* methods -> required_payload
* create spore client
* url for description file
* enable middleware
* middleware auth by token


Not Implemented
---------------

* expected_status (currently, always 200)
* authentication (currently, depends of headers)
* unattended_params
* formats (currently, only JSON)
* methods -> expected_status
* methods -> form-data
* methods -> optional_payload
* methods -> unattended_params
* methods -> description
* methods -> deprecated
* methods -> authentication
* methods -> formats (currently, only JSON)
* enable if middleware
* disable middleware


TODO
----

* put client's meta data in a _meta variable and remove methods variable
* be more livescript idiomatic



