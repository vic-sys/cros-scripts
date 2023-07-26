#!BASH
echo -e "ELAO 7486脚本\n"

sudo -i <<!


while  ! ls /dev/ttyUSB1 > /dev/null 2>&1
do
	echo -e "ccd线未插上或接口/方向不对\n "
    sleep 2
done

echo -e "正在打开ccd......\n"
sleep 5

echo "ccd open" > /dev/ttyUSB0
echo "ccd reset factory" > /dev/ttyUSB0

while ls /dev/ttyUSB1 > /dev/null 2>&1
do
	
	echo -e "拔掉ccd线 \n"
    sleep 2
done  

echo -e "重新插上ccd线\n"

sleep 1

while  ! ls /dev/ttyUSB1 > /dev/null 2>&1
do
	echo -e "ccd线未插上或接口/方向不对\n"
    sleep 2
done


cd /tmp

echo -e "正在下载所需文件"

curl -L -O https://github.com/vic-sys/Gboard-wubi/releases/download/ftp/taeko4es.rom

flashrom -p raiden_debug_spi:target=AP -w taeko4es.rom


exit
<<EOF
EOF 
!
