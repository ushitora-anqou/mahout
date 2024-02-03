let s =
  {|
map $http_upgrade $connection_upgrade {
  default upgrade;
  ''      close;
}

upstream backend {
  server {{ web_svc_name }}.{{ namespace }}.svc.cluster.local:3000 fail_timeout=0;
}

upstream streaming {
  # Instruct nginx to send connections to the server with the least number of connections
  # to ensure load is distributed evenly.
  least_conn;

  server {{ streaming_svc_name }}.{{ namespace }}.svc.cluster.local:4000 fail_timeout=0;
  # Uncomment these lines for load-balancing multiple instances of streaming for scaling,
  # this assumes your running the streaming server on ports 4000, 4001, and 4002:
  # server 127.0.0.1:4001 fail_timeout=0;
  # server 127.0.0.1:4002 fail_timeout=0;
}

proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=CACHE:10m inactive=7d max_size=1g;

server {
  listen 80;
  listen [::]:80;
  server_name {{ server_name }};

  keepalive_timeout    70;
  sendfile             on;
  client_max_body_size 99m;

  root /mnt/public;

  gzip on;
  gzip_disable "msie6";
  gzip_vary on;
  gzip_proxied any;
  gzip_comp_level 6;
  gzip_buffers 16 8k;
  gzip_http_version 1.1;
  gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript image/svg+xml image/x-icon;

  location / {
    try_files $uri @proxy;
  }

  # If Docker is used for deployment and Rails serves static files,
  # then needed must replace line `try_files $uri =404;` with `try_files $uri @proxy;`.
  location = /sw.js {
    add_header Cache-Control "public, max-age=604800, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/assets/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/avatars/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/emoji/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/headers/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/packs/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/shortcuts/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/sounds/ {
    add_header Cache-Control "public, max-age=2419200, must-revalidate";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    try_files $uri =404;
  }

  location ~ ^/system/ {
    add_header Cache-Control "public, max-age=2419200, immutable";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";
    add_header X-Content-Type-Options nosniff;
    add_header Content-Security-Policy "default-src 'none'; form-action 'none'";
    try_files $uri =404;
  }

  location ^~ /api/v1/streaming {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    #proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Proxy "";

    proxy_pass http://streaming;
    proxy_buffering off;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;

    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains";

    tcp_nodelay on;
  }

  location @proxy {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    #proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Proxy "";
    proxy_pass_header Server;

    proxy_pass http://backend;
    proxy_buffering on;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;

    proxy_cache CACHE;
    proxy_cache_valid 200 7d;
    proxy_cache_valid 410 24h;
    proxy_cache_use_stale error timeout updating http_500 http_502 http_503 http_504;
    add_header X-Cached $upstream_cache_status;

    tcp_nodelay on;
  }

  error_page 404 500 501 502 503 504 /500.html;
}
|}
