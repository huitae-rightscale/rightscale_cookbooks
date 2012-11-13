#
# Cookbook Name:: web_apache
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

service "nginx" do
  action :stop
  only_if do
    File.exists?("/var/run/nginx.pid")
  end
end

package "nginx" do
  action :remove
  only_if do
    File.exists?("/etc/init.d/nginx")
  end
end

package "nginx" do
  action :install
end

service "nginx" do
  action :start
end

service "nginx" do
  action :stop
end

rightscale_marker :end
