CORS_CONFIG = YAML.load_file(Rails.root.join("config", "cors.yml"))[Rails.env]
