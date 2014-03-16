require 'spec_helper'

describe 'minecraft::user' do
  context 'creates a user for the minecraft server' do
    cached(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.automatic['memory']['total'] = '2097152kB'
      end.converge(described_recipe)
    end

    it 'creates a user with attributes' do
      expect(chef_run).to create_user('mcserver').with(
        shell: '/bin/false',
        gid: 'mcserver',
        home: '/srv/minecraft'
      )
    end
  end
end
