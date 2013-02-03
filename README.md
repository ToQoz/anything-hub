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
  c.token "token"       # github oauth token. this is optional. (If you use in non-interactive env, I recommend to set this.)
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

If you want to do only cache

```sh
$ anything-hub cache:starred:ToQoz
```

If you get token for github api(e.g. for cron)

```sh
$ anything-hub token
```

## Tips

Periodically cache. For example for the often searched keyword and your starred.
**If try it, I recommend to put token to your `~/anything-hubrc`. You can get token by `$ anything-hub token`**

```sh
$ crontab -e
05 12 * * * /Users/toqoz/.rbenv/shims/anything-hub cache:search:rails >> /tmp/anything-hub.cron.log 2>> /tmp/anything-hub.cron.error.log
05 1 * * * /Users/toqoz/.rbenv/shims/anything-hub cache:starred:ToQoz >> /tmp/anything-hub.cron.log 2>> /tmp/anything-hub.cron.error.log
```

## Help
```sh
✘╹◡╹✘  $ anyting-hub --help
$ anything-hub COMMANDS [OPTIONS]

available COMMANDS are
  starred:USER_NAME
  search:SEARCH_KEYWORD
  cache:COMMAND (e.g. cache:search:rails)
  token

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
