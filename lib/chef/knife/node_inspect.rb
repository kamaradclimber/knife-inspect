require 'chef/knife'
require 'health_inspector'

class Chef
  class Knife
    class NodeInspect < Knife
      include HealthInspector::Runner

      checklist HealthInspector::Checklists::Nodes
      banner 'knife node inspect [NODE] (options)'
    end
  end
end
