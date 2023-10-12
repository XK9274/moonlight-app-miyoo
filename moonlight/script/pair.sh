export moonlightdir=/mnt/SDCARD/App/moonlight
export sysdir=/mnt/SDCARD/.tmp_update
export LD_LIBRARY_PATH=../lib:/lib:/config/lib:/mnt/SDCARD/miyoo/lib:/mnt/SDCARD/.tmp_update/lib:/mnt/SDCARD/.tmp_update/lib/parasyte:/sbin:/usr/sbin:/bin:/usr/bin
cd $moonlightdir/bin
export PATH=$PATH:$PWD
export HOME=$(dirname "$PWD")

. $moonlightdir/script/util.sh

restore_fb_properties

welcome_message() {
    display_message "" "\033[0m" "Welcome to Moonlight, the Miyoo edition!" "Make sure Sunshine is running on the host!"
}

read_ip_address() {
    echo -n -e "      "
    read -p "Enter host IP Address: " IPADDR
    clear
}

on_success() {
    clear
    sed -i '/^address =/d' "$moonlightdir/config/moonlight.conf"
    if [ $? -ne 0 ]; then
        display_message "                      Failed" "\033[31m" "Pairing failed!" "Exiting, sorry!"
        sleep 1
        touch /tmp/st_exit
    fi

    sed -i "1i address = $IPADDR" "$moonlightdir/config/moonlight.conf"
    if [ $? -ne 0 ]; then
        display_message "                      Failed" "\033[31m" "Pairing failed!" "Exiting, sorry!"
        sleep 1
        touch /tmp/st_exit
    fi

    display_message "                      Success" "\033[32m" "           Pairing successful!" "           Starting Moonlight"
    touch "$moonlightdir/config/pairdone"
    sleep 20
    exit
}

## Start

main() {
    clear
    unset pair_check
    is_process_running "rapid-splash" && killall -9 "rapid-splash" 2> /dev/null
    is_process_running "moonlight" && killall -15 "moonlight" 2> /dev/null
    welcome_message
    read_ip_address
    rm -rf $moonlightdir/.cache
    LD_PRELOAD=$moonlightdir/lib/libuuid.so moonlight unpair "$IPADDR"
    LD_PRELOAD=$moonlightdir/lib/libuuid.so moonlight pair "$IPADDR"

    pair_check=$(
      {
        echo "Yes"
        echo "No, retry"
        echo "No, exit"
      } | $sysdir/script/shellect.sh -t "Was pairing successful?" -b "X : Keyboard    Menu : Exit    A : Select"
    )

    if [ "$pair_check" = "Yes" ]; then
        on_success
    elif [ "$pair_check" = "No, retry" ]; then
        main
    elif [ "$pair_check" = "No, exit" ]; then
        clear
        is_process_running "pressMenu2Term" && killall -15 "pressMenu2Term"
        is_file_exist "$moonlightdir/config/pairdone" && rm "$moonlightdir/config/pairdone"
        is_file_exist "$moonlightdir/.cache" && rm -rf "$moonlightdir/.cache"  # Corrected this line
        is_file_exist "/tmp/launch" && rm "/tmp/launch"
        exit
    fi
}

main