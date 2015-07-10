This is a demo application for the [rails_api_auth engine](https://github.com/simplabs/rails_api_auth).

Steps to use it:

```
git clone git@github.com:simplabs/rails_api_auth-demo.git
cd rails_api_auth-demo
rake db:migrate
```

Create a sample Facebook application at [http://developers.facebook.com](http://developers.facebook.com)

Use the credentials to set the `ENV['FB_APP_ID']` and `ENV['FB_APP_SECRET']` variables, which will be used by config/initializers/facebook.rb:

```
Rails.application.config.x.facebook.tap do |facebook|
  facebook.app_id       = ENV['FB_APP_ID']
  facebook.app_secret   = ENV['FB_APP_SECRET']
  facebook.graph_url    = 'https://graph.facebook.com/v2.3'
  facebook.redirect_uri = 'http://localhost:3000'
end
```

And use them also to fetch a temporary `auth_code` to post to our demo. Go to this url on your browser, after replacing FB_APP_ID with your developer app's app id:

```
https://www.facebook.com/dialog/oauth?client_id=FB_APP_ID&scope=public_profile,email&redirect_uri=http://localhost:3000
```

You should get redirected to an url with an access token appended to it, like this one:

```
http://localhost:3000/?code=AQBYzxwK7zVQnHQRmXRHNgIcQlcufxdMaUXt8U2mgqJDXDXu1yNYR...
```

Copy the string after `code=`.

Start-up your rails server:

```
rails s
```

Open [Paw](https://luckymarmot.com/paw) and set it to POST to this url with the above code pasted after `auth_code=`

```
http://localhost:3000/token?grant_type=facebook_auth_code&auth_code=AQBYzxwK7zVQnHQRmXRHNgIcQlcufxdMaUXt8U2mgqJDXDXu1yNYR
```

(You also use `curl` on the command line, if you prefer)

Send the request. You should get an 200 OK response, and a JSON payload like this in the body:

```
{"access_token":"5d54182547509dfc1246cee750e69408c8e1aa7b88ccc16bfab8ac2c4d8aa1723..."}

Finally, use this token to access this demo's protected url:

Set Paw to send a GET request to

```
http://localhost:3000/authenticated
```

With the following header:

```
Authorization: Bearer 5d54182547509dfc1246cee750e69408c8e1aa7b88ccc16bfab8ac2c4d8aa1723... (your token)
```

You should see the response body like this:

```
FB uid 12323123544 is logged in
```

Where 12323123544 a facebook uid.
