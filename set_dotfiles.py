#!/usr/bin/python

import os
from sys import exit
from subprocess import check_output
from shutil import which, move, rmtree

home_dir = os.environ.get('HOME')
dotfiles_dir = home_dir + '/dotfiles'

def get_package_manager_install():
    if which('dnf') is not None:
        return 'dnf install'
    elif which('apt') is not None:
        return 'apt isntall'
    elif which('pacman') is not None:
        return 'pacman -Syu'

def find_all_dotfiles_in_dir(path):
    return [f for f in os.listdir(path) if f[0] == '.' \
        and f != '.' \
        and f != '..' \
        and f != '.git' \
        and f != '.gitignore']

def clone_git_repo():
    try:
        if which('git') is None:
            check_output(['/usr/bin/sudo', get_package_manager_install(), 'git', '-y'])

        if os.path.exists(dotfiles_dir):
            if os.path.exists(dotfiles_dir + '.old'):
                rmtree(dotfiles_dir + '/.old')

            os.rename(dotfiles_dir, dotfiles_dir + '.old')    

        check_output(['/usr/bin/git', 'clone', 'https://github.com/Gel0bmstu/dotfiles', dotfiles_dir])
    except Exception as e:
        print('Unable to clone dotfiles repo: {}'.format(e)) 
        sys.exit(1)

def set_dotfiles():
    try:
        repo_dotfiles = find_all_dotfiles_in_dir(dotfiles_dir)

        if os.path.exists(home_dir + '/.old'):
            rmtree(home_dir + '/.old')
        
        os.mkdir(home_dir + '/.old')

        for f in repo_dotfiles:
            if os.path.exists(home_dir + '/' + f):
                move(home_dir + '/' + f, home_dir + '/.old/')
            os.symlink(dotfiles_dir + '/' + f, home_dir + '/' + f)
    except Exception as e:
        print('Unable to set dotfiles: {}'.format(e))
        sys.exit(1)


if __name__ == '__main__':
    clone_git_repo()
    set_dotfiles()
