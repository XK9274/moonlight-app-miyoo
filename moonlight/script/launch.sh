#!/bin/sh
export moonlightdir=/mnt/SDCARD/App/moonlight
export moonlightconf=$moonlightdir/config/moonlight.conf
export sysdir=/mnt/SDCARD/.tmp_update
export miyoodir=/mnt/SDCARD/miyoo
cd $moonlightdir/bin
export PATH=$PATH:$PWD
export HOME=$(dirname "$PWD")
rm -rf /tmp/st_exit

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

start_moonlight() {
    export LD_LIBRARY_PATH=../lib:/lib:/config/lib:/mnt/SDCARD/miyoo/lib:/mnt/SDCARD/.tmp_update/lib:/mnt/SDCARD/.tmp_update/lib/parasyte:/sbin:/usr/sbin:/bin:/usr/bin
    (rapid-splash $moonlightdir/splash 0 0 0 50 & sleep 10; killall -9 rapid-splash) &
    export SDL_VIDEODRIVER=mmiyoo
    export SDL_AUDIODRIVER=mmiyoo
    export EGL_VIDEODRIVER=mmiyoo
    
   
    kill_audio_servers
      
    cpuclock 1700
    monitor_output &
    set_snd_level "${curvol}" &
    script -c "LD_PRELOAD=$moonlightdir/lib/libuuid.so moonlight -config ../config/moonlight.conf stream" /tmp/output
}

main() {
    . $moonlightdir/script/util.sh    
    save_fb_properties # to restore framebuffer properties on the way out, stops black screens leaving back to mainui
    curvol=$(get_curvol) # grab current volume
    touch /tmp/output 

    if [ -f $moonlightdir/config/pairdone ]; then
        get_user_app
        if [ -f /tmp/launch ]; then
            start_moonlight
            do_cleanup
        else
            do_cleanup
        fi
    else
        $moonlightdir/bin/pressMenu2Term neo-st &
        $moonlightdir/bin/neo-st -e $moonlightdir/script/pair.sh
        if [ -d "$moonlightdir/.cache" ] && [ -f "$moonlightdir/config/pairdone" ]; then # second catch for this file
            get_user_app
            start_moonlight
            do_cleanup
        fi
    fi

    if pgrep "rapid-splash" > /dev/null; then
      sleep 5 && killall -9 rapid-splash
    else
      echo "rapid-splash is not running."
    fi
    do_cleanup
}

main