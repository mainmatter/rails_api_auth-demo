Rails.application.config.x.facebook.tap do |facebook|
  facebook.app_id       = '1621193478128849'
  facebook.app_secret   = 'ccbecae78d3b69bb535dd7afe228a272'
  facebook.graph_url    = 'https://graph.facebook.com/v2.3'
  facebook.redirect_uri = 'http://localhost:4200/login'
end

# https://www.facebook.com/dialog/oauth?client_id=1621193478128849&scope=public_profile,email&redirect_uri=ttp://localhost:4200/login
