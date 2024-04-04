#!/usr/bin/python3
"""Module to perform full deployment"""
from fabric.api import env, run, put, local
from datetime import datetime
from os.path import exists
env.hosts = ['54.197.50.4', '34.229.137.21']
env.user = 'ubuntu'


def do_pack():
    """Create a tgz archive from web_static content"""
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    filename = "versions/web_static_{}.tgz".format(timestamp)
    try:
        local("mkdir -p versions")
        local("tar -czvf {} web_static".format(filename))
        return filename
    except:
        return None

def do_deploy(archive_path):
    """Distributes an archive to web servers"""
    if not exists(archive_path):
        return False
    try:
        filename = archive_path.split('/')[-1]
        no_folder = filename.split(".")[0]
        folder = "/data/web_static/releases/{}".format(no_folder)
        if (
            put(archive_path, '/tmp/').failed or
            run('mkdir -p {}/'.format(folder)).failed or
            run('tar -xzf /tmp/{} -C {}/'.format(filename, folder)).failed or
            run('rm /tmp/{}'.format(filename)).failed or
            run('mv {}/web_static/* {}/'.format(folder, folder)).failed or
            run('rm -rf {}/web_static'.format(folder)).failed or
            run('rm -rf /data/web_static/current').failed or
            run('ln -s {}/ /data/web_static/current'.format(folder)).failed
        ):
            return False
    except Exception:
        return False
    print("New version deployed!")
    return True

def deploy():
    """Creates and distributes an archive to web servers"""
    archive_path = do_pack()
    if archive_path is None:
        return False
    return do_deploy(archive_path)
