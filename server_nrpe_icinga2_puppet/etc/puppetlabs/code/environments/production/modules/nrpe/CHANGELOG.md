2016-06-09 Release 2.1.1

* Fix file perms

2016-06-07 Release 2.1.0

* Take the parameters given to the module into account, rather than the
* defaults from the params.pp when creating commands.
* Fix nrpe::include_dir bug 
* make management of nrpe package optional
* Use variable for title of service resource to be consistent
* Allow other users than root to be sudoed

2015-06-16 Release 2.0.0

* Add Gentoo support.
* Re-add inherit params.
* Allow hiera-based override of nrpe user/group/pid.
* Fix variable naming.
* 1ca413e Add all other NRPE config parameters: allow_bash_command_substitution, log_facility, server_port, command_prefix, debug, connection_timeout; also add dont_blame_nrpe to nrpe::params.
* Add support for SLES
* Added support to set file mode of plugin file
* Added support for the 'content' attribute for a plugin
* Added sudo support
* Add support for OpenBSD.
* Make command_timeout configurable.
* Allow to specify fully qualified commands.
* Specify server_address in nrpe class.
* change package name from nrpe2 to nrpe for freebsd
* add 32bit architecture for RedHat OS family
* removed dont_blame_nrpe from params
* Fixed typo, missing bracket after list in params.pp near line 78
* corrected syntax
* added dont_blame_nrpe
* corrected FreeBSD package names
* added SUSE default params
* cfg template w/ @libdir fact

## 2014-02-26 Release 1.0.0
### Summary:

This release adds FreeBSD osfamily support and support
for adding nrpe plugins.

### Features:

- Add FreeBSD support
- Add plugin command

### Bugfixes:

- OpenCSW changed the paths of configs files

## 2013-10-20 Release 0.0.4

### Summary:

This is a bug fix release

### Bug fixes:

  - Fix puppet 3.x bug with array namevars
  - Puppet lint fixes

## 2013/09/25 Release 0.0.3

- Add Rakefile, Gemfile and update .gitignore
- Merge pull request #1 from ripienaar/puppet_3_2_1_deprecations
- Puppet 3.2.1 has deprecated 'foo' as a means of accessing variables in templates instead now requiring '@foo' and will log warnings about this.

## 2013/02/02 Release 0.0.2

- Bump version to 0.0.2 for forge release
- Remove nrpe plugin.
- Fix spelling of the word command in README
- Ignore pkg directory
- Add ability to purge nrpe::commands
- Add smoke tests
- Add dependencies to the README
- Fix typo with nagios_plugin package for solaris
- Add nagios-plugin package param
- Add nrpe::command functionality
- Add redhat params to nrpe
- Change allowed_hosts from a string to an array
- Initial commit for nrpe module

