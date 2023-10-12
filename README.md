# Moonlight Miyoo Edition

## Version
Moonlight for the Miyoo Mini Plus is currently at v0.6.

- [Download Latest Version](https://github.com/XK9274/moonlight-app-miyoo/releases)

---

## Overview

This project is in its early stages and has bugs. This is not restricted to Nvidia, you can use AMD etc with Sunshine.

- Discord Contact: @XK user: \_xk\_

---

## Requirements

- Packaged for Onion (Porting to other UIs is welcome)
- Simple terminal (st) from Onion's package manager
- Latest RC of Onion
- Recent firmware

---

## Keybinds
![DefKbind](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/1965216d-d305-48b2-9461-9c6980da6375)

**Note**: Moonlight on the Miyoo will only pass keyboard commands to the host, meaning no mouse and no gamepad input for now.

- **Additional Keybinds**
  - Switch screen: `Select + L1`, `Select + L2`, `Select + R1`, `Select + R2`

---

## Installation for Sunshine

1. Install Sunshine on your machine. [Download Sunshine](https://github.com/LizardByte/Sunshine/releases)
![script_000](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/49fd1e9f-2956-448f-8d7c-d5d33e4cb973)
2. Browse to `https://localhost:47990/`, Create a local account and log in and open the Pin page
![image](https://github.com/XK9274/moonlight-app-miyoo/assets/47260768/ac3fc43e-17f3-4754-802f-2f765ea7729b)
3. Copy the Moonlight app folder to `/mnt/SDCARD/App/moonlight` on your MMP
4. Relaunch MainUI on your Miyoo or reboot.
5. Launch the Moonlight app and type in your PC's IP address.

---

## Troubleshooting

- **If Moonlight doesn't start properly**: Delete `/mnt/SDCARD/App/config/pairdone` and `/mnt/SDCARD/App/moonlight.cache`, then try again.

---

## To Do

- Custom keybinds
- Add keybind for sending an escape
- Mouse swap
- "Gamepad" support instead of keyboard input
- Tidy up all the drastic logic
- Correctly close Moonlight
- Proper wrapper development

---

## Credits

- Steward for SDL2
  - [GitHub Repository](https://github.com/steward-fu/sdl/tree/sdl-2.0.20_ssd202d_miyoo-mini_drastic)
  - [Moonlight Repository](https://github.com/XK9274/sdl2-moonlight-miyoo/tree/sdl-2.0.20_ssd202d_miyoo-mini_moonlight)
  
- [Moonlight GitHub Repository](https://github.com/moonlight-stream/moonlight-embedded)

---

## Frequently Asked Questions (FAQ)

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
- Yes, this is a known issue.

### Input continues to be passed to the host even after exiting Moonlight. Why is this?
- This is a known issue, and we're looking into it.

### My UI locks up sometimes when Moonlight doesn’t start. What's the cause?
- This happens when rapidsplash fails to exit. We plan to update the source code to handle signals better. To clear it, open the gameswitcher or use the Search function with the Menu or Y key.

### There's a black screen when starting the app. How can I resolve this?
- This is caused by Shellect, which builds the shell menus. A change to this component is planned. To temporarily fix it, scroll down on your D-pad several times, press A, and then open the gameswitcher/search menu. Close this and reopen Moonlight.

---

## Changelog

### V0.6
- [Download](#)
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
- [Download Older Version](#)
  - Fixed Controls: L2 now works, control scheme changed
  - Changed how moonlight is launched in `launch.sh`
  - Added an animated splash to the launching stage (after pairing)  
    **Note**: Source of gif unknown, if it’s yours, I can remove it or credit you

### V0.1
- Initial build (buggy and unreleased)
  - Added functional Moonlight and wrapper `launch.sh`/`pair.sh`

---
