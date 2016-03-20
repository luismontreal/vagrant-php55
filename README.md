vagrant-php55 by cakebake
=========================

Vagrant box **cakebake.dev** with

-	PHP 5.5
-	Ioncube
-	XDebug (Because of usage with ioncube, start an xdebug session with `xdebug_break();` function in your code)
-	Apache
-	Composer
-	MySQL (Root-User login with `root:root`, Adds default user with `user:password` for database `db`\)

Installation
------------

1.	Download or Clone this repo
2.	Add a new hosts entry (on Linux to **/etc/hosts**) `192.168.33.99 cakebake.dev www.cakebake.dev`
3.	Open your terminal, navigate to this folder and start vagrant with `vagrant up`
4.	Open your browser and go to `http://localhost:8080` or `http://cakebake.dev`

Usage
-----

See vagrant documentation.

Configuration
-------------

You could configure the whole system with **ansible** and **Vagrantfile**. Take a look at `Vagrantfile` and `ansible/vars/all.yml` to change vm definition. After changes reload your VM with `vagrant reload --provision`.

XDebug is predefined for best interaction with partial encrypted code with ioncube. You could change XDebug settings in `ansible/roles/app/templates/99-custom.ini` and reload your VM with `vagrant reload --provision`.

License
-------

MIT
