#!/bin/sh
#sudo apt-get install subversion
#sudo apt-get install qt4-dev-tools

WORKDIR = "$1"
mkdir $WORKDIR
echo "***** Start build Platform *****"
cd $WORKDIR
svn checkout http://v-dep48server:8081/svn/repo/Antares/platform/trunk --non-interactive --no-auth-cache --username balovas --password 2010 &&
cd trunk/framework/trunk &&
qmake-qt4 &&
make clean &&
make all &&

if [ ! -f lib.linux/libframework.a ]; then
    echo "ERROR: File not found lib.linux/libframework.a !"
    exit
fi

if [ ! -f lib.linux/libframework.a ]; then
    echo "ERROR: File not found lib.linux/libframeworkd.a !"
    exit
fi


cd $WORKDIR"/trunk/abstractprocess/trunk" &&
qmake-qt4 &&
make clean &&
make all &&

if [ ! -f bin/debug/abstractprocess ]; then
    echo "ERROR: File not found bin/debug/abstractprocess !"
    exit
fi

if [ ! -f bin/release/abstractprocess ]; then
    echo "ERROR: File not found bin/release/abstractprocess !"
    exit
fi

cd $WORKDIR"/trunk/coreprocess/trunk" &&
qmake-qt4 &&
make clean &&
make all 

if [ ! -f bin/release/coreprocess ]; then
    echo "ERROR: File not found bin/release/coreprocess !"
    exit
fi

echo "***** Start build Plugins *****"
cd $WORKDIR &&
svn checkout http://v-dep48server:8081/svn/repo/Antares/plugins --non-interactive --no-auth-cache --username balovas &&
cd plugins/udpport/trunk &&
qmake-qt4 &&
make clean &&
make all

if [ ! -f lib.linux/libudpport.so ]; then
    echo "ERROR: File not found lib.linux/libudpport.so !"
    exit
fi

cd $WORKDIR"/plugins/udptransport/trunk" &&
qmake-qt4 &&
make clean &&
make all

if [ ! -f lib.linux/libudptransport.so ]; then
    echo "ERROR: File not found lib.linux/libudptransport.so !"
    exit
fi

if [ ! -f lib.linux/libudptransportd.so ]; then
    echo "ERROR: File not found lib.linux/libudptransportd.so !"
    exit
fi

cd $WORKDIR"/plugins/channel/trunk"
qmake-qt4
make clean
make all

if [ ! -f lib.linux/libchannel.so ]; then
    echo "ERROR: File not found lib.linux/libchannel.so !"
    exit
fi

if [ ! -f lib.linux/libchanneld.so ]; then
    echo "ERROR: File not found lib.linux/libchanneld.so !"
    exit
fi

cd $WORKDIR"/plugins/rs232/trunk"
qmake-qt4
make clean
make all

if [ ! -f lib.linux/librs232port.so ]; then
    echo "ERROR: File not found lib.linux/librs232port.so !"
    exit
fi

cd $WORKDIR"/plugins/serialtransport/trunk"
qmake-qt4
make clean
make all

if [ ! -f lib.linux/libserialtransport.so ]; then
    echo "ERROR: File not found lib.linux/libserialtransport.so !"
    exit
fi

if [ ! -f lib.linux/libserialtransportd.so ]; then
    echo "ERROR: File not found lib.linux/libserialtransportd.so !"
    exit
fi

cd $WORKDIR"/plugins/store/trunk"
qmake-qt4
make clean
make all

if [ ! -f lib.linux/libstore.so ]; then
    echo "ERROR: File not found lib.linux/libstore.so !"
    exit
fi

echo "Start deb compilation"

mkdir $WORKDIR"/deb_platform/usr/include"
mkdir $WORKDIR"/deb_platform/usr/lib"
mkdir $WORKDIR"/deb_platform/usr/src"
cp ~/trunk/framework/trunc/*.h ~/deb_platform/usr/include
abstractprocess/trunk/bin/release ~/deb_platform/usr/bin

копируем abstractprocess
	coreprocess
	framework


mkdir ~/deb_platform/usr/lib
cp ~/trunk/framework/trunc/*.h ~/deb_platform/usr/lib	

#сгенерировать пакет
#контрольные суммы
#сгенерировать документацию
#
#SVN- Hooks
#----------------------------------------------------------------------------------
#post-commit
#___________
#
#!/bin/sh
#
#REPOS="$1"
#REV="$2"
#USER="$3"
#PROPNAME="$4"
#ACTION="$5"
#
#wget  --dns-timeout=3 --connect-timeout=3 -q "http://192.168.29.109:8080/SVN?repos=$REPOS&rev=$REV&user=$USER&propname=#$PROPNAME&action=$ACTION">/dev/null 2>&1 &
#
#exit 0
