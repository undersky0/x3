[![Gem](https://img.shields.io/gem/v/databound.svg?style=flat-square)](https://rubygems.org/gems/databound)
[![Bower](https://img.shields.io/bower/v/databound.svg?style=flat-square)](http://bower.io/search/?q=databound)
[![npm](https://img.shields.io/npm/v/databound.svg?style=flat-square)](https://www.npmjs.com/package/databound)
[![Code Climate](http://img.shields.io/codeclimate/github/Nedomas/databound.svg?style=flat-square)](https://codeclimate.com/github/Nedomas/databound)
[![Build Status](http://img.shields.io/travis/Nedomas/databound.svg?style=flat-square)](https://travis-ci.org/Nedomas/databound)]

![Databound](https://cloud.githubusercontent.com/assets/1877286/4743542/df89dcec-5a28-11e4-9114-6f383fe269cb.png)

Provides Javascript a simple CRUD API to the Ruby on Rails backend.

**Check out live examples on the Databound website** [databound.me](http://databound.me).

**Backend gem repo** [github.com/Nedomas/databound-rails](http://github.com/Nedomas/databound-rails).

## Usage

```js
  User = new Databound('/users')

  User.where({ name: 'John' }).then(function(users) {
    alert('Users called John');
  });

  User.find(15).then(function(user) {
    alert('User no. 15: ' + user.name);
  });

  User.create({ name: 'Peter' }).then(function(user) {
    alert('I am ' + user.name + ' from database');
  });
```

[More API docs](http://nedomas.github.io/databound/src/databound.html)

## Version support and dependencies

Works with:
- Ruby on Rails **3+**
- Ruby **2.0+**
- It can work with **Angular** as a better **ngResource** alternative
- [Rails API](https://github.com/rails-api/rails-api)
- ActiveRecord or Mongoid
- [Active Model Serializers](https://github.com/rails-api/active_model_serializers)
- Chrome **any**, Firefox **any**, Opera **any**, IE **8+**

Depends on:
- Lodash (should work with any version)
- jQuery **1.5+**

jQuery is used for making requests and promises. 
You can use your own library instead. Read [API docs](http://nedomas.github.io/databound/src/databound.html) on how to override those.

## Installation

**1 - Gemfile**
```ruby
gem 'databound', '3.0.3'
```

**2.1 - With asset pipeline (sprockets)**

Run generator to add Databound to application.js
```sh
rails g databound:install
```

**2.2 - Without asset pipeline**

Download the [databound-standalone.js](https://raw.githubusercontent.com/Nedomas/databound/master/dist/databound-standalone.js) and load it up
```html
<script src='assets/databound-standalone.js'></script>
```

**2.3 - With require.js**

Download Javascript part with [npm](http://npmjs.com) or [bower](bower.io)

```sh
npm install databound
```

OR

```sh
bower install databound
```

Require it Javascript with:
```javascript
var Databound = require('databound');
```

**3 - Add a route to config/routes.rb**
```ruby
Rails.application.routes.draw do
  databound :users, columns: [:name, :city]
end
```

**4 - *(optional)* Controller is autogenerated from route**

But if you already have a controller, you can include Databound and specify the model yourself.
```ruby
class UsersController < ApplicationController
  databound do
    model :user
    columns :name, :city
  end
end
```

**5 - Install dependencies (skip if with ``require.js``)**

Easiest way is to use the official Ruby gems or include them from CDNs.

**Lo-Dash** - [lodash-rails gem](https://github.com/rh/lodash-rails) or [CDN](http://cdnjs.com/libraries/lodash.js).

**jQuery** *(already installed by default on Rails)* - [jquery-rails gem](https://github.com/rails/jquery-rails) or [CDN](https://code.jquery.com)

**6 - Use it in the Javascript**
```javascript
var User = new Databound('/users');
```

## Security

**Which parts can Javascript modify?**

Specify ``columns``.

By default - no columns are modifiable.

**How to secure the relation values?**

You can use ``dsl(:your_column, :expected_value)`` to only allow certain dsl values and convert them to relation ids in the backend.

**How to protect the scope of the records?**

If you need a reference to the record being modified, use ``permit``. It will give you a parsed record.

It also works with 3rd party libraries.

```ruby
class ProjectsController < ApplicationController
  databound do
    model :project
    columns :name, :city

    # CanCanCan gem
    permit(:create) do
      authorize! :create, current_user
    end

    # Pundit
    permit(:update) do
      authorize current_user
    end

    # Plain Ruby
    permit(:destroy) do
      current_user.god?
    end
  end
end
```

**Which parts can Javascript show?**

Use [Active Model Serializers](https://github.com/rails-api/active_model_serializers) to serialize the record.

If you don't want to use that, you can overwrite ``as_json`` method on the model.

## Contributing :heart:

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
6. Get ice cream :ice_cream:

## Changelog

**Next release**

* Better Javascript error messages.
* ``.all`` method.
* Associations.
* Your contribution here.

**3.0.3** - 2015-01-09
* Fix bootup of a default Rails stack in production with ``databound`` and ``eager_load``

**3.0.2** - 2015-01-08
* ``read`` action of ``permit`` returning ``false`` now returns empty scoped records

**3.0.1** - 2015-01-08
* Minor bugfix

**3.0.0** - 2015-01-08

* Simplify configuration setup and improve performance.
* Thanks to [@Austio](https://github.com/Austio) for docs on 3rd party authentication libraries.

```ruby
class ProjectsController < ApplicationController
  databound do
    model :project
    columns :name, :city
  end
end
```

**2.0.1** - 2015-01-03

* Add support for specifying ``permitted_columns`` in ``routes.rb``. No columns are modifiable by default.

**1.1.0** - 2015-01-03

* You can specify ``permit_update_destroy?`` on a controller to manage the scope of the records that can be modified from the Javascript.

**1.0.0** - 2015-01-03

* Destroy now accepts ``id`` instead of ``{ id: someid }``.
* ``extra_find_scopes`` renamed to ``extra_where_scopes``

## Used and sponsored by

[![SameSystem](https://cloud.githubusercontent.com/assets/1877286/5602104/d8e44986-933f-11e4-8e64-b0c8e83a94d1.jpg)](http://samesystem.com) [![picnic-right](https://cloud.githubusercontent.com/assets/1877286/5602105/dab01272-933f-11e4-9aab-624ba81825d9.png)](http://spacepicnic.net)