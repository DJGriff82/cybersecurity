# Determine environment
env = ENV.fetch("RAILS_ENV") { ENV.fetch("RACK_ENV", "development") }
environment env

if env == "production"
  # --- Production (live server) ---
  app_dir   = ENV.fetch("APP_DIR", "/var/www/cybersecurity")
  shared    = ENV.fetch("SHARED_DIR", File.join(app_dir, "shared"))

  directory app_dir

  pidfile    File.join(shared, "pids", "puma.pid")
  state_path File.join(shared, "pids", "puma.state")

  # Nginx expects this socket path:
  bind "unix://#{File.join(shared, "sockets", "puma.sock")}"

  workers Integer(ENV.fetch("PUMA_WORKERS", 2))
  threads Integer(ENV.fetch("PUMA_MIN_THREADS", 1)), Integer(ENV.fetch("PUMA_MAX_THREADS", 5))
  preload_app!

  stdout_redirect File.join(app_dir, "log", "puma.stdout.log"),
                  File.join(app_dir, "log", "puma.stderr.log"),
                  true
else
  # --- Development / Test (local) ---
  # No chdir; stay in your project directory on the Mac
  port ENV.fetch("PORT", 3000)
  workers Integer(ENV.fetch("PUMA_WORKERS", 0)) # 0 => single process
  threads 1, Integer(ENV.fetch("PUMA_MAX_THREADS", 5))
  plugin :tmp_restart
end
