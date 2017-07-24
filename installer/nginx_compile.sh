#!/bin/bash
#   Company: Espresto AG
#     coder: Aysad Kozanoglu
#         Stand: 24.07.17
#
#	Beschreibung:
#        installiert nötige Pakete über apt-get
#        kompilieren von nginx
#

nginx_package="https://github.com/AysadKozanoglu/espresto/blob/master/packages/nginx-1.10.2.tar.gz"
openssl_package="https://github.com/AysadKozanoglu/espresto/raw/master/packages/openssl-0.9.8zf.tar.gz"
d_path="/source"

if [ "$(id -u)" != "0" ]; then
   echo -e "\e[31m du musst root rechte besitzen. führe sudo su - aus\e[0m" 1>&2
   exit 1
fi

echo "Pfad aufräumen.."
if [ -d "$d_path" ]; then
  rm -R $d_path
fi

echo "Pfad erstellen"
mkdir $d_path

echo "Pakete für nginx Kompilierung wird intalliert.. "
# einige pakete die nginx benötigt beim kompilieren
apt-get -qq -y install build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev

# ins d_path navigieren und kompilierung starten
#clear 
echo "========================"
echo "Beginne mit Kompilierung in 3sek."
echo "========================"
sleep 3

wget  -q $d_path/nginx.tar.gz "$nginx_package" && wget  "$openssl_package" && tar zxvf nginx.tar.gz && tar zxvf openssl.tar.gz && cd nginx-1.12.1 && ./configure --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt=-Wl,-z,relro --sbin-path=/usr/local/sbin --with-http_stub_status_module --with-http_ssl_module --user=www-data --group=www-data --with-openssl=/source/openssl-0.9.8zf/ && make && make install

if [ "$?" == 0 ]
  then
	echo -e "\n\n"
	echo "####################"
	echo "Nignx Config "
	echo ""
	echo "/usr/local/nginx"
	echo "/usr/local/nginx/conf"
	echo "/usr/local/nginx/html"
	echo "/usr/local/nginx/logs"
	echo "nginx user: www-data"
	echo ""
	echo '#####################'
fi
