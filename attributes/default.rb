default['java']['jdk_version'] = 8
default['hadoop']['core_site']['fs.defaultFS'] = 'hdfs://zk01.aur.test.ziprealty.com'
default['hdfs_site']['dfs.datanode.data.dir'] = '/srv/hadoop/data'
default['hdfs_site']['dfs.namenode.data.dir'] = '/srv/hadoop/data'
default['hdfs_site']['dfs.replication'] = '3'
default['hadoop']['yarn_site']['yarn.resourcemanager.hostname'] = 'zk02.aur.test.ziprealty.com'
force_default['hadoop']['distribution'] = 'cdh'
force_default['hadoop']['distribution_version'] = '5.5.1'
