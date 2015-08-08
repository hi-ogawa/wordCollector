type: "object"
properties:
  items:
    minItems: 3
    items: [
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
                minItems: 1
                items: [
                  type: "integer"
                ]
    ]         
