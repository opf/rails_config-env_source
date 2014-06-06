require 'rails_config/sources/env_source'

module RailsConfig
  module Sources
    ##
    # Loads settings from environment variables that need to have multiple lines.
    #
    # Based on ENVSource.
    #
    # This config source replaces dots (.) in values with newlines.
    #
    class MultilineEnvSource < EnvSource
      def get_value(value)
        value.gsub('.', "\n")
      end
    end
  end
end
