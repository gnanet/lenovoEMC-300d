usb=/media/B966-AAE2
ifw=px4px6-4.1.114.33421.tgz

if [ ! -f ${ifw} ]; then echo "We need px4px6-4.1.114.33421.tgz to start with"; exit 1; fi
if [ "`mount -t vfat | grep ${usb} > /dev/null`" == "" ]; then echo "USB Flash drive ${usb} needs to be mounted"; exit 1; fi

workdir=`dirname $(readlink -f ${ifw})`

ofw=${ifw%.tgz}-decrypted.tar.gz
ix2=${ifw%.tgz}-files



mkdir -p $ix2/images
mkdir -p $ix2/update
mkdir -p $ix2/apps

openssl enc -d -aes-128-cbc -in $ifw -k "EMCNTGSOHO" -out $ofw
tar xzvf $ofw -C $ix2/update/

imgs=$(find $ix2/update/)
for img in ${imgs} ; do
  if [ -f $img.md5 ] ; then
    mv $img $ix2/images/
    mv $img.md5 $ix2/images/
  fi
done

mount -o loop,ro $ix2/images/apps $ix2/apps
cp -p $ix2/apps/usr/local/cfg/config.gz $ix2/images/
umount $ix2/apps
gunzip $ix2/images/config.gz

img=$ix2/images/config
md5=$(md5sum $img)
md5=${md5% *}
md5=${md5% }
echo "$md5" > $img.md5

cd $ix2/images/
tar czvf $ix2/px4px6boot.tgz ./*

mkdir -p $usb/emctools/px4px6_images/
cp $ix2/px4px6boot.tgz $usb/emctools/px4px6_images/
