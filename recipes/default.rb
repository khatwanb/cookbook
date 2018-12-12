#
# Cookbook:: application
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


package 'apache2' do 
	action :install
#	version '2.2'
end


 template '/etc/apache2/ports.conf' do 
#	path '/etc/apache2/ports.conf'
	source 'ports.conf.erb'
	cookbook 'application'
 end
	
service 'apache2' do
	action [:enable, :restart]
end

include_recipe 'tomcat::default'

tomcat_install 'tomcat1' do
  version '7.0.92'
end

tomcat_install 'tomcat2' do
  version '7.0.92'
end

tomcat_service 'tomcat1' do
  action [:enable,:start]
end

tomcat_service 'tomcat2' do
  action [:enable,:start]
end

include_recipe mysql::default'

mysql_service 'mysql' do
  version '5.6'
  initial_root_password 'mysqlpaswd'
  action [:create, :start]
end