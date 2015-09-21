# on production, CORS is not handled by rails, but by nginx (via passenger).
# see config/nginx.conf.erb.
if Rails.env == "development"
  CORS_CONFIG = YAML.load_file(Rails.root.join("config", "cors.yml"))[Rails.env]
end
