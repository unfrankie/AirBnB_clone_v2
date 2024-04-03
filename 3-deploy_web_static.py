#!/usr/bin/python3
"""Module to perform full deployment"""
from fabric.api import *
from datetime import datetime
do_pack = __import__('1-pack_web_static').do_pack
do_deploy = __import__('2-do_deploy_web_static').do_deploy


def deploy():
    """Creates and distributes an archive to web servers"""
    archive_path = do_pack()
    if archive_path is None:
        return False
    return do_deploy(archive_path)
