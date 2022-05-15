#!/bin/sh
#
# Install .emacs.d symlink in home directory. 

CONFDIR=$HOME/.emacs.d

if [ -e $CONFDIR ]
then
  test -L $CONFDIR || mv $CONFDIR ${CONFDIR}.backup
fi
ln -Tsf `pwd` $HOME/.emacs.d
