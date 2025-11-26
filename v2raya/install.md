## v2ray
unzip v2ray-linux-64.zip -d v2ray/

cp v2ray/v2ray /usr/bin/

mkdir -p /usr/share/v2ray/
cp -r v2ray/v2ray/* /usr/share/v2ray/

## v2raya
dpkg -i installer_debian_x64_2.2.7.4.deb

systemctl start v2raya.service

systemctl enable v2raya.service