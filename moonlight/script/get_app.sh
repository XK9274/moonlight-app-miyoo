export moonlightdir=/mnt/SDCARD/App/moonlight
export sysdir=/mnt/SDCARD/.tmp_update
export LD_LIBRARY_PATH=../lib:/lib:/config/lib:/mnt/SDCARD/miyoo/lib:/mnt/SDCARD/.tmp_update/lib:/mnt/SDCARD/.tmp_update/lib/parasyte:/sbin:/usr/sbin:/bin:/usr/bin
cd $moonlightdir
export PATH=$PATH:$PWD/bin
export HOME=$moonlightdir

. $moonlightdir/script/util.sh

restore_fb_properties
get_ip_address

write_app_to_launch() {
  if grep -q '^app =' "$moonlightconf"; then
    sed -i "s/^app = .*/app = $clean_app_to_launch/" "$moonlightconf"
  else
    echo "app = $clean_app_to_launch" >> "$moonlightconf"
  fi
}

app_to_launch=$(
  {
    LD_PRELOAD=$moonlightdir/lib/libuuid.so moonlight list $IPADDR
    echo "Unpair existing connection"
    echo "Exit"
  } | $sysdir/script/shellect.sh -t "Select the application to launch" -b "X : Keyboard    Menu : Exit    A : Select"
)

main() {

    echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n                Waiting for app list\n"
    echo -e "                Press menu to quit\n"
        
    if [ "$app_to_launch" = "Unpair existing connection" ]; then
        is_file_exist "$moonlightdir/config/pairdone" && rm "$moonlightdir/config/pairdone"
        is_dir_exist "$moonlightdir/.cache" && rm -rf "$moonlightdir/.cache"
        is_file_exist "/tmp/launch" && rm "/tmp/launch"
        sync
        exit
    elif [ "$app_to_launch" = "Exit" ]; then
        clear
        is_process_running "pressMenu2Term" && killall -15 "pressMenu2Term"
        exit
    else
        if [ ! -z "$app_to_launch" ] || [ ! -z "$clean_app_to_launch" ]; then
            clean_app_to_launch=$(echo "$app_to_launch" | sed 's/^[0-9]*\. //')
            write_app_to_launch
            touch /tmp/launch
            sync
            touch /tmp/st_exit
        fi
    fi

}

main



