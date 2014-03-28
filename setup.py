from fabric.api import local, lcd
from fabric.context_managers import hide
from urllib import urlretrieve
import sys
import os
import time


class InstallManager(object):
    vb_url = 'http://download.virtualbox.org/virtualbox/4.3.10/VirtualBox-4.3.10-93012-OSX.dmg'
    pycharm_url = 'http://download.jetbrains.com/python/pycharm-professional-3.1.1.dmg'
    vagrant_url = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.1.dmg'
    pgadmin_url = 'http://ftp.postgresql.org/pub/pgadmin3/release/v1.18.1/osx/pgadmin3-1.18.1.dmg'
    hipchat_url = 'https://www.hipchat.com/downloads/latest/mac'

    def _url_status(self, *args):
        if args[0] % 250 == 0:
            sys.stdout.write('.')
            sys.stdout.flush()

    def _dl_file(self, url, fn):
        if os.path.isfile(fn):
            print '** file {} already exists'.format(fn)
        else:
            print "** downloading {}".format(url.split('/')[-1])
            urlretrieve(url, fn, self._url_status)

    def _open_dmg(self, fn):
        print "** opening {}".format(fn)
        local('open {}'.format(fn))
        time.sleep(10)

    def _umount_dmg(self, path):
        print "** unmounting %s" % path
        local('diskutil unmount %s' % path)

    def _install_pkg(self, fn):
        print "** installing {}".format(fn)
        local('sudo installer -package {} -target /'.format(fn))

    def _brew_install(self, pkg):
        try:
            local('brew install %s' % pkg)
        except:
            pass

    def _dl_dmg_pkg_flow(self, *args, **kwargs):
        url = kwargs['url']
        vol = os.path.join('/Volumes', kwargs['volume'])
        pkg = kwargs['pkg']
        fn = url.split('/')[-1]

        if 'name' in kwargs:
            res = local('which %s' % kwargs['name'], capture=True)
            if not res == '':
                return

        self._dl_file(url, fn)
        self._open_dmg(fn)
        self._install_pkg(os.path.join(vol, pkg))
        self._umount_dmg(vol)

    def _dl_dmg_app_flow(self, *args, **kwargs):
        url = kwargs['url']
        fn = url.split('/')[-1]
        if not kwargs['volume'] == None:
            vol = os.path.join('/Volumes', kwargs['volume'])
        else:
            vol = '.'

        app = kwargs['app']

        self._dl_file(url, fn)

        dmg_app_fn = os.path.join(vol, app)
        app_app_fn = os.path.join('/tmp', app)

        if not os.path.isdir(app_app_fn):
            self._open_dmg(fn)
            local('cp -R %s %s' % (dmg_app_fn, app_app_fn))
            self._umount_dmg(vol)
        else:
            print "%s is already installed." % app


    def install_pycharm(self):
        print "\n\nInstalling PyCharm"
        url = self.pycharm_url
        self._dl_dmg_app_flow(
            url=url,
            volume='PyCharm',
            app='PyCharm.app',
        )

    def install_virtualbox(self):
        print "\n\nInstalling VirtualBox..."
        url = self.vb_url
        self._dl_dmg_pkg_flow(
            name='VBoxManage',
            url=url,
            volume='VirtualBox',
            pkg='VirtualBox.pkg',
        )


    def install_vagrant(self):
        print "\n\nInstalling vagrant..."
        url = self.vagrant_url
        self._dl_dmg_pkg_flow(
            name='vagrant',
            url=url,
            volume='Vagrant',
            pkg='Vagrant.pkg',
        )

    def install_homebrew(self):
        print "\n\nInstalling Homebrew..."
        try:
            local('ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"')
        except:
            pass

    def install_git(self):
        print '\n\nUpgrading git...'
        self._brew_install('git')

    def install_node(self):
        print '\n\nInstalling node...'
        self._brew_install('node')

    def install_grunt_cli(self):
        print '\n\nInstalling Grunt...'
        local('sudo npm install -g grunt-cli')

    def install_pgadmin(self):
        print '\n\nInstalling PGAdmin III...'
        url = self.pgadmin_url
        self._dl_dmg_app_flow(
            url=url,
            volume='pgAdmin3',
            app='pgAdmin3.app',
        )

    def install_hipchat(self):
        print '\n\nInstalling HipChat...'
        url = self.hipchat_url
        self._dl_dmg_app_flow(
            url=url,
            volume=None,
            app='HipChat.app',
        )

    def generate_pk(self):
        dotssh = os.path.expanduser('~/.ssh/')
        files = ('id_dsa', 'id_rsa')
        pk_exists = False
        for f in files:
            if os.path.isfile(os.path.join(dotssh, f)):
                pk_exists = True
                break

        if not pk_exists:
            print '\n\nCreating a private key for you.'
            local('ssh-keygen -t dsa')

    def __init__(self, *args, **kwargs):
        self.generate_pk()
        self.install_homebrew()
        self.install_git()
        self.install_virtualbox()
        self.install_pycharm()
        self.install_vagrant()
        self.install_node()
        self.install_grunt_cli()
        self.install_pgadmin()
        self.install_hipchat()


if __name__ == '__main__':
    print "Welcome to Djed Studios. We'll begin installing your system now."
    with hide('running', 'stdout', 'stderr'):
        InstallManager()

    print """
        Thanks for using the Djed Studios workstation setup.

        Your workstation is now configured. You might find it helpful to copy
        your ssh key to your pasteboard, so as to add it to github.

        $ pbcopy < ~/.ssh/id_dsa.pub

        Thanks!
    """