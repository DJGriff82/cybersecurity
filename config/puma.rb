# config/puma.rb

env = ENV.fetch("RAILS_ENV") { ENV.fetch("RACK_ENV", "development") }
environment env

if env == "production"
  app_dir = ENV.fetch("APP_DIR", "/var/www/cybersecurity")
  shared  = ENV.fetch("SHARED_DIR", File.join(app_dir, "shared"))

  require "fileutils"
  FileUtils.mkdir_p(File.join(shared, "pids"))
  FileUtils.mkdir_p(File.join(shared, "sockets"))
  FileUtils.mkdir_p(File.join(app_dir, "log"))

  directory app_dir

  pidfile    File.join(shared, "pids", "puma.pid")
  state_path File.join(shared, "pids", "puma.state")

  # Nginx expects this socket
  bind "unix://#{File.join(shared, 'sockets', 'pum.sock')}"

  workers Integer(ENV.fetch("PUMA_WORKERS", 2))
  threads Integer(ENV.fetch("PUMA_MIN_THREADS", 1)), Integer(ENV.fetch("PUMA_MAX_THREADS", 5))
  preload_app!

  stdout_redirect File.join(app_dir, "log", "puma.stdout.log"),
                  File.join(app_dir, "log", "puma.stderr.log"),
                  true

  tag "cybersecurity"
else
  # Dev/Test: keep it simple
  port ENV.fetch("PORT", 3000)
  workers Integer(ENV.fetch("PUMA_WORKERS", 0))
  threads 1, Integer(ENV.fetch("PUMA_MAX_THREADS", 5))
  plugin :tmp_restart
end
