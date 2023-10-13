display_message() {
    local status="$1"
    local message_color="$2"
    local moon_color="\033[94m"
    local white_color="\033[0m"
    local message1="$3"
    local message2="$4"

    if [ -n "$status" ]; then
        echo -e "${message_color}${status}\033[0m"
    fi
    
    echo -e "${moon_color}"
    echo -e "                                     .          ${white_color}*${moon_color}  "
    echo -e "                                      *.           "
    echo -e "                            ${white_color}*${moon_color}          **.         "
    echo -e "              *                        .**.        "
    echo -e "                                       .-*.        "
    echo -e "                                *      .--.*       "
    echo -e "                                       :..* |       "
    echo -e "      ${message_color}${message1}${moon_color}"
    echo -e "                                      .**...|       "
    echo -e "      ${message_color}${message2}${moon_color}"
    echo -e "                     ${white_color}*${moon_color}               .::.**.;       "
    echo -e "                                    .:..**..        "
    echo -e "                                  -..::-.*.       "
    echo -e "        ${white_color}*${moon_color}                         .:.**.**          "
    echo -e "                                ::.::.**           "
    echo -e "         *                   ::**.*.*.            "
    echo -e "                           .---.****       ${white_color}*${moon_color}        "
    echo -e "                      ...******.                  "
    echo -e "\033[0m"
}



restore_fb_properties() {
    if [ -f $moonlightdir/config/framebuffer_vinfo.bin  ]; then
        cp $moonlightdir/config/framebuffer_vinfo.bin /tmp/framebuffer_vinfo.bin 
        fbpurge restore
    fi
}

save_fb_properties() {
    fbpurge save
    cp /tmp/framebuffer_vinfo.bin $moonlightdir/config/framebuffer_vinfo.bin 
}

is_process_running() {
  process_name="$1"
  if [ -z "$(pgrep -f "$process_name")" ]; then
    return 1
  else
    return 0
  fi
}

is_file_exist() {
  file_path="$1"
  if [ -e "$file_path" ]; then
    return 0
  else
    return 1
  fi
}

is_dir_exist() {
  dir_path="$1"
  if [ -d "$dir_path" ]; then
    return 0
  else
    return 1
  fi
}

get_ip_address() {
  first_line=$(head -n 1 "$moonlightconf")
  IPADDR="${first_line#address = }"
}

get_user_app() {
    get_ip_address
    $moonlightdir/bin/pressMenu2Term neo-st &
    LD_PRELOAD="$miyoodir/lib/libpadsp.so" $moonlightdir/bin/neo-st -q -e $moonlightdir/script/get_app.sh
}

check_net_connectivity() {
    get_ip_address
    if ping -c 1 $IPADDR &> /dev/null; then
        return 0
    else
        return 1
    fi
}
