#!/bin/sh
export moonlightdir=/mnt/SDCARD/App/moonlight
export moonlightconf=$moonlightdir/config/moonlight.conf
export sysdir=/mnt/SDCARD/.tmp_update
export miyoodir=/mnt/SDCARD/miyoo
cd $moonlightdir
export PATH=$PATH:$PWD/bin
export HOME=$moonlightdir
rm -rf /tmp/st_exit

start_moonlight() {
    export LD_LIBRARY_PATH=../lib:/lib:/config/lib:/mnt/SDCARD/miyoo/lib:/mnt/SDCARD/.tmp_update/lib:/mnt/SDCARD/.tmp_update/lib/parasyte:/sbin:/usr/sbin:/bin:/usr/bin
    (rapid-splash $moonlightdir/splash 0 0 0 50 & sleep 10; killall -9 rapid-splash) &
    export SDL_VIDEODRIVER=mmiyoo
    export SDL_AUDIODRIVER=mmiyoo
    export EGL_VIDEODRIVER=mmiyoo
    
    kill_audio_servers
      
    monitor_output &
    set_snd_level "${curvol}" &
    script -c "LD_PRELOAD=$moonlightdir/lib/libuuid.so moonlight -config ./config/moonlight.conf stream" /tmp/output
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
