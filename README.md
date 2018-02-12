TripSheep
=========

Third Party
===========
This section provides information on internal and third party libraries. Each section should provide a reasoning to why the library was created or choosen and what it provides for the codebase.

### jQuery Rails
[jQuery Rails](https://github.com/rails/jquery-rails) is a gem that provides the latest jQuery libraries
### jQuery UI Rails
[jQuery UI Rails](https://github.com/joliss/jquery-ui-rails) is a gem that packages the jQuery assets (JavaScripts, stylesheets, and images) for the Rails 3.1+ asset pipeline, so you never have to download a custom package through the web interface again.
### Slim
The [slim](http://slim-lang.com/) library is an indentation based templating engine very similar in style and purpose to `haml` although it's more terse. It makes `html` easier to write and read.
### Simple Form
[Simple Form](https://github.com/plataformatec/simple_form) is one abstraction on top of normal rails forms that add some intelligent defaults and customization options that Rails lack. It's also Twitter Bootstrap friendly.
### ClientSideValidations
[ClientSideValidations](https://github.com/bcardarella/client_side_validations) integrates client side validation
### Devise
[Devise](https://github.com/plataformatec/devise/wiki) is a flexible authentication solution for Rails based on Warden.
### Devise OAuth2 Provider
[Devise OAuth2 Provider](https://github.com/socialcast/devise_oauth2_providable) is a gem that integrate OAuth2 authentication with Devise authenthentication stack. 
### Capybara
For our integration tests we use [Capybara](https://github.com/jnicklas/capybara). We considered that Capybara is the thinest layer we can have to reproduce very top level user like interactions. In contrast the alternative tool, Cucumber, adds too much effort and unneeded cost of maintanance when writing features that can be written in a very similar way in plain ruby with Capybara.
### Foreman
The project is currently deployed in [Heroku](http://www.heroku.com) which internally runs `foreman` to read the root's `Procfile` to setup the server and any possible satellite machine we may need (for example in the future we may need to run some workers for background processing). So to keep the local server behavior as closer as we can to the way `heroku` works, it's recommended to run the server through `foreman start` instead of `rails server`. Foreman also has the ability to load `.env` files from your local setup which let's you set global `ENV` variables without needing to polute your local machine with them.
### Konacha
For very granular and detailed javascript integration tests or plain javascript unit tests we are using [Konacha](https://github.com/jfirebaugh/konacha) which is a Rails friendly packaging of [Mocha](http://mochajs.org/) to structure the tests and [Chai](http://chaijs.com/) for mocking and stubbing. You can find examples of its usage in `spec/javascripts`. To run these tests do either a `rake konacha:run` or a `rake konacha:serve`. All the js tests are automatically integrated in our [CircleCI](https://circleci.com) continuous integration server.
### JST and EJS
[JST](https://github.com/sstephenson/sprockets#javascript-templating-with-ejs-and-eco) is the rails assets pipeline way of dealing with javascripts view templates. It's easier to test and integrate with `Konacha` as it doesn't require a dom element to store the templates.
### Google Maps for Rails
[Google Maps for Rails](https://github.com/apneadiving/Google-Maps-for-Rails/wiki) is a gem that provides access to different map providers APIs for geolocation and directions management.
### Acts As List
[ActsAsList](https://github.com/swanandp/acts_as_list) is a gem that provides the capabilities for sorting and reordering a number of objects in a list.
