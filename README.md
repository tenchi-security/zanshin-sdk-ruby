[![Gem Version](https://badge.fury.io/rb/zanshin.svg)](https://badge.fury.io/rb/zanshin)

# Zanshin Ruby SDK

This Ruby gem contains an SDK to interact with the [API of the Zanshin](https://api.zanshin.tenchisecurity.com) from [Tenchi Security](https://www.tenchisecurity.com).

## Installation

Install the gem and add to the application's Gemfile by executing:

```shell
bundle add zanshin
```

If bundler is not being used to manage dependencies, install the gem by executing:

```shell
gem install zanshin
```

## Setting up Credentials

There are three ways that the SDK handles credentials. The order of evaluation is:
- [**1st** Client Parameters](#client-parameters)
- [**2nd** Environment Variables](#environment-variables)
- [**3rd** Config File](#config-file)

### Client Parameters

When calling the `Client` class, you can pass the values API Key(`api_key`), API URL(`api_url`), User Agent(`user_agent`) and Proxy URL(`proxy_url`) you want to use as below:

```ruby
client = Zanshin::SDK::Client.new(api_key: "my_zanshin_api_key")
puts client.get_me
```

> These values will overwrite anything you set as Environment Variables or in the Config File.

### Environment Variables

You can use the following Environment Variables to configure Zanshin SDK:
- `ZANSHIN_API_KEY`: Will setup your Zanshin credentials
- `ZANSHIN_API_URL`: Will define the API URL. Default is `https://api.zanshin.tenchisecurity.com`
- `ZANSHIN_USER_AGENT`: If you want to overwrite the User Agent when calling Zanshin API (The value passed will be concatenated to the SDK's default value `Zanshin Ruby SDK 1.0.0`)
- `HTTP_PROXY | HTTPS_PROXY`: Zanshin SDK uses `Net::HTTP` under the hood, checkout the [Net::HTTP RDoc](https://ruby-doc.org/stdlib-3.1.2/libdoc/net/http/rdoc/Net/HTTP.html) section of their documentation for more use cases

#### Example

```shell
export ZANSHIN_API_KEY="my_zanshin_api_key"
```

> These Environment Variables will overwrite anything you set on the Config File.

### Config File

This `Ruby SDK` was built to be used under the same conditions as the [Python SDK](https://github.com/tenchi-security/zanshin-sdk-python), so the configuration file is in the format created by the Python [RawConfigParser](https://docs.python.org/3/library/configparser.html#configparser.RawConfigParser) class.

The file is located at `~/.tenchi/config`, where `~` is the [current user's home directory](https://docs.python.org/3/library/pathlib.html#pathlib.Path.home).

Each section is treated as a configuration profile, and the SDK will look for a section called `default` if another is not explicitly selected.

These are the supported options:

* `api_key` (required) which contains the Zanshin API key obtained at the [Zanshin web portal](https://zanshin.tenchisecurity.com/my-profile).
* `api_url` (optional) directs the SDK to use a different API endpoint than the default (https://api.zanshin.tenchisecurity.com).
* `user_agent` (optional) allows you to override the default user-agent header used by the SDK when making API requests (The value passed will be concatenated to the SDK's default value `Zanshin Ruby SDK 1.0.0`).
* `proxy_url` (optional) directs the SDK to use a Proxy.

This is what a minimal configuration file looks like:
```ini
[default]
api_key=my_zanshin_api_key
```

## The SDK

```ruby
  client = Zanshin::SDK::Client.new
  client.get_me 
```

## Usage

### Create instance
```ruby
  client = Zanshin::SDK::Client.new # loads API key from the "default" profile in ~/.tenchi/config
```

### Get logged user info
```ruby
  client.get_me # calls /me API endpoint
```

### Get logged user info

Methods with prefix `iter_*` return an [Enumerator](https://ruby-doc.org/core-2.6/Enumerator.html), you can use it however you want, in this example we use `to_a` to convert the Enumerator into an Array.
```ruby
  client.iter_organizations.to_a # calls /organizations API endpoint
```

## Support

If you are a Zanshin customer and have any questions regarding the use of the service, its API or this SDK package, please get in touch via e-mail at `support@tenchisecurity.com` or via the support widget on the [Zanshin Portal](https://zanshin.tenchisecurity.com).

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at `https://github.com/tenchi-security/zanshin-sdk-ruby`. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/tenchi-security/zanshin-sdk-ruby/blob/main/CODE_OF_CONDUCT.md).

## Unit Test

Currently, the Unit Test only checks if the API call was made in the way it should, after implementing the input validations the tests will be better.

## TODO

- Input validation
- Coverage badge
- File Persistent Alerts Iterator
- Onboard Scan Targets (AWS)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `Zanshin Ruby SDK` project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tenchi-security/zanshin-sdk-ruby/blob/main/CODE_OF_CONDUCT.md).

## Changelog

See [CHANGELOG](https://github.com/tenchi-security/zanshin-sdk-ruby/blob/main/CHANGELOG.md) for a list of changes.
