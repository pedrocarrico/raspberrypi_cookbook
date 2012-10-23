Description
===========

This is a set of chef recipes ready to be cooked on the raspberry pi.

Requirements
============

Platform:

* Raspbian Wheezy

On a clean raspian before applying any recipe you must do:
```
sudo raspi-config # update raspi-config, set overclocking..etc..etc..
sudo apt-get install rsync # knife needs this to update the cookbooks on the pi
```
Be sure to put your public SSH key on the Raspberry before cooking.

To begin cooking you must:
```
gem install knife-solo
knife configure -r . --defaults
knife prepare root@raspberrypi
# configure the recipes you want to cook on your node, use raspberrypi.json.sample as a template if you wish
knife cook root@raspberrypi
```
Copyright
============

Licensed under the [WTFPL](http://en.wikipedia.org/wiki/WTFPL "Do What The Fuck You Want To Public License") license.
