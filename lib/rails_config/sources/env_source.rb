# Rails Config Environment Source

# Copyright (C)2014 Finn GmbH

# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 3.

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# See doc/GPL.txt.

module RailsConfig
  module Sources
    ##
    # Loads settings from environment variables.
    #
    class EnvSource
      attr_accessor :prefix
      attr_accessor :aliases

      def initialize(prefix = 'SETTINGS', include_prefix_in_path = false, aliases = {})
        @prefix = prefix
        @aliases = Hash[aliases.map { |k, v| [k, v.downcase] }]
        @include_prefix_in_path = include_prefix_in_path
      end

      def load
        settings = {}

        ENV.select { |k, _| k =~ /^#{prefix}_/i }.each do |k, value|
          path = self.path(k)
          org_settings = Settings
          path.reduce(settings) do |set, key|
            org_settings = org_settings[key] if org_settings
            if key == path.last
              set[key] = get_value value
            elsif !set.include?(key)
              set[key] = org_settings || {}
            end

            set[key]
          end
        end

        settings
      end

      def path(env_var_name)
        path = []
        env_var_name = env_var_name[@prefix.length..-1] unless include_prefix_in_path?

        env_var_name.gsub(/([a-zA-Z0-9]|(__))+/) do |seg|
          path << substitute_alias(unescape_underscores(seg.downcase)).to_sym
        end

        path
      end

      def get_value(value)
        value
      end

      def substitute_alias(path_segment)
        if aliases.include? path_segment
          aliases[path_segment]
        else
          path_segment
        end
      end

      def unescape_underscores(path_segment)
        path_segment.gsub('__', '_')
      end

      def include_prefix_in_path?
        @include_prefix_in_path
      end
    end
  end
end
