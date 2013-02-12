#
# Cookbook Name:: samba
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "samba" do 
  not_if "test -f /usr/bin/smbclient"
end

package "cifs-utils" do
  not_if "test -f /sbin/mount.cifs"
end

group "guest"

user "guest" do
  gid "guest"
  shell "/bin/false"
end

directory "/home/public" do
  owner "guest"
  group "guest"
  mode 00700
end

template "/etc/samba/smb.conf" do
  source "smb.conf.erb"
  group "root"
  owner "root"
  mode 00755
end

service "samba" do
  action :restart
end
