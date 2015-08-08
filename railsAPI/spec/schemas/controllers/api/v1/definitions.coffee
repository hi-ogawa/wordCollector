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
      items: {type: "integer"}
 
category:
  type: "object"
  properties:
    id:          {type: "integer"}
    name:        {type: "string"}
    description: {type: "string"}
    created_at:  {type: "date-time"}
    updated_at:  {type: "date-time"}
    user:        {$ref: "#/user"}

item:
  type: "object"
  properties:
    id:          {type: "integer"}
    word:        {type: "string"}
    sentence:    {type: "string"}
    meaning:     {type: "string"}
    picture:     {type: "uri"}
    created_at:  {type: "date-time"}
    updated_at:  {type: "date-time"}
    category:    {$ref: "#/category"}
