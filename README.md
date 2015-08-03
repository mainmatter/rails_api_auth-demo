# Rails API Auth Demo

This is a demo application for the
[rails_api_auth engine](https://github.com/simplabs/rails_api_auth).

## Setup

Install the demo application with

```bash
git clone git@github.com:simplabs/rails_api_auth-demo.git
cd rails_api_auth-demo
rake db:migrate
```

## Usage

### Resource Owner Password Credentials Grant

The _"Resource Owner Password Credentials Grant"_ OAuth 2.0 flow allows users
to __acquire a Bearer token from the application in exchange for their
credentials__ (`username` and `password`). This is the simplest OAuth 2.0 flow
and the one used by most client applications that authenticate against their
own companion API.

To acquire a Bearer token from the application you first need to __create a
`Login` model__ that stores the credentials as well as the Bearer token:

```bash
rails console
```

```ruby
Login.create!(email: '<some-email-address>', password: '<some-password>', password_confirmation: '<some-password>')
```

The Bearer token is assigned as a random string automatically when the `Login`
model is created.

Start the Rails server:

```bash
rails server
```

You can then use these credentials to acquire a Bearer token from the
application:

```bash
curl -d "grant_type=password&username=email%40test.com&password=test" "http://localhost:3000/token"
{"access_token":"<some token>"}%
```

With that Bearer token you can then request the application's `authenticated`
route that requires the presence of a Bearer token in the request in order to
be accessible:

```bash
curl -i -H "Authorization: Bearer <some token>" "http://localhost:3000/authenticated"
HTTP/1.1 200 OK 
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
Content-Type: text/html; charset=utf-8
Etag: W/"a79738749bc447f17b58b2936a48b606"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 8af79fb0-77ee-446b-b09f-761ba43da64d
X-Runtime: 0.010946
Server: WEBrick/1.3.1 (Ruby/2.2.1/2015-02-26)
Date: Wed, 15 Jul 2015 09:00:13 GMT
Content-Length: 20
Connection: Keep-Alive

{"success":true}%
```

When omitting the Bearer token or send an invalid one the route isn't
accessible and will respond with HTTP status 401:

```bash
curl -i "http://localhost:3000/authenticated"
HTTP/1.1 401 Unauthorized 
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
Content-Type: text/html
Cache-Control: no-cache
X-Request-Id: a2094bf9-28e4-45e4-99c0-ece3d170e8e3
X-Runtime: 0.002080
Server: WEBrick/1.3.1 (Ruby/2.2.1/2015-02-26)
Date: Wed, 15 Jul 2015 09:01:42 GMT
Content-Length: 0
Connection: Keep-Alive
```

### Facebook authentication

The __application also allows authentication with a Facebook account__. To
authenticate with your Facebook account you __first need to acquire an
authentication code for the _"Rails API Auth Demo"_ Facebook application__ from
Facebook (in a real client application, the user would be redirected there or
would see this page in a popup):

```
https://www.facebook.com/dialog/oauth?client_id=708377659294239&scope=public_profile,email&redirect_uri=http://localhost:3000/
```

After granting access to the application, you will be redirected to your
application with an auth code appended to the URL (in a real client application,
the client would intercept that redirect and read the auth code from the URL).

```
http://localhost:3000/?code=<auth code>
```

You can now __use the auth code to acquire a Bearer token from the Rails
application__. The Rails application will validate the auth code with
Facebook's API:

```bash
curl -d "grant_type=facebook_auth_code&auth_code=<auth code>" "http://localhost:3000/token"
{"access_token":"<some token>"}%
```

That Bearer token can be used then to request the authenticated route in the
Rails app like above:

```bash
curl -i -H "Authorization: Bearer eb7f3ab26a39eec0cdda82803e6f225d70ecad4cb719d801b826ba84555c2e8698f630bca20639f0ea79b29fe99ab7c7a3d781fc9c0696dc17a7f36bf1faac2ed44d9704161ab29715c7054177e35f49a4fd7bbc8e6b4eeb40e2ab362b82f5f337f7df4739fa1366ac7d1fce38429cbfec45c85831564bdd5647537d9b" "http://localhost:3000/authenticated"
HTTP/1.1 200 OK 
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
Content-Type: text/html; charset=utf-8
Etag: W/"a79738749bc447f17b58b2936a48b606"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 8af79fb0-77ee-446b-b09f-761ba43da64d
X-Runtime: 0.010946
Server: WEBrick/1.3.1 (Ruby/2.2.1/2015-02-26)
Date: Wed, 15 Jul 2015 09:00:13 GMT
Content-Length: 20
Connection: Keep-Alive

{"success":true}%
```

## License

This application is developed by and &copy;
[simplabs GmbH](http://simplabs.com) and contributors. It is released under the
[MIT License](https://github.com/simplabs/ember-simple-auth/blob/master/LICENSE).
