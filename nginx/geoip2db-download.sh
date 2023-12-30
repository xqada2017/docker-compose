#!/bin/bash

set -eux
cd "$(dirname "$0")"

LICENSE_KEY="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"
CITY_DB_URL="https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=$LICENSE_KEY&suffix=tar.gz"
COUNTRY_DB_URL="https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=$LICENSE_KEY&suffix=tar.gz"

[ -d "geoip2db" ] || mkdir -p geoip2db
cd geoip2db

# 下载并解压 city 数据库
curl -SfL -o "GeoLite2-City.tar.gz" "$CITY_DB_URL"
tar -xvf GeoLite2-City.tar.gz
cp -a GeoLite2-City_*/GeoLite2-City.mmdb ./
rm -rf GeoLite2-City_*

# 下载并解压 country 数据库
curl -SfL -o "GeoLite2-Country.tar.gz" "$COUNTRY_DB_URL"
tar -xvf GeoLite2-Country.tar.gz
cp -a GeoLite2-Country_*/GeoLite2-Country.mmdb ./
rm -rf GeoLite2-Country_*

# 清理压缩包
rm -rf *.tar.gz

echo "Geoip2 databases download success"
