#!/usr/bin/python

import os
import re
from sys import exit
from subprocess import check_output
from shutil import which, move, rmtree

home_dir = os.environ.get('HOME')
dotfiles_dir = home_dir + '/dotfiles'
packet_manager = ''

def get_package_manager_install():
    if which('dnf') is not None:
        return 'dnf'
    elif which('dnf') is not None:
        return 'yum'
    elif which('apt') is not None:
        return 'apt'
    elif which('pacman') is not None:
        return 'pacman'

def find_all_dotfiles_in_dir(path):
    return [f for f in os.listdir(path) if f[0] == '.' \
        and f != '.' \
        and f != '..' \
        and f != '.git' \
        and f != '.gitignore']

def clone_git_repo():
    try:
        packet_manager = get_package_manager_install()
        print('Clonning dotfiles repo')
        if which('git') is None:
            if packet_manager != 'pacman':
                check_output(['/usr/bin/sudo', packet_manager, 'install', 'git', '-y'])
            else:
                check_output(['/usr/bin/sudo', packet_manager, '-Syu', 'git', '-y'])
                
        if os.path.exists(dotfiles_dir):
            if os.path.exists(dotfiles_dir + '.old'):
                rmtree(dotfiles_dir + '.old')

            os.rename(dotfiles_dir, dotfiles_dir + '.old')    

        check_output(['/usr/bin/git', 'clone', 'https://github.com/Gel0bmstu/dotfiles', dotfiles_dir])
        print('Dotfiles repo clenned sucessfully to', dotfiles_dir)
    except Exception as e:
        print('Unable to clone dotfiles repo: {}'.format(e)) 
        exit(1)

def set_dotfiles():
    try:
        print('Setting dotfiles to', home_dir)
        repo_dotfiles = find_all_dotfiles_in_dir(dotfiles_dir)

        if os.path.exists(home_dir + '/.old'):
            rmtree(home_dir + '/.old')
        
        os.mkdir(home_dir + '/.old')

        print('Dotfiles list:', repo_dotfiles)
        
        for f in repo_dotfiles:
            if os.path.exists(home_dir + '/' + f):
                move(home_dir + '/' + f, home_dir + '/.old/')
            os.symlink(dotfiles_dir + '/' + f, home_dir + '/' + )

        data=''
        with open(home_dir + '/.bashrc', 'r') as f:
            content = f.read()
            data = re.sub("pmng=\*$", "pmng=\'{}\'".format(packat_manager), content)

        with open(home_dir + '/.bashrc', 'w') as f:
            f.write(data)

    except Exception as e:
        print('Unable to set dotfiles: {}'.format(e))
        exit(1)


if __name__ == '__main__':
    clone_git_repo()
    set_dotfiles()
