RailsApiAuth.tap do |raa|
  raa.user_model_relation = :user

  raa.facebook_app_id       = ENV['FACEBOOK_APP_ID']
  raa.facebook_app_secret   = ENV['FACEBOOK_APP_SECRET']
  raa.facebook_graph_url    = 'https://graph.facebook.com'
  raa.facebook_redirect_uri = 'http://localhost:3000/'
end
