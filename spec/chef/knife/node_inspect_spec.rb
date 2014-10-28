require 'spec_helper'
require 'chef/knife/node_inspect'

RSpec.describe Chef::Knife::NodeInspect do
  it_behaves_like 'a knife inspect runner' do
    let :checklist do
      HealthInspector::Checklists::Nodes
    end
  end
end
