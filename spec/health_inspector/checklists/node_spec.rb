require 'spec_helper'

RSpec.describe HealthInspector::Checklists::Node do
  it_behaves_like 'a chef model'
  it_behaves_like 'a chef model that can be represented in json'
end
