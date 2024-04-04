# Setup web servers for deployment of AirBnb_clone
exec {'update packages':
  provider => shell,
  command  => 'sudo apt-get update -y',
  before   => Exec['install Nginx'],
}
exec {'install Nginx':
  provider => shell,
  command  => 'sudo apt-get install nginx -y',
  before   => Exec['create directory'],
}
exec {'create directory':
  provider => shell,
  command  => 'sudo mkdir -p /data/web_static/{releases/test,shared}',
  before   => Exec['html file'],
}
exec {'html file':
  provider => shell,
  command  => 'echo "<html><head></head><body>Dik lhdera dyal tberguigue rak 3lih nta o rbat</body></html>" | sudo     tee /data/web_static/releases/test/index.html',
  before   => Exec['symbolic link'],
}
exec {'symbolic link':
  provider => shell,
  command  => 'sudo ln -sf /data/web_static/releases/test/ /data/web_static/current',
  before   => Exec['change owner'],
}
exec {'change owner':
  provider => shell,
  command  => 'sudo chown -R ubuntu:ubuntu /data/',
  before   => Exec['serve content'],
}
exec {'serve content':
  provider => shell,
  command  => 'sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}'     /etc/nginx/sites-enabled/default',
  before   => Exec['Restart Nginx services'],
}
exec { 'Restart Nginx services':
  provider => shell,
  command  => 'sudo service nginx restart',
}
