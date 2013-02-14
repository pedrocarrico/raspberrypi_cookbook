#
# Cookbook Name:: ralink-RT5370
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "wpasupplicant"
package "usbutils"
package "wireless-tools"

template "/etc/wpa_supplicant/wpa_supplicant.conf" do
  source "wpa_supplicant.conf.erb"
  group "root"
  owner "root"
  mode 00766
end

script "bring interface up" do
  interpreter "bash"
  user "root"
  code <<-EOH
    ifdown wlan0
    ifup wlan0
    EOH
end
