#!/usr/bin/python

import os
import shutil
import sys
import logging

from collections import namedtuple
from datetime import datetime


DT_FMT = "%Y-%m-%d_%H-%M-%S"


_id = lambda x: x
_path = os.path.join
_exists = os.path.exists


Env = namedtuple('Env', ['home', 'root', 'cfg_path', 'backup_dir'])
Dotfile = namedtuple('Dotfile', ['name', 'src', 'dst'])


LOG = logging.getLogger()
LOG.addHandler(logging.StreamHandler())
LOG.setLevel(logging.DEBUG)


def command_registry(cls):
    registry = dict((
        (name, method.__doc__) for name, method in cls.__dict__.iteritems()
        if hasattr(method, 'registry')
    ))

    def dispatch(app):
        args = sys.argv[1:]
        cmd = 'help'
        params = []

        if args:
            cmd, params = args[0], args[1:]

        getattr(app, cmd if cmd in app.registry.keys() else 'help')(*params)

    def help(app, *args):
        print("Available commands:\n")
        print("\t" + "\n\t".join(
            ["\t".join((k, v or "")) for k, v in app.registry.iteritems()]
        ))

    cls.registry = registry
    cls.dispatch = dispatch
    cls.help = help

    return cls


def command(fn):
    def wrapper(self, *args, **kwargs):
        fn(self, *args, **kwargs)

    wrapper.registry = True
    wrapper.__doc__ = fn.__doc__

    return wrapper


@command_registry
class App(object):
    default_cfg = "\n".join((
        '.bashrc',
        '.conkyrc',
        '.emacs',
        '.ghci',
        '.hgrc',
        '.hgrc',
        '.irbrc',
        '.jshintrc',
        '.profile',
        '.pylintrc',
        '.screenrc',
        '.tmux.conf',
        '.vimperatorrc',
        '.vimrc',
        '.zshrc',
    ))

    def __init__(self):
        home = os.environ.get('HOME')
        root = _path(home, ".dotfiles")
        self.env = Env(
            home,
            root,
            _path(root, '.dotconfig'),
            _path(root, 'backups'),
        )
        self.cfg = self.read_cfg()

    def read_cfg(self):
        try:
            with open(self.env.cfg_path, 'r') as f:
                return f.read()
        except IOError:
            return ""

    def write_cfg(self, cfg):
        mkdirs(self.env.cfg_path)
        with open(self.env.cfg_path, 'w') as f:
            f.write(cfg)
            return cfg

    def mk_dotfile(self, path):
        src = _path(self.env.home, normalise(path))
        dst = src.replace(self.env.home, self.env.root)
        return Dotfile(path, src, dst)

    def dotfiles(self, fltr):
        if not getattr(self, "_dotfiles", None):
            self._dotfiles = map(
                self.mk_dotfile,
                set(p for p in self.cfg.splitlines() if p)
            )
        return filter(fltr, self._dotfiles)

    @command
    def install(self):
        self.cfg = self.cfg or self.write_cfg(self.default_cfg)
        self.backup()
        map(link, self.dotfiles(pending))

    @command
    def uninstall(self):
        map(unlink, self.dotfiles(tracked))

    @command
    def add(self, *names):
        existing_paths = [d.src for d in self.dotfiles(_id)]
        names_to_add = set(
            n for n in names
            if normalise(n) not in existing_paths
            and _exists(normalise(n))
        )

        self.write_cfg("\n".join(
            names_to_add.union((d.name for d in self.dotfiles(_id)))
        ))
        [link(self.mk_dotfile(n)) for n in names_to_add]

    @command
    def status(self):
        print("Tracked:\n\t" + "\n\t".join(
            (d.name for d in self.dotfiles(tracked))))
        print("Pending:\n\t" + "\n\t".join(
            (d.name for d in self.dotfiles(pending))))
        print("Invalid:\n\t" + "\n\t".join(
            (d.name for d in self.dotfiles(lambda x: not valid(x)))
        ))

    @command
    def forget(self, *names):
        _names = [normalise(n) for n in names]
        try:
            [unlink(self.mk_dotfile(x)) for x in _names]
        except OSError:
            pass
        self.write_cfg(
            "\n".join([n for n in self.cfg.splitlines() if n not in _names]))

    @command
    def gen_cfg(self):
        ignore = [
            ".git", ".gitignore", "dotfiles.py", "dotfiles.pyc", "README",
            ".dotconfig", ".ropeproject", "backups"]

        self.write_cfg("\n".join(
            [self.mk_dotfile(n).name for n in os.listdir(self.env.root)
             if n not in ignore]))

    def backup(self):
        dotfiles = self.dotfiles(valid)
        if dotfiles:
            dirname = _path(
                self.env.backup_dir, datetime.strftime(datetime.now(), DT_FMT))
            os.makedirs(dirname)
            [cp(d.src, _path(dirname, os.path.basename(d.src)))
             for d in dotfiles]


def valid(dotfile):
    return _exists(dotfile.src)


def pending(dotfile):
    return _check_lazy(dotfile, all, (
        lambda x: not tracked(x),
        valid,
    ))


def tracked(dotfile):
    return _check_lazy(dotfile, all, (
        valid,
        linked,
    ))


def linked(dotfile):
    try:
        return os.readlink(dotfile.src) == dotfile.dst and _exists(dotfile.dst)
    except OSError, e:
        return False


def _check_lazy(dotfile, method, checks):
    return method((check(dotfile) for check in checks))


def link(dotfile):
    if not _exists(dotfile.dst):
        mkdirs(dotfile.dst)
        mv(dotfile.src, dotfile.dst)
        os.symlink(dotfile.dst, dotfile.src)
        LOG.info("%s linked to %s", dotfile.src, dotfile.dst)


def unlink(dotfile):
    mv(dotfile.dst, dotfile.src)
    LOG.info("%s unlinked", dotfile.src)


def mkdirs(p):
    dirname = os.path.dirname(p)
    if not _exists(dirname):
        os.makedirs(dirname)
        LOG.info("%s created", p)


def cp(src, dst):
    (shutil.copytree if os.path.isdir(src) else shutil.copy)(src, dst)


def rm(p):
    (os.remove if os.path.islink(p) or os.path.isfile(p) else shutil.rmtree)(p)


def mv(src, dst):
    if os.path.islink(src):
        _src = os.readlink(src)
        rm(src)
        cp(_src, src)

    shutil.move(src, dst)
    LOG.info("%s moved to %s", src, dst)


def normalise(path):
    return os.path.expanduser(path.strip("*").rstrip("/"))


if __name__ == "__main__":
    App().dispatch()
