apt-get -y install gcc build-essential

ln -s /usr/src/linux-headers-$(uname -r)/include/generated/uapi/linux/version.h /usr/src/linux-headers-$(uname -r)/include/linux/version.h
apt-get install -y unzip

mkdir -p /var/tmp/vmware-tools
cd /var/tmp/vmware-tools

wget http://softwareupdate.vmware.com/cds/vmw-desktop/fusion/5.0.3/1040386/packages/com.vmware.fusion.tools.linux.zip.tar
tar xf com.vmware.fusion.tools.linux.zip.tar
unzip com.vmware.fusion.tools.linux.zip
mount payload/linux.iso /mnt
cp /mnt/VMwareTools-*.tar.gz .
umount /mnt
uname -a
df -h
ls -al /proc/sys/fs

tar zxf VMwareTools-*.tar.gz
cd vmware-tools-distrib

# patch to vmhgfs
cd lib/modules/source
tar xf vmhgfs.tar
sed -i'' -e 's/result = compat_vmtruncate(inode, newSize)/result = 0/' vmhgfs-only/inode.c
tar cf vmhgfs.tar vmhgfs-only/
rm -rf vmhgfs-only

# patch to vmci.tar
tar xf vmci.tar
sed -i'' -e 's/.remove = __devexit_p(vmci_remove_device)/.remove = vmci_remove_device/' vmci-only/linux/driver.c
sed -i'' -e 's/__devinit//' vmci-only/linux/driver.c
sed -i'' -e 's/__devexit//' vmci-only/linux/driver.c
tar cf vmci.tar vmci-only
rm -rf vmci-only/

cd ../../..
./vmware-install.pl --default
/etc/vmware-tools/services.sh stop
/etc/vmware-tools/services.sh start
