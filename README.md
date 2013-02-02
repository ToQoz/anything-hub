# AnythingHub

Anything interface for github.
Filter response of Github api with anything interface and open selected one in browser.

**This has not uploaded to rubygems yet**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anything-hub'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install anything-hub
```

## Usage

Put config file.

```ruby
# in ~/.anything-hubrc
AnythingHub.configure do |c|
  c.login "username"    # github username
  c.password "password" # github password
end
```

Now support starred and searching

```sh
$ anything-hub starred:ToQoz
$ anything-hub search:rails
```

If you want to ignore cache

```sh
$ anything-hub starred:ToQoz --cache no
```

If you machine don't have `open` command(OSX have it)

```sh
$ anything-hub starred:ToQoz --system_command xdg-open
```

## Help
```sh
✘╹◡╹✘  $ anyting-hub --help
$ anything-hub COMMANDS [OPTIONS]

available COMMANDS are
  starred:USER_NAME
  search:SEARCH_KEYWORD

    -s, --system_command      system command name. eg. xdg-open, open (default is open)
    -c, --cache               use cache. yes or no. (default is yes)
    -h, --help                Display this help message.
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
