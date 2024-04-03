# Setup web servers for deployment of AirBnb_clone
package { 'nginx':
  ensure => installed,
}
file { '/data/web_static/releases/test':
  ensure => directory,
}
file { '/data/web_static/shared':
  ensure => directory,
}
file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  content => "<html><head></head><body>Dik lhdera dyal tberguigue rak 3lih nta o rbat</body></html>\n",
}
file { '/data/web_static/current':
  ensure => link,
  target => '/data/web_static/releases/test',
}
file { '/data':
  owner => 'ubuntu',
  group => 'ubuntu',
  recurse => true,
}
file { '/etc/nginx/sites-enabled/default':
  ensure  => file,
  content => "server {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server;\n\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n}\n",
  notify  => Service['nginx'],
}
service { 'nginx':
  ensure  => running,
  enable  => true,
}
