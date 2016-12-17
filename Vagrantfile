# -*- mode: ruby -*-
# vi: set ft=ruby :
# frozen_string_literal: true

Vagrant.configure('2') do |config|
  config.vm.box = 'boxcutter/centos72'

  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'flashcards'
    vb.gui = false
    vb.memory = '1024'
    vb.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
  end

  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  env = {
    'RUBY_VERSION' => '2.3.3',
    'RAILS_ENV' => 'development'
  }

  config.vm.provision 'shell', path: 'config/vagrant.sh',
                               env: env,
                               privileged: false

  inline = 'if [ "$RAILS_ENV" != "test" ]; ' \
           'then source ~/.profile && cd /vagrant && ./bin/puma restart && ' \
           './bin/delayed_job restart fi;'
  config.vm.provision 'shell', inline: inline,
                               env: env,
                               run: 'always',
                               privileged: false
end
