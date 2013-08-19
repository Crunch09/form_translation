# FormTranslation
[![Code Climate](https://codeclimate.com/github/Crunch09/form_translation.png)](https://codeclimate.com/github/Crunch09/form_translation)

**Not ready, don't use it in production yet.**

It uses `ActiveRecord::Store` to store language specific values and adds
tabs to your forms for each language.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'form_translation', github: 'Crunch09/form_translation'
```

And then execute:

```
$ bundle
$ rails g form_translation:install
```

## Usage

* In your model include `FormTranslation::ForModel* and specify which attributes
should be translated.
```ruby
class Article < ActiveRecord::Base
      include FormTranslation::ForModel

      translate_me :subject, :body
end
```
* Within your `simple_form`-Form specify where to put your translation-tabs
with a `languagify` block.
```erb
<%= simple_form_for(@article) do |f| %>
      <div class="form-inputs">
        <%= f.input :date %>
      </div>
      <div>
        <%= f.languagify do |l| %>
          <%= l.input :subject %>
          <%= l.input :body %>
        <% end %>
      </div>
      <div class="form-actions">
        <%= f.button :submit %>
      </div>
<% end %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
