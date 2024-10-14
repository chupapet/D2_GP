#!/bin/sh
mount -o remount,rw /
mkdir /temp
wget http://github.com/chupapet/D2_GP/raw/refs/heads/main/gpd2_pkg.tgz -O /temp/gpd2_pkg.tar.gz > /dev/null 2>&1
echo "Checking hash!"
hash=$(md5sum /temp/gpd2_pkg.tar.gz | awk '{print $1}')
echo "$hash = f91b40ed69c97b6cf26141b0bfff8e37"
if [ $hash == 'f91b40ed69c97b6cf26141b0bfff8e37' ]
then
echo "Same!"
rm -rf /opt/web/static/css/*
rm -rf /opt/web/static/font/*
rm -rf /opt/web/static/img/*
rm -rf /opt/web/static/js/*
tar -zxvf /temp/gpd2_pkg.tar.gz -C /  > /dev/null 2>&1
echo -e "AT*PROD=2\r\n" | microcom /dev/ttyUSB2 -d 0 -t 500 > /dev/null 2>&1
echo -e "AT*MRD_MEP=D\r\n" | microcom /dev/ttyUSB2 -d 0 -t 500 > /dev/null 2>&1
echo -e "AT*PROD=0\r\n" | microcom /dev/ttyUSB2 -d 0 -t 500 > /dev/null 2>&1
/bin/factoryConf set fotaFtpUrl ftp://127.0.0.1
/bin/factoryConf set fotaFtpUser null
/bin/factoryConf set fotaFtpPasswd null
rm -rf /temp
reboot
else
echo "Not same!"
fi