listen '/home/web/www/azurie/current/tmp/rainbows.sock'
Rainbows! do
  use :ThreadPool
  worker_connections 10
end

worker_processes 1
timeout 30
