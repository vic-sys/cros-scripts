#!BASH
echo -e "ELAO CCD解锁写入保护脚本\n"

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

echo -e "正在关闭写入保护"
sleep 2
echo "wp false" > /dev/ttyUSB0
echo "wp false atboot" > /dev/ttyUSB0

while ls /dev/ttyUSB1 > /dev/null 2>&1
do
	
	echo -e "拔掉ccd线 \n"
    sleep 2
done  





exit
<<EOF
EOF 
!
