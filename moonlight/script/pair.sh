export moonlightdir=/mnt/SDCARD/App/moonlight
export sysdir=/mnt/SDCARD/.tmp_update
export LD_LIBRARY_PATH=../lib:/lib:/config/lib:/mnt/SDCARD/miyoo/lib:/mnt/SDCARD/.tmp_update/lib:/mnt/SDCARD/.tmp_update/lib/parasyte:/sbin:/usr/sbin:/bin:/usr/bin
cd $moonlightdir/bin
export PATH=$PATH:$PWD
export HOME=$(dirname "$PWD")

. $moonlightdir/script/util.sh

restore_fb_properties

welcome_message() {
    echo -e "\033[94m"
    echo -e "                                     .          \033[0m*\033[94m  "
    echo -e "                                      *.           "
    echo -e "                            \033[0m*\033[94m          **.         "
    echo -e "              *                        .**.        "
    echo -e "                                       .-*.        "
    echo -e "                                *      .--.*       "
    echo -e "                                       :..* |       "
    echo -e "      \033[0mWelcome to Moonlight, the Miyoo edition!\033[94m"
    echo -e "                                      .**...|       "
    echo -e "      \033[0mMake sure Sunshine is running on the host!\033[94m"
    echo -e "                     \033[0m*\033[94m               .::.**.;       "
    echo -e "                                    .:..**..        "
    echo -e "                                  -..::-.*.       "
    echo -e "        \033[0m*\033[94m                         .:.**.**          "
    echo -e "                                ::.::.**           "
    echo -e "         *                   ::**.*.*.            "
    echo -e "                           .---.****       \033[0m*\033[94m        "
    echo -e "                      ...******.                  "
    echo -e "\033[0m"
}

read_ip_address() {
    echo -n -e "      "
    read -p "Enter host IP Address: " IPADDR
    clear
}

on_success() {
    clear
    echo -e "\n\n\n\n\n       \033[32mPairing successful!\033[0m"
    sleep 1
    echo -e "\n       \033[32mModifying the config file...\033[0m"
    echo -e "\n       \033[32mWriting IP Address...\033[0m"

    sed -i '/^address =/d' "$moonlightdir/config/moonlight.conf"
    sed -i "1i address = $IPADDR" "$moonlightdir/config/moonlight.conf"

    echo -e "\n       \033[32mComplete! Starting moonlight!\033[0m"

    touch "$moonlightdir/config/pairdone"
    sleep 2
    exit
}


## Start

main() {
    clear
    unset pair_check
    is_process_running "rapid-splash" && killall -9 "rapid-splash" 2> /dev/null
    is_process_running "moonlight" && killall -9 "moonlight" 2> /dev/null
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
      } | $sysdir/script/shellect.sh -t "Was pairing successful?"
    )

    if [ "$pair_check" = "Yes" ]; then
        on_success
    elif [ "$pair_check" = "No, retry" ]; then
        main
    elif [ "$pair_check" = "No, exit" ]; then
        is_file_exist "$moonlightdir/config/pairdone" && rm "$moonlightdir/config/pairdone"
        is_file_exist "$moonlightdir/.cache" && rm -rf "$moonlightdir/.cache"  # Corrected this line
        is_file_exist "/tmp/launch" && rm "/tmp/launch"
        exit
    fi
}

main