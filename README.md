# What is this?

This is a basic project that demonstrates how to quickly get started developing a HipChat integration using [ac-flask-hipchat](https://bitbucket.org/mrdon/ac-flask-hipchat).

It uses a basic [Vagrant](https://www.vagrantup.com) configuration to provide one option for quickly getting started with a basic setup using the following dependencies:

* Redis 
* Mongodb 
* ngrok 
* a simple example addon

# How do I use it?

Make sure that you have both [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed, then start by cloning this project from git:

```
git clone https://bitbucket.org/mrdon/ac-flask-hipchat-vagrant hipchat-example
```

You'll also need to install [Vagrant](https://www.vagrantup.com).  When that's done, run the following commands:

```
> cd /path/to/hipchat-example
> vagrant up
# a few minutes later....
> vagrant ssh
Welcome to your Vagrant-built virtual machine.
Last login: Sun Sep  7 06:03:27 2014 from 10.0.2.2

Tunnel established at https://xxxx.ngrok.com

$ cd project
$ python app.py
```

You should now have an installable HipChat integration running at some unique url, like `https://xxxx.ngrok.com`, where the `xxxx` value will be a unique id for your server.

The `project` directory in /home/vagrant in the guest VM is a share that mounts the cloned git repository on your host OS.  You can do your development either in the VM or, more likely, using your favorite editor or IDE running in the host OS.

Now, to install the add-on at hipchat.com, see the instructions [here](https://api.hipchat.com/docs/apiv2/addons).
