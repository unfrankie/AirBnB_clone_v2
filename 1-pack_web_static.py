#!/usr/bin/python3
"""Module to create a tgz archive from web_static content"""
from fabric.api import local
from datetime import datetime


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
