# frozen_string_literal: true
APP_DIR = File.expand_path('../../', __FILE__)

# paths
working_directory "#{APP_DIR}/current"
pid "#{APP_DIR}/current/tmp/pids/unicorn.pid"

# listen
listen "#{APP_DIR}/current/tmp/sockets/unicorn.socket", backlog: 64

# logging
stderr_path "#{APP_DIR}/current/log/unicorn.stderr.log"
stdout_path "#{APP_DIR}/current/log/unicorn.stdout.log"

worker_processes ENV.fetch('WEB_CONCURRENCY', 2).to_i
timeout ENV.fetch('UNICORN_TIMEOUT', 15).to_i

preload_app true

before_fork do |server, _worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      nil
    end
  end
end

after_fork do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
