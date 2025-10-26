environment "production"
directory "/var/www/cybersecurity"

pidfile "/var/www/cybersecurity/shared/pids/puma.pid"
state_path "/var/www/cybersecurity/shared/pids/puma.state"

# Nginx expects this socket path:
bind "unix:///var/www/cybersecurity/shared/sockets/puma.sock"

workers 2
threads 1, 5
preload_app!

stdout_redirect "/var/www/cybersecurity/log/puma.stdout.log",
                "/var/www/cybersecurity/log/puma.stderr.log",
                true
