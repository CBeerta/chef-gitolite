#
# Cookbook Name:: gitolite
# Recipe:: default
#
# Copyright 2013, Claus Beerta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# 
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe "git"

node.set_unless['gitolite']['password'] = secure_password

user "git" do
  comment "Gitolite User"
  shell "/bin/bash"
  home node[:gitolite][:home_dir]
  password node[:gitolite][:password]
end

directory node[:gitolite][:home_dir] do
  owner "git"
  group "git"
  mode 00755
end

git "#{node[:gitolite][:home_dir]}/gitolite" do
  repository node[:gitolite][:repository_url]
  reference "master"
  action :sync
  user "git"
end

#
# Load Pub file from node environment
#
file "#{node[:gitolite][:home_dir]}/#{node[:gitolite][:ssh_admin_name]}.pub" do
  content node[:gitolite][:ssh_admin_pubkey]
  owner "git"
  group "git"
  only_if { not node[:gitolite][:ssh_admin_pubkey].nil? }
end

#
# Otherwise Create a new admin KeyPair
#
execute "ssh-keygen -q -t dsa -f #{node[:gitolite][:home_dir]}/#{node[:gitolite][:ssh_admin_name]} -N \"\" " do
  user "git"
  action :run
  not_if { File.exist? "#{node[:gitolite][:home_dir]}/#{node[:gitolite][:ssh_admin_name]}.pub" }
  only_if { node[:gitolite][:ssh_admin_pubkey].nil? }
end

directory "#{node[:gitolite][:home_dir]}/bin" do
  owner "git"
  group "git"
  mode 00755
  action :create
end

execute "gitolite-install" do
  command "gitolite/install -to #{node[:gitolite][:home_dir]}/bin"
  user "git"
  group "git"
  environment ({'HOME' => node[:gitolite][:home_dir]})
  cwd node[:gitolite][:home_dir]
  not_if {File.exists?("#{node[:gitolite][:home_dir]}/repositories") }
  notifies :run, "execute[gitolite-setup-admin]"
end

execute "gitolite-setup-admin" do
  command "bin/gitolite setup -pk #{node[:gitolite][:ssh_admin_name]}.pub"
  user "git"
  group "git"
  environment ({'HOME' => node[:gitolite][:home_dir]})
  cwd node[:gitolite][:home_dir]
  action :nothing
end
