#
# Cookbook Name:: zip_hdfs
# Recipe:: namenode_init
#
# Copyright (C) 2016 Justin Alan Ryan (ZipRealty / Realogy)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'zip_hdfs::default'
include_recipe 'hadoop::hadoop_hdfs_namenode'

# cargo cult from https://github.com/caskdata/hadoop_wrapper_cookbook/blob/master/recipes/hadoop_hdfs_namenode_init.rb

### TODO: due to a bug in the underlying hadoop cookbook where hadoop.tmp.dir can contain '${user}', for now
###         we handle the idempotency check in the ruby block itself
marker_file = "#{Chef::Config[:file_cache_path]}/hadoop_wrapper.nnformatted"
ruby_block 'initaction-format-namenode' do
  block do
    resources(:execute => 'hdfs-namenode-format').run_action(:run)
    File.open(marker_file, 'w') {}
  end
  not_if { File.exist? marker_file }
  ### TODO: this should check all dfs name dirs, not just the first
  # only_if { (Dir.entries("#{node['hadoop']['hdfs_site']['dfs.name.dir'].split(',').first}") - %w{ . .. }).empty? }
end

directory node['hdfs_site']['dfs.datanode.data.dir'] do
  action :create
  recursive :true
end
