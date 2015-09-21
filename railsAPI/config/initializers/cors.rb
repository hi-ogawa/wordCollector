CORS_CONFIG = YAML.load_file(Rails.root.join("config", "cors.yml"))[Rails.env]

Rails.application.config.action_dispatch.default_headers = {
  'Access-Control-Allow-Origin'   => CORS_CONFIG["origin"],
  'Access-Control-Request-Method' => CORS_CONFIG["methods"].join(",")
}
