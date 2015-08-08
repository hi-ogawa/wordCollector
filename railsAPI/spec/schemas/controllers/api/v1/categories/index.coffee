type: "object"
properties:
  categories:
    type: "array"
    minItems: 3
    maxItems: 3
    items:
      $ref: "../definitions.json#/category"
