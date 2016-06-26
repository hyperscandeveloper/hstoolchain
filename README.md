HSToolchain
===========

What does this do?
------------------

This program will automatically build and install a compiler and other
tools used in the creation of homebrew software for the Mattel Hyperscan
video game console.

How do I use it?
----------------

1. Set up your environment by installing the following software: 
   `gcc, make, patch, wget`

2. Add the following to your login script:
```
export HSDEV=/usr/local/hsdev
export PATH=$PATH:$HSDEV/score-elf/bin
export PATH=$PATH:$HSDEV/bin
```

3. Run the toolchain script: 
   `./toolchain.sh`

Where do I go from here?
------------------------

Visit the following sites to learn more:

* http://hyperscan.fr.yuku.com/
