maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs/configures a MySQL database client and server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "12.1.0"

{'centos' => '>= 5.8', 'ubuntu' => '>= 10.04', 'redhat' => '>= 5.8'}.each_pair {|os, version| supports os , version}

depends "db"
depends "block_device"
depends "sys_dns"
depends "rightscale"

recipe  "db_mysql::default", "Set DB MySQL provider, set version and node variables specific to the chosen MySQL version"
recipe  "db_mysql::default_5_1", "Set DB MySQL provider, set version 5.1 and node variables specific to MySQL 5.1"
recipe  "db_mysql::default_5_5", "Set DB MySQL provider, set version 5.5 and node variables specific to MySQL 5.5"

attribute "db_mysql",
  :display_name => "General Database Options",
  :type => "hash"

# == Default attributes
#
attribute "db_mysql/version",
  :display_name => "MySQL Version",
  :description => "Specify the MySQL version that matches that of the Database Manager for MySQL ServerTemplate version in use. Note: MySQL 5.5 is not supported on Ubuntu 10.04. Example: 5.5",
  :recipes => ["db_mysql::default"],
  :choice => ['5.1', '5.5'],
  :required => 'required'

# == Default server attributes
#
attribute "db_mysql/server_usage",
  :display_name => "Server Usage",
  :description => "When set to 'dedicated' all server resources are allocated to MySQL.  When set to 'shared' less resources are allocated for MySQL so that it can be run concurrently with other apps like Apache and Rails for example.  Example: shared",
  :recipes => [
    "db_mysql::default_5_1",
    "db_mysql::default_5_5"
   ],
  :choice => ["shared", "dedicated"],
  :required => "optional",
  :default => "shared"

attribute "db_mysql/log_bin",
  :display_name => "MySQL Binlog Destination",
  :description => "Defines the filename and location of your MySQL stored binlog files.  This sets the log-bin variable in the MySQL config file. Example: /mnt/mysql-binlogs/mysql-bin",
  :recipes => [
    "db_mysql::default_5_1",
    "db_mysql::default_5_5"
   ],
  :required => "optional",
  :default => "/mnt/ephemeral/mysql-binlogs/mysql-bin"

attribute "db_mysql/tmpdir",
  :display_name => "MySQL Temp Directory Destination",
  :description => "Defines the location of your MySQL temp directory.  This sets the tmpdir variable in the MySQL config file. Example: /tmp",
  :recipes => [
    "db_mysql::default_5_1",
    "db_mysql::default_5_5"
   ],
  :required => "optional",
  :default => "/mnt/ephemeral/mysqltmp"

