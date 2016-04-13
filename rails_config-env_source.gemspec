Gem::Specification.new do |s|
    s.name       = 'rails_config-env_source'
    s.version    = '1.0.0'
    s.date       = '2014-06-06'
    s.summary    = 'Load rails_config settings from environment variables'
    s.description= <<-EOF
      Supports overriding nested configurations through ENV.
      Settings are YAML-parsed to support actual numbers by default.

      Example:

      server:
        connector:
          port: 80

      Can be overriden through the environment by defining the following ENV var:

      SETTINGS_SERVER_CONNECTOR_PORT=80

      Through the YAML-parsing the setting value will actually be an Integer
      as opposed to a String:

      Settings.server.connector.port == 80
    EOF
    s.homepage   = 'https://github.com/finnlabs/rails_config-env_source'
    s.authors    = ['Finn GmbH']
    s.email      = ['info@finn.de']
    s.files      = Dir['lib/**/*.rb'] + ['README.md']
    s.license    = 'GPLv3'
end
