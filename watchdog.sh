#!/bin/bash -

basedir="/Users/Leon/GDrive/Workspace/JLDoc"
cd ${basedir}
watchmedo shell-command  -D ${basedir}/source/  -R -p "*.md;*.rst" -c " make -C ${basedir} html"
