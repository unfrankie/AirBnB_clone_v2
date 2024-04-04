#!/usr/bin/python3
"""
Fabric scriptthat creates and distributes an archive to your web servers
using the function deploy
"""
from os.path import exists, isdir
from fabric.api import env, local, put, run
from datetime import datetime
env.hosts = ['34.227.89.197', '100.25.20.169']
env.user = 'ubuntu'


def do_pack():
    """generates a .tgz archive from the contents of the web_static"""
    try:
        date = datetime.now().strftime("%Y%m%d%H%M%S")
        if isdir("versions") is False:
            local("mkdir versions")
        file_name = "versions/web_static_{}.tgz".format(date)
        local("tar -cvzf {} web_static".format(file_name))
        return file_name
    except Exception as ex:
        return None


def do_deploy(archive_path):
    """deploy web static with fabric"""
    if exists(archive_path) is False:
        return False

    try:
        file_name = archive_path.split("/")[-1]
        no_ex = file_name.split(".")[0]
        path = "/data/web_static/releases/"
        put(archive_path, '/tmp/')
        run('sudo mkdir -p {}{}/'.format(path, no_ex))
        run('sudo tar -xzf /tmp/{} -C {}{}/'.format(file_name, path, no_ex))
        run('sudo rm /tmp/{}'.format(file_name))
        run('sudo mv {0}{1}/web_static/* {0}{1}/'.format(path, no_ex))
        run('sudo rm -rf {}{}/web_static'.format(path, no_ex))
        run('sudo rm -rf /data/web_static/current')
        run('sudo ln -s {}{}/ /data/web_static/current'.format(path, no_ex))
        return True
    except BaseException:
        return False


def deploy():
    """ do path an do deploy"""
    archive_path = do_pack()
    if archive_path is None:
        return False
    return do_deploy(archive_path)
