#
# Cookbook Name:: web_apache
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

package "nginx" do
  action :install
end

directory "/var/nginx/html" do
  group "root"
  user "root"
  mode "0755"
  recursive :true
  action :create
end

template "/etc/nginx/conf.d/default.conf" do
  source "default.conf.erb"
  variables(
    :index_root => node[:config][:index_root]
  )
end

execute "setup index.html" do
 command "tar cvfz htkim_nginx.tar"
 creates "/var/nginx/html/index.html"
 action :nothing
end

service "nginx" do
  action :start
end

rightscale_marker :end
