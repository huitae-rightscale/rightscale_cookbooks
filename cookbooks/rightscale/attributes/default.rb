#
# Cookbook Name:: rightscale
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

#
# RightScale Enviroment Attributes.
# These are needed by all RightScale Cookbooks.  rightscale should be included in all server templates
# so these attributes are declared here.

#
# Optional attributes
#
set_unless[:rightscale][:timezone] = "UTC"
set_unless[:rightscale][:process_list] = ""
set_unless[:rightscale][:process_match_list] = ""
set_unless[:rightscale][:private_ssh_key] = ""
set_unless[:rightscale][:collectd_share] = "/usr/share/collectd"

set_unless[:rightscale][:db_backup_file] = "/var/run/db-backup"

default[:rightscale][:plugin_list] = ""
default[:rightscale][:plugin_list_ary] = [
  "cpu",
  "df",
  "disk",
  "load",
  "memory",
  "processes",
  "swap",
  "users",
  "ping"
]

default[:rightscale][:process_list] = ""
default[:rightscale][:process_list_ary] = []

#
# Setup Distro dependent variables
#
case platform
when "redhat","centos","fedora","suse"
  rightscale[:logrotate_config] = "/etc/logrotate.d/syslog"
  rightscale[:collectd_config] = "/etc/collectd.conf"
  rightscale[:collectd_plugin_dir] = "/etc/collectd.d"
when "debian","ubuntu"
  rightscale[:logrotate_config] = "/etc/logrotate.d/syslog-ng"
  rightscale[:collectd_config] = "/etc/collectd/collectd.conf"
  rightscale[:collectd_plugin_dir] = "/etc/collectd/conf"
end

rightscale[:collectd_lib] = "/usr/lib64/collectd"

default[:rightscale][:short_hostname]        = nil
default[:rightscale][:domain_name]           = ""
default[:rightscale][:search_suffix]         = ""

#
# Cloud specific attributes
#
rightscale[:enable_remote_logging] = false
if cloud
  case cloud[:provider]
  when "ec2"
    rightscale[:enable_remote_logging] = true
  end
end