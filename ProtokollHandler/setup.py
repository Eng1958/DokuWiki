#!/usr/bin/env python3
"""
    setup.py for exec script
"""

from distutils.core import setup
import os
import re

def get_version():
    """
        Get version from a version file
    """
    versionfile = os.path.join('pypkg', '__init__.py')
    initfile_lines = open(versionfile, 'rt').readlines()
    vsre = r"^__version__ = ['\"]([^'\"]*)['\"]"
    for line in initfile_lines:
        expr = re.search(vsre, line, re.M)
        if expr:
            return expr.group(1)
    raise RuntimeError('Unable to find version string in %s.' % (versionfile,))


def read(fname):
    """
        Utility function to read the README file.
        Used for the long_description.  It's nice, because now
        1) we have a top level README file and
        2) it's easier to type in the README file than to put a raw
        string in below ...
    """
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name="exec-protocol-handler",
    ## version = "1.2",
    version=get_version(),
    description="Protocoll Handler for FF Browser",
    long_description=read('README.md'),
    author="Dieter Engemann",
    author_email="dieter@engeman.me",

    # The project's main homepage.
    url='https://github.com/Eng1958/NNNNNN',
    packages=['pypkg'],
    py_modules=["exec"],
    data_files=[('doc', ['README.me'])]
    )
