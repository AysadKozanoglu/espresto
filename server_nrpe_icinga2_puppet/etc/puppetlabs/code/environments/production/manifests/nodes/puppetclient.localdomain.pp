node 'puppetclient.localdomain' {
	package {'iftop':
		ensure => present,
	}
}
