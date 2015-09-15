Rails.application.config.action_dispatch.default_headers = {
  'Access-Control-Allow-Origin' => 'http://hiogawa.word.collector.ng.production.s3-website-ap-northeast-1.amazonaws.com',
  'Access-Control-Request-Method' => %w{GET POST PUT PATCH DELETE}.join(",")
}
