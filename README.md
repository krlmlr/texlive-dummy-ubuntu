texlive-dummy-ubuntu
====================

Source code for a dummy package for Ubuntu that claims that it provides a complete TeXlive installation.
Useful if you [install TeXlive from source](http://www.tug.org/texlive/debian.html).

Install the package on Ubuntu 13.04 (Raring Ringtail) from the corresponding PPA (as root):

    add-apt-repository ppa:krlmlr/ppa
    apt-get update
    apt-get install texlive-dummy
