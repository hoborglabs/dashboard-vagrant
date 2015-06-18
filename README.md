# dashboard-vagrant

Vagrant + chef-solo configs to set up Dashboard VM in just minutes.

It's simple as `vagrant up`, and in few minutes you will get Centos VM with latest dashboard installed and ready to play
with.




## Standalone .box

You can simply download pre-build box with installed dashboard.

```
vagrant add dashboard http://get.hoborglabs.com/dashboard.box
vagrant up
```




## Updating Dashboard Codebase

There are few ways to update dashboard codebase. It all depends if you're using VM for dashboard core development or
just simply using it with your own widgets.

To simply check for updates.
```
vagrant ssh
cd /var/code/dashboard.local/
php composer.phar update
```

If you are running VM in development mode, you simply want to `git pull` on selected repos

```
vagrant ssh
cd /var/code/dashboard/
git pull
cd /var/code/widgets/
git pull
```
