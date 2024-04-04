# Setup web servers for deployment of AirBnb_clone
exec { 'apt-get-update':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure => installed,
}

exec { 'create-directories':
  command => '/usr/bin/mkdir -p /data/web_static/releases/test /data/web_static/shared',
}

file { '/data/web_static/releases/test/index.html':
  ensure  => present,
  content => 'ALX',
}

exec { 'remove-current-link':
  command => '/usr/bin/rm -rf /data/web_static/current',
}

file { '/data/web_static/current':
  ensure  => 'link',
  target  => '/data/web_static/releases/test',
  require => Exec['create-directories'],
}

exec { 'change-owner':
  command => '/usr/bin/chown -R ubuntu:ubuntu /data/',
}

file_line { 'hbnb_static_config':
  path    => '/etc/nginx/sites-enabled/default',
  line    => '    location /hbnb_static { alias /data/web_static/current/; index index.html; }',
  match   => '^server {',
  after   => true,
  notify  => Exec['restart-nginx'],
}

exec { 'restart-nginx':
  command => '/usr/sbin/service nginx restart',
  refreshonly => true,
}
