# DocxManagerClient

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docx_manager_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install docx_manager_client

## Usage

lets say you have `fancy_template_type` defined in your ``docx_manager_server``

to get access to customize `fancy_template_type` add the below to template model:
**optional
```ruby
docx_template template_type: :fancy_template
```
then pass the new template file to ur model attribute `fancy_template_type_docx_file` and save



and in the model of document stamp add the below:
```ruby
belongs_to_docx_template name: :my_document, belongs_to: :model_template, template_type: :fancy_template_type

def fancy_template_type_docx_hash
  {
    name: 'sabri jameel',
    age:  '99'
  }
```

after that you can access the generated documents using the below instance methods:

```ruby
my_document_docx_path

my_document_pdf_path

my_document_png_path
```

the below is the save/delete callbacks
```ruby
post_my_document_docx

delete_my_document_docx
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/baderSader/docx_manager_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/baderSader/docx_manager_client/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the DocxManagerClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/docx_manager_client/blob/master/CODE_OF_CONDUCT.md).
