# Rails Config Environment Source

This gem allows configuring hierarchical settings with [rails_config](https://github.com/railsjedi/rails_config) via environment variables.

For example, the following YAML configuration

```yaml
providers:
  openid_connect:
    google:
      identifier: foo
      secret: bar
```

is equivalent to setting the following environment variables.

    SETTINGS_PROVIDERS_OPENID__CONNECT_GOOGLE_IDENTIFIER=foo
    SETTINGS_PROVIDERS_OPENID__CONNECT_GOOGLE_SECRET=bar

Path segments are separated by underscores. If a path segment contains underscores itself it has to be escaped by doubling it, e.g. 'openid_connect' which becomes 'OPENID__CONNECT'.

## Multiline Environment Source

Newlines in environment variables are not always well handled. Although Although EnvSource supports multiline strings, you can use the `MultilineEnvSource` if you have problems setting the environment variables. It replaces dots in variable values with newlines.

For example, the following YAML configuration

```yaml
access_token_private_key:
   -----BEGIN RSA PRIVATE KEY-----
   MIICXQIBAAKBgQCxYRj9meltCUvQeIWC8O3fBgLxD+KvTqNL70e3X68Gnlujmhrd
   [...]
   DewvP8xDMpdAe09OFuSBCMkICczaSnRDuag8bah0RzDI
   -----END RSA PRIVATE KEY-----
```

is equivalent to setting the following environment variable:

     SETTINGS_ML_ACCESS__TOKEN__PRIVATE__KEY=-----BEGIN RSA PRIVATE KEY-----.MIICXQIBA [...]

## Use

Put this into your Gemfile:

    gem 'rails_config-env_source', :git => 'https://github.com/finnlabs/rails_config-env_source', :branch => 'dev'

## Configuration

To use these sources, configure your application, e.g. in `config/environment.rb`. This snippet uses the normal environment source.

```ruby
require 'rails_config/sources/env_source'

Settings.add_source! RailsConfig::Sources::ENVSource.new
Settings.reload!
```

If you also want to use the multiline source with `ML_SETTINGS` as prefix instead of `SETTINGS`, you can use the following snippet:

```ruby
require 'rails_config/sources/env_source'
require 'rails_config/sources/multiline_env_source'

Settings.add_source! RailsConfig::Sources::ENVSource.new
Settings.add_source! RailsConfig::Sources::MultilineENVSource.new('ML_SETTINGS')
Settings.reload!
```
