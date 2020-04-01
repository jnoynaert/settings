#!/bin/bash
# may need to chmod u+x this file

# git settings
echo "Symlinking git config."

parentdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
rm -r ~/.gitconfig
ln -s ${parentdir}/git/.gitconfig ~/.gitconfig

echo "Git config linked."

# Jupyter lab settings
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