#!/usr/bin/python3
"""Module to perform full deployment"""
from fabric.api import *
from datetime import datetime
from os.path import exists, isdir
do_pack = __import__('1-pack_web_static').do_pack
do_deploy = __import__('2-do_deploy_web_static').do_deploy
env.hosts = ['54.197.50.4', '34.229.137.21']
env.user = 'ubuntu'


def deploy():
    """Creates and distributes an archive to web servers"""
    archive_path = do_pack()
    if archive_path is None:
        return False
    return do_deploy(archive_path)
