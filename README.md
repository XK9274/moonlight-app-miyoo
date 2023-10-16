# Moonlight Miyoo Edition

## Version
Moonlight for the Miyoo Mini Plus is currently at v1.2.

- [Download Latest Version](https://github.com/XK9274/moonlight-app-miyoo/releases)
- [Changelog](https://github.com/XK9274/moonlight-app-miyoo/blob/main/README.md#changelog)
- [FAQ](https://github.com/XK9274/moonlight-app-miyoo/tree/main#frequently-asked-questions-faq)
- [Custom Settings/Keybinds](https://github.com/XK9274/moonlight-app-miyoo/tree/main#frequently-asked-questions-faq)
- [Credits](https://github.com/XK9274/moonlight-app-miyoo#credits)

---

## Overview

This project is in its early stages and has bugs. This is not restricted to Nvidia, you can use AMD etc with Sunshine.

- Discord Contact: @XK user: \_xk\_

---

## Requirements

- Packaged for Onion (Porting to other UIs is welcome)
- Latest RC of Onion
- Recent firmware

---

## Keybinds
![DefKbind](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/adec936a-f918-4415-b34b-e2e6b8991b6b)


Press START to exit mouse mode.
Currently A is left click, B is right click.

**Note**: Moonlight on the Miyoo will only pass keyboard commands to the host, meaning no mouse and no gamepad input for now.


---

## Installation for Sunshine

1. **Install Sunshine on your machine.** [Download Sunshine](https://github.com/LizardByte/Sunshine/releases)
2. **Browse to `https://localhost:47990/`**: Create a local account, log in, and open the Pin page.
3. **Copy the Moonlight app folder**: Move it to `/mnt/SDCARD/App/moonlight` on your MMP.
   ![image](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/dda48437-d411-4221-9630-fbab5ce07def)
5. **Relaunch MainUI on your Miyoo or reboot.**
6. **Launch the Moonlight app**: Type in your PC's IP address.  
   ![script_012](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/8ec94d40-d454-4535-b660-6e68d37ff1ec)
7. **Input the PIN**: The MMP will provide a pin; you need to input this on the Sunshine dashboard. Minimise the keyboard with X as it might cause problems on the following screens. 
   ![script_014](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/ce398e2b-32a7-4a43-aeab-dea95700dbce)
8. **Confirmation Page**: On the MMP, you'll see a page asking if this was a success.  
   ![script_015](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/fdc37de4-16fa-4dca-affb-423e4652eab4)
9. **Success Screen**: You'll now see a success message.   
   ![script_016](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/ed13c223-c89d-40bc-9646-4a1491a2f4d0)
10. **App Screen**: Important: Do not press start! Minimise the keyboard with X, then press A to make your selection. When "yes" is selected, you'll now see the app screen.  
    ![script_017](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/f8ebbafa-a19b-49ef-94f6-b990418b514c)
11. **Connect to an App**: Select an app and it should connect; sometimes the app fails to launch on both Moonlight and Nvidia GameStream.

---

## Custom keybinds/cpuclock value

To set up your custom keybinds, you'll currently need to open the file `/mnt/SDCARD/App/moonlight/config/settings.json`

The file will contain:

```json
{
    "customkeys": {
        "A": "SPACE",
        "B": "BACKSPACE",
        "X": "X",
        "Y": "Y",
        "L1": "E",
        "L2": "Q",
        "R1": "T",
        "R2": "P",
        "LeftDpad": "LEFT",
        "RightDpad": "RIGHT",
        "UpDpad": "UP",
        "DownDpad": "DOWN",
        "Start": "RETURN",
        "Select": "M",
        "Menu": "ESCAPE"
    },
    "cpuclock": "1900",
    "mouse": {
        "scaleFactor": 2,
        "acceleration": 2.0,
        "accelerationRate": 2.5,
        "maxAcceleration": 10.0
    }
}
```
- Keybind values will have to be set based on their SDLK value, you can find the full list here: [SDLK Common names](https://www.libsdl.org/release/SDL-1.2.15/docs/html/sdlkey.html)
   - For example; SDLK_BACKSPACE will become BACKSPACE, SDLK_RCTRL will become RCTRL.
- CPUclock is ranged between 1000 -> 1950, defaulting at 1700. 

## To Do

- Add on the go overclocking control w/ keybind.
- Custom keybinds
- Mouse swap
- "Gamepad" support instead of keyboard input
- Tidy up all the drastic logic
- Proper wrapper development

---

## Credits

- Steward for SDL2
  - [GitHub Repository](https://github.com/steward-fu/sdl/tree/sdl-2.0.20_ssd202d_miyoo-mini_drastic)
  - [Moonlight Repository](https://github.com/XK9274/sdl2-moonlight-miyoo/tree/sdl-2.0.20_ssd202d_miyoo-mini_moonlight)
  
- [Moonlight Upstream GitHub Repository](https://github.com/moonlight-stream/moonlight-embedded)

---

## Frequently Asked Questions (FAQ)

### When i launch the app it says "loading" and then closes instantly
- If you used filezilla to transfer the files to the card, delete them and use Samba/HTTP instead. IF this doesn't resolve it, check the line endings on the script files are UNIX. not Windows.
- If this doesn't resolve it. Contact me

### When i press start on a menu option the app closes
- Close the keyboard with the X button on the MMP, then select the menu item with the A button
  
### Is there a build script for Moonlight?
- Not yet, but soon.

### It's laggy. What can I do?
- Don't stream at 4k/2k resolutions. Remove any higher resolutions from Sunshine under the General tab.

### The display is letterboxed on the MMP display when using Sunshine. How do I fix this?
- Set your desktop resolution to a 4:3 aspect ratio, such as 1400x1050 or 1280x960. If you're launching directly into a game, set the game's aspect ratio to 4:3 as well.

### Moonlight crashes after quitting a running stream and then reconnecting with Sunshine.
- The stream takes time to fully terminate. Give it a few seconds before trying to reconnect.

### The app has stopped or is not working. What should I do?
- Use the menu option to "Unpair" and then restart the app.

### There are audio pops when opening the app. Is this normal?
- Yes, this is a known issue with the MMP in general, it's totally "normal" with how the HW is configured.

### Input continues to be passed to the host even after exiting Moonlight. Why is this?
- This is a known issue, and i'm looking into it.

### My UI locks up sometimes when Moonlight doesn’t start (Black screen). What's the cause?
- This happens when rapidsplash fails to exit. I plan to update the source code to handle signals better. To clear it, open the gameswitcher or use the Search function with the Menu or Y key.

### There's a black screen when starting the app. How can I resolve this?
- This is caused by Shellect, which builds the shell menus. A change to this component is planned. To temporarily fix it, scroll down on your D-pad several times, press A, and then open the gameswitcher/search menu. Close this and reopen Moonlight.

---

## Changelog
### v1.2
  - Added mouse emulation

### v1.1
  - Added cpuclock settings.json object

### v1.0
  - Added correction for volume level when entering moonlight 
  - Fixed exit method in moonlight to close correctly.
  - Fixed a double free segfault
  - Added custom keybinds file `settings.json` that uses SDLK keycodes (https://www.libsdl.org/release/SDL-1.2.15/docs/html/sdlkey.html) - Follow example file.

### V0.9
  - Fix bad util.sh - https://github.com/XK9274/moonlight-app-miyoo/pull/1

### V0.8
  - New terminal w/ font by eggs
  - Better displays
  - Some error checking
  - Footer messages for help knowing which keys to press

### V0.7
  - Fixed black screen issue
  - Fixed input spam at end of session
  - Added new key shortcut: Select + Menu to exit
  - Handles SIGINT/SIGTERM sent from term to cleanup mi_gfx/mi_sys
  - Remove pressmenu2Kill from launch.sh

### V0.6
  - Fixed app list loop (Thank you for checking, [vitty85](https://github.com/Vitty85)

### V0.5
- Added ability to swap screens with `Select + Bumpers`

### V0.4
- Added pair check
- Changes in `launch.sh` and `pair.sh`
- Added `util.sh`
- Added exit menu item

### V0.3
- Added selection menu for the app to launch
- Added Gamestream support (Nvidia Geforce)
- Added `Unpair` menu selection to start screen

### V0.2
- [Download Older Version](https://drive.google.com/file/d/1bVOTvM2zHQSZ4IN4r1TF5NskHOQlbD4g/view?usp=sharing)
  - Fixed Controls: L2 now works, control scheme changed
  - Changed how moonlight is launched in `launch.sh`
  - Added an animated splash to the launching stage (after pairing)  
    **Note**: Source of gif unknown, if it’s yours, I can remove it or credit you

### V0.1
- Initial build (buggy and unreleased)
  - Added functional Moonlight and wrapper `launch.sh`/`pair.sh`

---
