#!/bin/bash
# note that the path for the symlink assumes this script stays in the jupyter-lab folder
# note sure if this would behave with WSL?

# Jupyter lab settings probably reside in ~/.jupyter/lab/user-settings/@jupyterlab (match that root node to @jupyterlab in this folder)

read -p "Confirm location of settings at ~/.jupyter/lab/user-settings/@jupyterlab (y/n)?" answer
case ${answer:0:1} in
    y|Y )
        echo "Symlinking config files."

        parentdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
        rm -r ~/.jupyter/lab/user-settings/@jupyterlab
        ln -s ${parentdir}/jupyter-lab/@jupyterlab ~/.jupyter/lab/user-settings/@jupyterlab

        echo "Jupyterlab config files linked."
    ;;
    * )
        echo No
        echo "Jupyterlab config cancelled."
    ;;
esac


