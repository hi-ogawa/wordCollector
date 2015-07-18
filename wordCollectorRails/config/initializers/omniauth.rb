# see here about more options
# https://github.com/zquestz/omniauth-google-oauth2/blob/master/examples/omni_auth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {
    scope: 'email'
  }
end
