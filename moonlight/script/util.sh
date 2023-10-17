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

get_curvol() {
    awk '/LineOut/ {if (!printed) {gsub(",", "", $8); print $8; printed=1}}' /proc/mi_modules/mi_ao/mi_ao0
}

kill_audio_servers() {
    is_process_running "audioserver" && pkill -9 -f "audioserver"
    is_process_running "audioserver.mod" && killall -q "audioserver.mod"
}

set_snd_level() {
    local target_vol="$1"
    local current_vol
    local start_time
    local elapsed_time

    start_time=$(date +%s)
    while [ ! -e /proc/mi_modules/mi_ao/mi_ao0 ]; do
        sleep 0.2
        elapsed_time=$(( $(date +%s) - start_time ))
        if [ "$elapsed_time" -ge 30 ]; then
            echo "Timed out waiting for /proc/mi_modules/mi_ao/mi_ao0"
            return 1
        fi
    done

    start_time=$(date +%s)
    while true; do
        echo "set_ao_volume 0 ${target_vol}dB" > /proc/mi_modules/mi_ao/mi_ao0
        echo "set_ao_volume 1 ${target_vol}dB" > /proc/mi_modules/mi_ao/mi_ao0
        current_vol=$(get_curvol)

        if [ "$current_vol" = "$target_vol" ]; then
            echo "Volume set to ${current_vol}dB"
            return 0
        fi

        elapsed_time=$(( $(date +%s) - start_time ))
        if [ "$elapsed_time" -ge 30 ]; then
            echo "Timed out trying to set volume"
            return 1
        fi

        sleep 0.2
    done
}

do_cleanup() {
    is_process_running "rapid-splash" && killall -9 "rapid-splash"
    is_process_running "tail" && killall -9 "tail"
    is_process_running "neo-st" && touch /tmp/st_exit
    is_process_running "moonlight" && killall -15 "moonlight"
    is_process_running "pressMenu2Term" && killall -15 "pressMenu2Term"
    is_file_exist "/tmp/output" && rm -rf "/tmp/output"
    is_file_exist "/tmp/launch" && rm "/tmp/launch"
    is_file_exist "/tmp/framebuffer_vinfo.bin" && rm "/tmp/framebuffer_vinfo.bin"
    is_file_exist "$moonlightdir/config/framebuffer_vinfo.bin" && rm "$moonlightdir/config/framebuffer_vinfo.bin"
    cpuclock 1200
    sync
}

monitor_output() { # manages the splash screen based on the output of moonlight from sunshine
  tail -f /tmp/output | while read -r line; do
    
    if echo "$line" | grep -q -E "Starting RTSP handshake...Audio port: 48000|Starting video stream"; then
      echo "Matched Input stream"
      killall -9 rapid-splash
      echo "Killing splash"
      break
    fi
    
    if echo "$line" | grep -q -E "RTSP ANNOUNCE request failed: 503|Can't find app|Starting RTSP handshake...RTSP OPTIONS request failed: 552"; then
      echo "Failure detected. Closing everything."
      do_cleanup
      sleep 2
    fi

  done
}
