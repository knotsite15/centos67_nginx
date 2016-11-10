require 'spec_helper'

describe 'centos67_nginx::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe package('nginx') do
    it { should be_installed }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end
end
