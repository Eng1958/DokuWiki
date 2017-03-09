#!/usr/bin/env python3
"""

*** Description ***

    exec.py: Implements a protocol handler in Firefox
    Description: This script is called from a so called protocoll-handler
    inside a web-browser like firefox. The script ist called with an argument
    "exec:<filename>" where filename can be the name of a directory or the
    name of a local file. The local file is opened with the default application
    a directoy is opened with the default filemanager.

    Example:
        <exec>\\home\alibaba<\\exec>  open HOME-directory
        <exec>\\home\alibaba\aladin.mp3<\\exec>   play the mp3 file

    Copyright (C) 2017  Dieter Engemann <dieter@engemann.me>

    24.01.2017  Version 1.0     First version
    24.02.2017  Version 1.1     Using Macros for directories
    28.02.2017  Version 1.2     Some enhancements
    09.03.2017  Version 1.3     More error messages

"""
import os
import os .path
import sys
import logging
import re
import subprocess
import tkinter as tk
from tkinter import messagebox
import pypkg

VERSION = 'v1.3 (09.03.2017)'
MACROFILE = '~/.exec/macro.cfg'

def set_logfile(script_name):
    """
    Write output to logfile. If this start from FF-browser you will see no
    output on a screen.
    """

    logfile = '/tmp/' + os.path.basename(script_name) + '.log'
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    logger = logging.getLogger()
    logger.addHandler(logging.FileHandler(logfile, 'a'))
    return logger.info

def read_macro_configuration():
    """
    Read entries of macro configuration file and returns a dictonary

    Example of a macro
    $Mt = ~/Musik/test
    """

    macrofile = os.path.expanduser(MACROFILE)
    macro_dict = {}

    try:
        mf = open(macrofile, 'r')
    except IOError:
        print('Macro-Configuration ' + macrofile + ' doesn\'t exist')
    else:
        print('Read content of Macro-Configuration ' + macrofile)
        content = mf.read().splitlines()
        mf.close()

        for line in content:
            if not line.startswith('#'):
                part = line.split('=')
                macro_dict[part[0].strip()] = part[1].strip()

        print(macro_dict)
        return macro_dict

def substitute_macro(file, macro_dict):
    """
        change macro in real filename
    """
    print(file, macro_dict)
    if not file.startswith('$'):
        return file

    macro = file.split('/', 1)
    if macro[0] not in macro_dict:
        return file

    newfile = file.replace(macro[0], macro_dict[macro[0]], 1)
    print(newfile)
    return newfile

def error_message(message):
    """

    """

    print(message)
    messagebox.showerror("Error", message)

def main():
    """
        Main-Function
    """

    print = set_logfile(sys.argv[0])

    print('Version:' + pypkg.__version__)
    print('Name of the script: ' + sys.argv[0])
    print('Number of arguments: ' + str(len(sys.argv)))
    print('The arguments are: '  + str(sys.argv))

    if len(sys.argv) != 2:
        print('Error: no argument to execute!')
        return

    # remove 'exec:' from argument
    filename = re.sub('^exec:', '', sys.argv[1])


    macros = read_macro_configuration()

    filename = substitute_macro(filename, macros)

    filename = re.sub('^~', os.environ['HOME'], filename)
    print(filename)

    # check if argument is a directory
    if os.path.isdir(filename):
        # call default filemanager with directory as argument
        print(filename + ' is a directory')
        cmd = 'xdg-open ' + filename
        subprocess.call(cmd, shell=True)

    # check if filename exists
    elif os.path.isfile(filename):
        # run default application for filename
        print('Start application for ' + filename)

        # mask filename to avoid error with special characters in filename
        cmd = 'xdg-open ' + '\"' + filename + '\"'
        subprocess.call(cmd, shell=True)
    else:
        # Error: No directory or file

        # show messagebox without the Tkinter window
        root = tk.Tk()
        root.withdraw()

        message = filename + ' not found'
        error_message(message)


if __name__ == '__main__':
    main()
