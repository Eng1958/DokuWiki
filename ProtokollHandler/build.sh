# !/usr/bin/bash
echo 'Version:' `grep -Po [0-9].*[0-9] pypkg/__init__.py`

rm dist/*
./setup.py sdist
ls -lsa dist

