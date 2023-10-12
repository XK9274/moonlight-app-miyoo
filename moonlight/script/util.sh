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
    LD_PRELOAD="$miyoodir/lib/libpadsp.so" $sysdir/bin/st -q -e $moonlightdir/script/get_app.sh
}

