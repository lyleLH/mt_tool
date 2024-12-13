# MtTool

A Ruby gem for generating VIPER architecture modules for iOS projects. Supports both Swift and Objective-C.

<img src="img/69786f8e2a527b8c26f2c1311e230e5f.webp.png" alt="Module File Generator" height="150" width="150">

## Features

- Generate complete VIPER module structure
- Support for both Swift and Objective-C
- Customizable templates
- Command-line interface
- Detailed logging for debugging

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mt_tool'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install mt_tool
```

## Usage

### Generating a VIPER Module

```bash
# Generate a VIPER module
mt_tool vmod -n ModuleName -a "Author Name" -p ./path/to/module

# Example
mt_tool vmod -n HomeScreen -a "Tom Liu" -p ./Modules
```

### Command Options

- `-n, --name`: Module name (required)
- `-a, --author`: Author name (required)
- `-p, --path`: Target path for generation (required)

### Generated Structure

```
ModuleName/
├── ModuleNameEntity.swift
├── ModuleNameInteractor.swift
├── ModuleNamePresenter.swift
├── ModuleNameRouter.swift
└── ModuleNameViewController.swift
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

To run the test suite:
```bash
bundle exec rake test
```

To install this gem onto your local machine:
```bash
bundle exec rake install
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Add tests for your changes
4. Make your changes
5. Run the tests (`bundle exec rake test`)
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin feature/my-new-feature`)
8. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MtTool project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lylelh/mt_tool/blob/master/CODE_OF_CONDUCT.md).
