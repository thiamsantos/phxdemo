define({ "api": [
  {
    "type": "get",
    "url": "/user/:id",
    "title": "Request User information",
    "name": "GetUser",
    "group": "User",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>Users unique ID.</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "Number",
            "optional": false,
            "field": "id",
            "description": "<p>User unique ID.</p>"
          },
          {
            "group": "Success 200",
            "type": "Number",
            "optional": false,
            "field": "age",
            "description": "<p>Age of the User.</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "name",
            "description": "<p>Name of the User.</p>"
          }
        ]
      }
    },
    "version": "0.0.0",
    "filename": "lib/phxdemo_web/controllers/user_controller.ex",
    "groupTitle": "User"
  }
] });