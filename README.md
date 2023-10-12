---

# Moonlight Miyoo Edition

## Version
Moonlight for the Miyoo Mini Plus is currently at v0.6.

- [Download Latest Version](#)
- [Changelog](#)

---

## Overview

This project is in its early stages and has bugs. It is not restricted to Nvidia; you can also use AMD etc., with Sunshine.

- Discord Contact: @XK user: \_xk\_
- [FAQ](#)

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
2. Browse to `https://localhost:47990/`
3. Create a local account and log in.
4. Copy the Moonlight app folder to `/mnt/SDCARD/App/moonlight`
5. Relaunch MainUI on your Miyoo or reboot.
6. Launch the Moonlight app and type in your PC's IP address.
7. Follow the on-screen instructions to pair.

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

## FAQ

- [How to add custom apps to Sunshine](https://docs.lizardbyte.dev/projects/sunshine/en/latest/about/app_examples.html)

- **Is there a build script for Moonlight?**  
  Not yet, but soon.

- **Other common issues and fixes**:  
  See [FAQ](#)

---

## Changelog

### V0.6
- [Download](#)
  - Fixed app list loop (Thank you for checking, Vitty85)

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
