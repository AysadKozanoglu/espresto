 Install Mailman in Debian


#apt-get install mailman

This will install the latest version of mailman and apache

active cgi module for apache 
a2enmod cgi
systemctl restart apache.service

Now if you want to install postfix in debian follow this link http://www.debianhelp.co.uk/postfix.htm
apt-get install postfix  

# internet site


after installation of postfix you need to do the following things

Edit /etc/postfix/main.cf

Ensure that the following line exist: owner_request_special = no

Ensure that in virtual_maps there's this entry: hash:/var/lib/mailman/data/virtual-mailman

Ensure that in alias_maps there's this entry: hash:/var/lib/mailman/data/aliases

Save & quit this file

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

#/etc/init.d/mailman force-reload

Mailman will integrate itself into your webserver if you're running Apache or Apache2

otherwise copy /etc/mailman/apache.conf to /etc/apache2/sites-enabled/



If you want install apache2 in debian follow this link http://www.debianhelp.co.uk/apache2.htm

For example you can view the mailing list page that describes your new sheep list by visiting the following URL:

http://my.domain1.com/cgi-bin/mailman/listinfo/debianhelp

The archives will not be setup properly yet, to do that you should add the following two lines to the bottom of your apache configuration file:

Alias /pipermail/ /var/lib/mailman/archives/public/

Alias /images/mailman/ /usr/share/images/mailman/



[Aysad Kozanoglu | Espresto AG]
