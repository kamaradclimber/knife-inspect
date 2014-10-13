require 'chef/role'
require 'yajl'

module HealthInspector
  module Checklists
    class Role < Pairing
      include ExistenceValidations
      include JsonValidations
    end

    class Roles < Base
      title 'roles'

      def load_item(name)
        Role.new(@context,
                 name: name,
                 server: load_item_from_server(name),
                 local: local_items[name]
        )
      end

      def server_items
        @server_items ||= Chef::Role.list
      end

      def local_items
        @local_items ||= Dir["#{@context.repo_path}/roles/**/*.{rb,json,js}"].inject({}) do |h, filename|
          case filename
          when /\.json$/
            role = Chef::JSONCompat.from_json(IO.read(filename))
          when /\.rb$/
            role = Chef::Role.new
            role.from_file(filename)
            role = role.to_hash
          end
          h[role['name']] = role
          h
        end
        @local_items
      end

      def load_item_from_server(name)
        role = Chef::Role.load(name)
        role.to_hash
      rescue
        nil
      end

      def all_item_names
        (server_items.keys + local_items.keys).uniq.sort
      end
    end
  end
end
