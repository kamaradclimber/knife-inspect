require 'chef/node'
require 'yajl'

module HealthInspector
  module Checklists
    class Node < Pairing
      include ExistenceValidations
      include AttributeValidations
    end

    class Nodes < Base
      title 'nodes'

      def load_item(name)
        Node.new(@context,
                 name: name,
                 server: load_item_from_server(name),
                 local: local_items[name]
        )
      end

      def server_items
        @server_items ||= Chef::Node.list
      end

      def local_items
        @local_items ||= Dir["#{@context.repo_path}/nodes/**/*.{rb,json}"].inject({}) do |h, filename|
          case filename
          when /\.json$/
            node = Chef::JSONCompat.from_json(IO.read(filename))
            name = node['name']
          when /\.rb$/
            node = Chef::Node.new
            node.from_file(filename)
            name = node.name
          end
          h[name] = node
          h
        end
      end

      def load_item_from_server(name)
        node = Chef::Node.load(name)
        node
      rescue
        nil
      end

      def all_item_names
        (server_items.keys + local_items.keys).uniq.sort
      end
    end
  end
end
