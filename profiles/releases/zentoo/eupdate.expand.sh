#!/bin/bash

case $1 in

# docbook slots
app-text/docbook-sgml-dtd)               echo "=$1-3.0-r3"
                                         echo "=$1-3.1-r3"
                                         echo "=$1-4.0-r3"
                                         echo "=$1-4.1-r3";;
app-text/docbook-xml-dtd)                echo "=$1-4.1.2-r6"
                                         echo "=$1-4.2-r2"
                                         echo "=$1-4.3-r1"
                                         echo "=$1-4.4-r2"
                                         echo "=$1-4.5-r1";;
app-text/docbook-xml-simple-dtd)         echo "=$1-1.0-r1"
                                         echo "=$1-4.1.2.4-r2";;

# autoconf/make slots
sys-devel/autoconf)                      echo "=$1-2.13"
                                         echo "$1";;
sys-devel/automake)                      echo "=$1-1.11.6"
                                         echo "=$1-1.12.6"
                                         echo "$1";;

# python
dev-lang/python)                         echo "=$1-2.7.5-r3";;
dev-lang/python-exec)                    echo "=$1-0.3.1"
                                         echo "=$1-2.0.1";;
dev-python/python-exec)                  echo "=$1-10000.1"
                                         echo "=$1-10000.2";;
dev-python/ctypesgen)                    echo "=$1-0_p72-r1";;
dev-python/gdata)                        echo "=$1-2.0.18";;
dev-python/python-ldap)                  echo "=$1-2.4.10-r1";;
dev-python/python-openid)                echo "=$1-2.2.5-r1";;
dev-python/pyyaml)                       echo "=$1-3.10-r1";;
dev-python/rpy)                          echo "=$1-2.3.10";;
dev-python/suds)                         echo "=$1-0.4-r1";;

# ruby
dev-lang/ruby)                           echo "=$1-1.9.3_p484"
                                         echo "=$1-2.0.0_p353";;
dev-ruby/rubygems)                       echo "=$1-1.8.25"
                                         echo "$1";;
virtual/rubygems)                        echo "=$1-4"
                                         echo "=$1-6";;
virtual/ruby-ffi)                        echo "=$1-2";;
virtual/ruby-ssl)                        echo "=$1-1"
                                         echo "=$1-3";;
virtual/ruby-threads)                    echo "=$1-1"
                                         echo "=$1-4";;
dev-ruby/activesupport)                  echo "=$1-3.2.17";;
dev-ruby/bson)                           echo "=$1-1.6.2-r1";;
dev-ruby/childprocess)                   echo "=$1-0.5.1";;
dev-ruby/diff-lcs)                       echo "=$1-1.2.5";;
dev-ruby/erubis)                         echo "=$1-2.7.0-r1";;
dev-ruby/eventmachine)                   echo "=$1-1.0.3-r1";;
dev-ruby/ffi)                            echo "=$1-1.9.3";;
dev-ruby/log4r)                          echo "=$1-1.1.10-r1";;
dev-ruby/multi_json)                     echo "=$1-1.9.2";;
dev-ruby/net-scp)                        echo "=$1-1.1.2-r1";;
dev-ruby/net-ssh)                        echo "=$1-2.7.0-r1";;
dev-ruby/net-ssh-multi)                  echo "=$1-1.1";;
dev-ruby/rake-compiler)                  echo "=$1-0.9.2";;
dev-ruby/yard)                           echo "=$1-0.8.7.3-r1";;

# php
dev-lang/php)                            echo "=$1-5.3.28-r3"
                                         echo "=$1-5.4.26";;
virtual/httpd-php)                       echo "=$1-5.3"
                                         echo "=$1-5.4-r1";;

# java
dev-java/oracle-jdk-bin)                 echo "=$1-1.7.0.55"
                                         echo "=$1-1.8.0.5";;
dev-java/javatoolkit)                    echo "=$1-0.3.0-r9";;
virtual/jdk)                             echo "=$1-1.7.0"
                                         echo "=$1-1.8.0";;
virtual/jre)                             echo "=$1-1.7.0"
                                         echo "=$1-1.8.0";;

# kernel
sys-kernel/gentoo-sources)               echo "=$1-3.12.21-r1";;
sys-kernel/linux-headers)                echo "=$1-3.12";;

# virtualbox
app-emulation/virtualbox-extpack-oracle) echo "=$1-4.3.12.93733";;
app-emulation/virtualbox*)               echo "=$1-4.3.12";;
dev-util/kbuild)                         echo "=$1-0.1.9998_pre20131130";;

app-editors/vim*)                        echo "=$1-7.4.155";;
app-text/asciidoc)                       echo "=$1-8.6.8-r1";;
dev-db/postgresql-server)                echo "=$1-9.3.4-r1";;
dev-db/postgresql-*)                     echo "=$1-9.3.4";;
dev-lang/yasm)                           echo "=$1-1.2.0-r1";;
dev-libs/zziplib)                        echo "=$1-0.13.62";;
dev-util/systemtap)                      echo "=$1-2.4-r1";;
dev-vcs/bzr)                             echo "=$1-2.6.0";;
media-gfx/graphviz)                      echo "=$1-2.36.0";;
net-analyzer/nmap)                       echo "=$1-6.40-r1";;
sys-apps/systemd)                        echo "=$1-212-r2";;
sys-block/btrace)                        echo "=$1-1.0.3";;
sys-devel/bc)                            echo "=$1-1.06.95-r1";;
sys-fs/ncdu)                             echo "=$1-1.10";;
sys-kernel/gentoo-sources)               echo "=$1-3.10.36";;
virtual/jpeg)                            echo "=$1-0-r2";;
sys-libs/libcap-ng)                      echo "=$1-0.7.4";;
*)                                       echo $1;;
esac
