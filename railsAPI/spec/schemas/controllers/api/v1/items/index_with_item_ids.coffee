type: "object"
properties:
  items:
    type: "array"
    minItems: 3
    maxItems: 3
    items: {$ref: "../definitions.json#/item"}
