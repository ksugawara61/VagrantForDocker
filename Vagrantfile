# -*- mode: ruby -*-
# vi: set ft=ruby :

# constraint variables
VAGRANT_API_VERSION = '2'.freeze

# setting variables for instance
node_ip = '172.16.1.170'
node_hostname = 'node001'
node_vm_memory = 2048
node_vm_cpus = 2
node_port_array = [80, 443, 3000, 3001, 3002, 3003, 9200]

Vagrant.configure(VAGRANT_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.ssh.forward_agent = true
  config.vm.box = 'centos/7'

  config.trigger.before [:up, :reload] do |trigger|
    trigger.info = 'Starging script for before up...'
    trigger.run = {
      path: './bin/before_up_proxy.sh'
    }
  end

  config.trigger.after [:up, :reload] do |trigger|
    trigger.info = 'Starging script for after up...'
    trigger.run = {
      path: './bin/after_up_proxy.sh'
    }
  end

  config.vm.hostname = node_hostname
  node_port_array.each do |port|
    config.vm.network 'forwarded_port', guest: port, host: port
  end
  config.vm.network 'private_network', ip: node_ip

  config.vm.synced_folder(
    './dev',
    '/home/vagrant/dev',
    owner: 'vagrant',
    group: 'vagrant'
  )

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbook.yml'
  end

  config.vm.provider :virtualbox do |vb|
    vb.memory = node_vm_memory
    vb.cpus = node_vm_cpus
  end
end
