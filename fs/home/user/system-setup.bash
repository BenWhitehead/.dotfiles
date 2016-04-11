#!/bin/bash
 
function installPackages() {

  WHITELIST=""
  WHITELIST="${WHITELIST} htop"
  WHITELIST="${WHITELIST} iotop"
  WHITELIST="${WHITELIST} iftop"
  WHITELIST="${WHITELIST} ncdu"
  WHITELIST="${WHITELIST} tmux"
  WHITELIST="${WHITELIST} tree"
  WHITELIST="${WHITELIST} python-pip"
  WHITELIST="${WHITELIST} jq"
  WHITELIST="${WHITELIST} git-core"
  WHITELIST="${WHITELIST} google-chrome"

  zypper install ${WHITELIST}
  pip install httpie
}

 
function purgePackages() {
  
  BLACKLIST=""
  BLACKLIST="${BLACKLIST} mariadb"
  BLACKLIST="${BLACKLIST} mariadb-client"
  BLACKLIST="${BLACKLIST} mariadb-errormessages"
  BLACKLIST="${BLACKLIST} libmysqld18"
  BLACKLIST="${BLACKLIST} akonadi"
  BLACKLIST="${BLACKLIST} akonadi-runtime"
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
  
  zypper remove --clean-deps ${BLACKLIST}
  zypper addlock ${BLACKLIST}
  
}
  
