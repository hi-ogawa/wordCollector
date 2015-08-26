type: "object"
properties:
  categories:
    type: "array"
    minItems: 3
    maxItems: 3
    items:
      type: "object"
      properties:
        id:          {type: "integer"}
        name:        {type: "string"}
        description: {type: "string"}
        created_at:  {type: "date-time"}
        updated_at:  {type: "date-time"}
        item_ids:
          type: "array"
          minItems: 0
          maxItems: 0
          items:
            type: "integer"
        user:
          type: "object"
          properties:
            id:          {type: "integer"}
            username:    {type: "string"}
            created_at:  {type: "date-time"}
            updated_at:  {type: "date-time"}
            category_ids:
              type: "array"
              minItems: 3
              maxItems: 3
              items:
                type: "integer"
          
