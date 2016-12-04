# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'flashcards'
    vb.gui = false
    vb.memory = '2048'
    vb.customize ['modifyvm', :id, '--cpuexecutioncap', '70']
  end
  config.vm.network 'forwarded_port', guest: 9292, host: 3000
  config.vm.provision 'shell',
                      path: 'config/vagrant.sh',
                      env: {
                        'RUBY_VERSION' => '2.3.2',
                        'RAILS_ENV' => ENV['RAILS_ENV'],
                      },
                      privileged: false
end
