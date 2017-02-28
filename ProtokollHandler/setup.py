#!/usr/bin/env python3

from distutils.core import setup
import os

# Utility function to read the README file.
# Used for the long_description.  It's nice, because now 1) we have a top level
# README file and 2) it's easier to type in the README file than to put a raw
# string in below ...
def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup( 
    name = "exec-protocol-handler", 
    version = "1.2", 
    description = "Protocoll Handler for FF Browser",
    long_description=read('README.txt'),
    author = "Dieter Engemann", 
    author_email = "dieter@engeman.me", 

    # The project's main homepage.
    url='https://github.com/Eng1958/NNNNNN',

    py_modules = ["exec"] 
    )
