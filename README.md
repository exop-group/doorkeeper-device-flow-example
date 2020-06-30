# Doorkeeper Device Flow Example

This repository provides an example Ruby on Rails application implementing
OAuth 2.0 Device Authorization Grant using the [Doorkeeper::DeviceAuthorizationGrant](https://github.com/exop-group/doorkeeper-device_authorization_grant)
gem, along with a simple HTML+JS client to test it.

You can follow the steps below to give it a try.

First clone the repository from GitHub:

```
git clone https://github.com/exop-group/doorkeeper-device-flow-example.git
```

## Rails server

The directory `backend` includes a simple [Rails 6](https://rubyonrails.org/) application.
The most important gems used are:
[Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper),
[Doorkeeper::DeviceAuthorizationGrant](https://github.com/exop-group/doorkeeper-device_authorization_grant),
and [Devise](https://github.com/plataformatec/devise).

Move to the Rails server directory:

```
cd doorkeeper-device-flow-example/backend
```

This Rails app was developed and tested using Ruby 2.7.1, but it _should_ run with some older versions.

Install all dependencies with:

```
bundle install
```

Then setup the database and load the seed data:

```
rails db:setup
```

The project uses sqlite3 by default.

Seed data creates a User with email `user@example.com` and password `doorkeeper`.
A new Doorkeeper Application is also created, called `My Doorkeeper Application`.

Now you can start the Rails server:

```
rails server
```

This runs Rails server on default host and port `localhost:3000`.

Open a browser and navigate to [http://localhost:3000/oauth/applications](http://localhost:3000/oauth/applications).
Log in with the aforementioned user email and password, and click on
`My Doorkeeper Application` to see its details. Here you can find
the `UID`, which is the application client ID we are going to use
in a moment.

### Javascript client

The directory `client` contains a simple client implemented in a single HTML(+JS) file.

In a real scenario, it's likely that client and server run on different systems and/or
devices. Here, to keep it easy, we are going to run everything on the same environment.

Still keeping your Rails server running, open a new terminal and move to:

```
cd doorkeeper-device-flow-example/client
```

Edit the file `index.html`, providing at line `13` the `CONFIG.clientId` property.
You should use the Doorkeeper Application UID that was mentioned before.

Now you should serve this file, to make it accessible from a browser.
Not all browsers are happy to access local files; a quick solution is to
run a simple file server from command line, for example with Ruby:

```
ruby -run -e httpd . -p 3001
```

or Python:

```
python -m http.server 3001
```

or anything else that suits you. In this example we will use the port 3001.

### Testing the device authentication flow

Open a new browser page and navigate to [http://localhost:3001/index.html](http://localhost:3001/index.html).

The Rails server provides a minimal authenticated API endpoint: `/me`.

You can first click on the `Perform API Request`: you are not yet authenticated, so
the API will respond with a `401 Unauthorized` HTTP response.

Let's proceed with the device authentication flow: click on `Perform Device Authorization Request`
and follow the instructions.

Upon successful authentication, the top section will show device access token information.
Now you can try the API request again: click on `Perform API Request` and you should see
a successful response.
