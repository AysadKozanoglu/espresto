 Install Mailman in Debian

<pre>
apt-get install mailman
</pre>
This will install the latest version of mailman and apache

active cgi module for apache 
<pre>
a2enmod cgi
systemctl restart apache.service
</pre>

Now if you want to install postfix in debian follow this link http://www.debianhelp.co.uk/postfix.htm
<pre>
apt-get install postfix  
</pre>
internet site

after installation of postfix you need to do the following things

Edit /etc/postfix/main.cf

Ensure that the following line exist: owner_request_special = no

Ensure that in virtual_maps there's this entry: hash:/var/lib/mailman/data/virtual-mailman

Ensure that in alias_maps there's this entry: hash:/var/lib/mailman/data/aliases

Save & quit this file

<b>important:</b> 
if you change <b>/etc/aliases </b> than call command <i>newaliases</i> on CLI
and check if the alias_map is corretly setted by postfix by <i>postconf alias_maps</i>

Now you need to edit Mailman's config file

Edit /etc/mailman/mm_cfg.py

Ensure that the following line exist: MTA = "Postfix"

Ensure that the following line exist

POSTFIX_STYLE_VIRTUAL_DOMAINS = ['my.domain1.com', 'my.domain2.com', 'my.domain3.com']

Save & quit

If you want to add new list to mailman

Type newlist <list_name>@<my.domain1.com>, and answer the questions.

Type /usr/lib/mailman/bin/genaliases, which will update /var/lib/mailman/data/aliases and var/lib/mailman/data/virtual-mailman accordingly

Now restart mailman to take our new settings
<pre>
/etc/init.d/mailman force-reload
</pre>
Mailman will integrate itself into your webserver if you're running Apache or Apache2

otherwise copy /etc/mailman/apache.conf to /etc/apache2/sites-enabled/

If you want install apache2 in debian follow this link http://www.debianhelp.co.uk/apache2.htm

For example you can view the mailing list page that describes your new sheep list by visiting the following URL:

http://my.domain1.com/cgi-bin/mailman/listinfo/debianhelp

The archives will not be setup properly yet, to do that you should add the following two lines to the bottom of your apache configuration file:

Alias /pipermail/ /var/lib/mailman/archives/public/

Alias /images/mailman/ /usr/share/images/mailman/

## for postfix multiple domains

<b>Define the domain list(multiple domains acceptions) as hash file or as list in the config file. </b>
<pre>
vim /etc/postfix/main.cf
virtual_alias_domains = hash:/etc/postfix/virtual_domains

vim /etc/postfix/virtual_domains
example.net   #domain
example.com   #domain
example.at    #domain

postmap /etc/postfix/virtual_domains
/etc/init.d/postfix reload
</pre>

after modify main.cf parameter mydestinations
example from prod:
<pre>
mydestination = example.net, mailman.example.com, localhost
</pre>

<b> define aliases  (also for multiple domains valid) </b>
in /etc/aliases  contain some defaults. this can modified and added from you. at last you can redirect all above to one account like this:
exmaple from prod:
<pre>
webmaster: root
www: root
ftp: root
security: root
root: your@emailadress.com
</pre>
check with <pre>postconf alias_maps</pre>  if postfix map the correct hash file
on the command generate the aliases immidietly
<pre> newaliases && systemctl reload postfix.service</pre>

### [Aysad Kozanoglu | Espresto AG] ###
