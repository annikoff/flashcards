# !/usr/bin/env puma
# frozen_string_literal: true

application_path = '/vagrant'
pids_path = "#{application_path}/tmp/pids"
log_path = "#{application_path}/log"
railsenv = ENV['RAILS_ENV'] || 'development'
file_name = "puma-#{railsenv}"
directory application_path
environment railsenv
daemonize true
pidfile "#{pids_path}/#{file_name}.pid"
state_path "#{pids_path}/#{file_name}.state"
stdout_redirect "#{log_path}/#{file_name}.stdout.log",
                "#{log_path}/#{file_name}.stderr.log"
threads 0, 16
port 3000
bind 'tcp://0.0.0.0'
