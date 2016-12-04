# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'flashcards'
    vb.gui = false
    vb.memory = '1024'
    vb.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
  end
  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  config.vm.synced_folder '.', '/vagrant', type: 'rsync', rsync__exclude: ['.git/', '.idea/']


  env = {
    'RUBY_VERSION' => '2.3.3',
    'RAILS_ENV' => ENV['RAILS_ENV'] || 'development',
    'SECRET_KEY_BASE' => ENV['SECRET_KEY_BASE'],
    'SORCERY_GITHUB_CALLBACK_URL' => ENV['SORCERY_GITHUB_CALLBACK_URL'],
    'SORCERY_GITHUB_KEY' => ENV['SORCERY_GITHUB_KEY'],
    'SORCERY_GITHUB_SECRET' => ENV['SORCERY_GITHUB_SECRET'],
  }
  config.vm.provision 'shell',
                      path: 'config/vagrant.sh',
                      env: env,
                      privileged: false
end
