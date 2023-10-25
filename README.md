# Moonlight Miyoo Edition

## Version
Moonlight for the Miyoo Mini Plus is currently at v1.3.

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
- Latest 4.2 of Onion
- Recent firmware

---

## Keybinds
![DefKbind](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/0ed0fead-2cf4-4369-ba39-3af86ea895a2)

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
6. **Launch the Moonlight app**: Go to "Pair" and press A - type in your computers IP address and press Enter
   ![script_000](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/0e0e0483-9ef5-4087-96dd-9d3f01c239de)
6. **Enter the pair screen**: Type in your computers IP address and press Enter
   ![script_001](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/ee5494f8-1655-4a21-b270-6d2a85f42919)
8. **Input the PIN**: The MMP will provide a pin; you need to input this on the Sunshine dashboard.
   ![script_002](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/4672f089-285b-4813-88d2-15294b4ce6e6)
   ![image](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/811c767f-05f1-4034-b889-61e648256a3b)
10. **Confirmation Page**: On the MMP, you'll see a notification that pairing was complete (or an error if not)
   ![script_003](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/60dacf24-dcdf-4d2b-acf9-c3f6e92e0650)
12. **Start streaming**: Head back to the main menu and click "Stream" and select an app!
   ![script_000](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/fb7c6c2a-b231-41db-ba8a-8972847158b4)

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

- Add settings menu
- Go back to menu after quitting a game/stream
- Add options menu hotkey while streaming
- Gamepad etc
- FIX APP STARTUP/QUITTING

---

## Credits

- Steward for SDL2
  - [GitHub Repository](https://github.com/steward-fu/sdl/tree/sdl-2.0.20_ssd202d_miyoo-mini_drastic)
  - [Moonlight Repository](https://github.com/XK9274/sdl2-moonlight-miyoo/tree/sdl-2.0.20_ssd202d_miyoo-mini_moonlight)
  
- [Moonlight Upstream GitHub Repository](https://github.com/moonlight-stream/moonlight-embedded)

---

## Frequently Asked Questions (FAQ)

### When i launch a game it doesn't start on the remote desktop
- I think i know why, just haven't had time to look into why the GS (gs_quit_app) function is failing.

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

---

## Changelog
### v1.3
  - UI overhaul
  - Refactored most functions
  - Removed some reliance on the SDL lib
  - Added more settings for upcoming settings menu (overclocking etc)
  - Removed splash
  - Removed binaries that are no longer required
  - Updated FAQS
  - Convert all memcpy calls to neon_memcpy
  - Build libgamestream and libmoonlightcommon as stripped/arm optimised
    
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
