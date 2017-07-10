include esprestontp

package {'screen':
	ensure => present,
}

package {'git':
	ensure => present,
}

package {'curl':
	ensure => present,
}


class { 'nrpe':
    allowed_hosts => ['192.168.145.129', 'puppetmaster']
}

nrpe::command {
    'check_users':
      ensure  => present,
      command => 'check_users -w 5 -c 10';
}

nrpe::command {
    'check_load':
      ensure  => present,
      command => 'check_load -w 15,10,5 -c 30,25,20';
}

nrpe::command {
    'check_disk':
      ensure  => present,
      command => 'check_disk -w 20% -c 10% -p /dev/sda1';
}


nrpe::command {
    'check_apt':
      ensure  => present,
      command => 'check_apt';
}

nrpe::command {
    'check_mem':
      ensure  => present,
      command => 'check_mem  -w 80 -c 90';
}

