require 'spec_helper'

RSpec.describe HealthInspector::Checklists::Nodes do
  let :checklist do
    described_class.new(nil)
  end

  before do
    expect(HealthInspector::Context).to receive(:new).with(nil)
      .and_return health_inspector_context
  end

  describe '#server_items' do
    it 'returns a list of nodes from the chef server' do
      expect(Chef::Node).to receive(:list).and_return(
        'node_one'         => 'url',
        'node_two'         => 'url'
      )
      expect(checklist.server_items.keys.sort)
        .to eq %w(node_one node_two)
    end
  end

  describe '#local_items' do
    it 'returns a list of nodes from the chef repo' do
      expect(checklist.local_items.keys.sort)
        .to eq %w(node_one node_two)
    end
  end
end
