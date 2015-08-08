type: "object"
properties:
  items:
    type: "array"
    minItems: 3
    maxItems: 3
    items:
      type: "object"
      properties:
        id:          {type: "integer"}
        word:        {type: "string"}
        sentence:    {type: "string"}
        meaning:     {type: "string"}
        picture:     {type: "uri"}
        created_at:  {type: "date-time"}
        updated_at:  {type: "date-time"}
        category:
          type: "object"
          properties:
            id:          {type: "integer"}
            name:        {type: "string"}
            description: {type: "string"}
            created_at:  {type: "date-time"}
            updated_at:  {type: "date-time"}
            user:
              type: "object"
              properties:
                id:          {type: "integer"}
                email:       {type: "string"}
                created_at:  {type: "date-time"}
                updated_at:  {type: "date-time"}
                auth_token:  {type: "string"}
                category_ids:
                  type: "array"
                  minItems: 1
                  maxItems: 1
                  items:
                    type: "integer"
