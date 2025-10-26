# config/puma.rb

env = ENV.fetch("RAILS_ENV") { ENV.fetch("RACK_ENV", "development") }
environment env

if env == "production"
  app_dir = ENV.fetch("APP_DIR", "/var/www/cybersecurity")
  shared  = ENV.fetch("SHARED_DIR", File.join(app_dir, "shared"))

  # Ensure required dirs exist (prevents 502 due to missing socket/pids/log)
  require "fileutils"
  FileUtils.mkdir_p(File.join(shared, "pids"))
  FileUtils.mkdir_p(File.join(shared, "sockets"))
  FileUtils.mkdir_p(File.join(app_dir, "log"))

  directory app_dir

  pidfile    File.join(shared, "pids", "puma.pid")
  state_path File.join(shared, "pids", "puma.state")

  # Same socket Nginx points at; umask makes it 660 (group-writable)
  bind  "unix://#{File.join(shared, "sockets", "puma.sock")}"
  umask 0007

  workers Integer(ENV.fetch("PUMA_WORKERS", 2))
  threads Integer(ENV.fetch("PUMA_MIN_THREADS", 1)), Integer(ENV.fetch("PUMA_MAX_THREADS", 5))
  preload_app!

  stdout_redirect File.join(app_dir, "log", "puma.stdout.log"),
                  File.join(app_dir, "log", "puma.stderr.log"),
                  true

  tag "cybersecurity"
else
  # Development / Test
  # No chdir; stay in project folder; run on TCP so `rails s` Just Works™
  port ENV.fetch("PORT", 3000)
  workers Integer(ENV.fetch("PUMA_WORKERS", 0))
  threads 1, Integer(ENV.fetch("PUMA_MAX_THREADS", 5))
  plugin :tmp_restart
end
