#!/bin/bash

echo "BadGuy Mining Script!"
echo "By: https://github.com/BadGuy552"
if [ ! "$1" ]
then
read -p "Your Wallet: " wallet
else
wallet=$1
fi

echo "Installing dependences.."
sudo apt-get install screen build-essential automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ -y 1>/dev/null 2>/dev/null
export MINERPATH=$HOME/miner
mkdir $MINERPATH 1>/dev/null 2>/dev/null
# CPUMINER: https://github.com/tpruvot/cpuminer-multi
echo "Downloading Miner... (tpruvot CPUMINER)"
git clone https://github.com/tpruvot/cpuminer-multi.git $MINERPATH > /dev/null

echo "Compiling Miner.... (maybe this take a long time)"

cd $MINERPATH && ./autogen.sh
cd $MINERPATH && ./configure --with-crypto --with-curl CFLAGS="-march=native"
cd $MINERPATH && make

clear
echo "Please Donate to: 19bQQhcv4qsGmnd7VVCXLe9rhGY6g45eH"
echo "[01] YESCRYPT (ZPOOL)"
echo "[02] NEOSCRYPT (ZPOOL)"
echo "[03] X11 (ZPOOL)"
echo "[04] SCRYPT (ZPOOL)"
echo "[05] Custom Pool"
read -p "Select your option: " op


if [ "$op" = 01 ]
then
echo "Initializing Mining in screen session... (YESCRYPT)"
sleep 10
cd $MINERPATH && screen ./cpuminer -a yescrypt -o stratum+tcp://yesscript.mine.zpool.ca:6233 -u $wallet
fi


if [ "$op" = 02 ]
then
echo "Initializing Mining in screen session... (NEOSCRYPT)"
sleep 10
cd $MINERPATH && screen ./cpuminer -a neoscrypt -o stratum+tcp://yesscript.mine.zpool.ca:4233 -u $wallet
fi


if [ "$op" = 03 ]
then
echo "Initializing Mining in screen session... (X11)"
sleep 10
cd $MINERPATH && screen ./cpuminer -a x11 -o stratum+tcp://yesscript.mine.zpool.ca:3533 -u $wallet
fi


if [ "$op" = 04 ]
then
echo "Initializing Mining in screen session... (SCRYPT)"
sleep 10
cd $MINERPATH && screen ./cpuminer -a scrypt -o stratum+tcp://script.mine.zpool.ca:3433 -u $wallet
fi

if [ "$op" = 05 ]
then
read -p "cd $MINERPATH && screen ./cpuminer " pool
cd $MINERPATH && screen ./cpuminer $pool
fi
