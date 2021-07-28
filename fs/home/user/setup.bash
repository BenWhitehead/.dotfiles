#!/bin/bash
set -o errexit -o nounset -o pipefail

OPENSUSE_VERSION=${OPENSUSE_VERSION:-"openSUSE_Factory"}

function globals {                                                                                                                                            
  export LC_ALL=en_US.UTF-8                  # A locale that works consistently                                                                               
  export LANG="$LC_ALL"                                                                                                                                       
}; globals

function addRepos {

#  sudo zypper ar --refresh http://download.opensuse.org/repositories/Cloud:/Tools/${OPENSUSE_VERSION}/ ext:cloud:tools
#  sudo zypper ar --refresh http://download.opensuse.org/repositories/Virtualization/${OPENSUSE_VERSION}/ ext:virtualization
#  sudo zypper ar --refresh http://download.opensuse.org/repositories/devel:/tools/${OPENSUSE_VERSION}_ARM/ ext:devel:tools
    # cloc
#  sudo zypper ar --refresh http://download.opensuse.org/repositories/devel:/tools:/scm/${OPENSUSE_VERSION}/ ext:devel:tools:scm
    # git-core tig
#  sudo zypper ar --refresh http://download.opensuse.org/repositories/utilities/${OPENSUSE_VERSION}/ ext:utilities
    # jq ncdu tmux 
  
  sudo zypper ar --refresh http://dl.google.com/linux/chrome/rpm/stable/x86_64 google-chrome
  #sudo zypper ar --refresh http://dl.google.com/linux/talkplugin/rpm/stable/x86_64 google-talkplugin

  sudo zypper --non-interactive --gpg-auto-import-keys refresh
}

function installPackages() {

  WHITELIST=""
#  WHITELIST="${WHITELIST} cloc"
  WHITELIST="${WHITELIST} docker"
  WHITELIST="${WHITELIST} docker-bash-completion"
  WHITELIST="${WHITELIST} git-core"
  WHITELIST="${WHITELIST} google-chrome"
  WHITELIST="${WHITELIST} htop"
  WHITELIST="${WHITELIST} iftop"
  WHITELIST="${WHITELIST} iotop"
  WHITELIST="${WHITELIST} jq"
  WHITELIST="${WHITELIST} ncdu"
  WHITELIST="${WHITELIST} python-pip"     # needed by httpie
  WHITELIST="${WHITELIST} python3-curses" # needed by httpie
  WHITELIST="${WHITELIST} tig"
  WHITELIST="${WHITELIST} tmux"
  WHITELIST="${WHITELIST} tree"
  WHITELIST="${WHITELIST} xclip"
  WHITELIST="${WHITELIST} pv"

  # mesos build deps
  WHITELIST="${WHITELIST} automake"
  WHITELIST="${WHITELIST} gcc"
  WHITELIST="${WHITELIST} gcc-c++"
  WHITELIST="${WHITELIST} zlib-devel"
  WHITELIST="${WHITELIST} libcurl-devel"
  WHITELIST="${WHITELIST} libapr1-devel"
  WHITELIST="${WHITELIST} subversion-devel"
  WHITELIST="${WHITELIST} cyrus-sasl-devel"
  WHITELIST="${WHITELIST} libtool"


  sudo zypper --non-interactive install --no-recommends ${WHITELIST}
 
  sudo pip install httpie
  
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall

  # Rust packages to install
  # cargo install exa ripgrep bat fd-find xsv xv
  # ps -> procs nano -> kibi du-dust -> dust time -> hyperfine top -> ytop iftop -> bandwhich
  # hexdump -> hx objdump -> bingrep
}

 
function purgePackages() {
  
  BLACKLIST=""
  BLACKLIST="${BLACKLIST} mariadb"
  BLACKLIST="${BLACKLIST} mariadb-client"
  BLACKLIST="${BLACKLIST} mariadb-errormessages"
  BLACKLIST="${BLACKLIST} libmysqld18"
  BLACKLIST="${BLACKLIST} akonadi"
  BLACKLIST="${BLACKLIST} akonadi-runtime"
  BLACKLIST="${BLACKLIST} akonadi-server"
  BLACKLIST="${BLACKLIST} korganizer"
  BLACKLIST="${BLACKLIST} kontact"
  BLACKLIST="${BLACKLIST} kmail"
  BLACKLIST="${BLACKLIST} knotes"
  BLACKLIST="${BLACKLIST} kaddressbook"
  BLACKLIST="${BLACKLIST} kdeipm4"
  BLACKLIST="${BLACKLIST} kdeipm4-runtime"
  BLACKLIST="${BLACKLIST} amarok"
  
  
  BLACKLIST="${BLACKLIST} libreoffice"
  BLACKLIST="${BLACKLIST} libreoffice-calc"
  BLACKLIST="${BLACKLIST} libreoffice-draw"
  BLACKLIST="${BLACKLIST} libreoffice-impress"
  BLACKLIST="${BLACKLIST} libreoffice-math"
  BLACKLIST="${BLACKLIST} libreoffice-writer"
  BLACKLIST="${BLACKLIST} libreoffice-icon-theme-oxygen"
  BLACKLIST="${BLACKLIST} libreoffice-share-linker"

  BLACKLIST="${BLACKLIST} mariadb"
  BLACKLIST="${BLACKLIST} mariadb-client"
  
  sudo zypper remove --clean-deps ${BLACKLIST}
  sudo zypper addlock ${BLACKLIST}
  
}
  
function linkItems {
  local scriptDir=$(pwd -P)

  ( 
    cd ~

    rm -rf .bash
    ln -s ${scriptDir}/.bash

    rm -rf .bashrc
    ln -s ${scriptDir}/.bashrc

    rm -rf .profile 
    ln -s ${scriptDir}/.profile

    rm -rf .vimrc
    ln -s ${scriptDir}/.vimrc

    rm -rf .tmux.conf
    ln -s ${scriptDir}/.tmux.conf
 
    rm -rf .gitconfig
    ln -s ${scriptDir}/.gitconfig

    rm -rf .ripgreprc
    ln -s ${scriptDir}/.ripgreprc
  )

  (
    cd ~/bin || mkdir -p ~/bin && cd ~/bin

    for b in $(ls -1 ${scriptDir}/bin/*);do
      ln -s $b 
    done
  )

}

function configureMaven() { ( 
  for t in $(find ./ -maxdepth 1 -type f -name 'apache-maven-*-bin.tar.gz' | sort -r); do
    tar xf $t
    dirName=$(echo $t | sed -e 's#^\./##g' | sed -e 's#-bin.tar.gz##g')
    majMin=$(echo $dirName | sed -e 's#apache-maven-##g' | cut -d'.' -f1-2)
    maj=$(echo $majMin | cut -d'.' -f1)
    ln -s $dirName $majMin 2>/dev/null || true
    ln -s $majMin $maj 2>/dev/null || true
    ln -s $maj latest 2>/dev/null || true
  done
) }

function main {(

  purgePackages
  addRepos
  installPackages
  linkItems 

)}

######################## Delegates to subcommands or runs main, as appropriate
if [[ ${1:-} ]] && declare -F | cut -d' ' -f3 | fgrep -qx -- "${1:-}"
then "$@"
else err "unknown command"; exit 1
fi

