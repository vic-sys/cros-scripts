#!/bin/bash
#menu text output
NORMAL=$(echo "\033[m")
MENU=$(echo "\033[36m") #Blue
NUMBER=$(echo "\033[33m") #yellow
FGRED=$(echo "\033[41m")
RED_TEXT=$(echo "\033[31m")
GRAY_TEXT=$(echo "\033[1;30m")
GREEN_TEXT=$(echo "\033[1;32m")
ENTER_LINE=$(echo "\033[33m")

function echo_red()
{
echo -e "\E[0;31m$1"
echo -e '\e[0m'
}

function echo_green()
{
echo -e "\E[0;32m$1"
echo -e '\e[0m'
}

function echo_yellow()
{
echo -e "\E[1;33m$1"
echo -e '\e[0m'
}

function exit_red()
{
    echo_red "$@"
    read -ep "Press [Enter] to return to the main menu."
}


_hwid="$(crossystem hwid)" >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo_yellow "欢迎使用HWID设置脚本"
    echo_yellow "当前HWID为 $_hwid"
fi
read -ep "输入新的HWID (全大写锁定): " hwid
echo -e ""
read -ep "确定将HWID设置为 $hwid [y/N] " confirm
if [[ "$confirm" = "Y" || "$confirm" = "y" ]]; then
    echo_yellow "\n正在设置HWID..."
    #disable software write-protect
    flashrom --wp-disable > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        exit_red "解除软件写入保护失败; 无法设置HWID."; return 1
    fi
    flashrom -r -i GBB:/tmp/gbb.temp > /dev/null 2>&1
    [[ $? -ne 0 ]] && { exit_red "\n读取HWID失败; 无法设置 HWID."; return 1; }
    gbb_utility --set --hwid="${hwid}" /tmp/gbb.temp > /dev/null

    [[ $? -ne 0 ]] && { exit_red "\n设置HWID出错."; return 1; }
    gbb_utility --set --flags=0x00010 /tmp/gbb.temp > /dev/null
    [[ $? -ne 0 ]] && { exit_red "\n设置工厂默认出错."; return 1; }
    flashrom -w -i GBB:/tmp/gbb.temp > /dev/null 2>&1
    [[ $? -ne 0 ]] && { exit_red "\n 设置HWID失败."; return 1; }
    echo_green "HWID设置成功."
fi