# xfce4-gamemode

Gamemode tweak for XFCE4 desktop.

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/146c6a2273a94ffca4a29359fd6f4076)](https://www.codacy.com/gh/itz-me-ZaPPeX/xfce4-gamemode/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=itz-me-ZaPPeX/xfce4-gamemode&amp;utm_campaign=Badge_Grade)
[![license](https://img.shields.io/badge/license-Apache%202.0-green)](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/LICENSE)
[![platfotm](https://img.shields.io/badge/platform-linux-lightgrey)](https://en.wikipedia.org/wiki/Linux)
[![DE](https://img.shields.io/badge/desktop%20environment-xfce4-blue)](https://www.xfce.org/?lang=en)
![release](https://img.shields.io/badge/last%20updated-04.07.2022-yellow)

## Description

This utility created on Bash that supports controlling various commands from the terminal. It is intended to extend gaming functionality of the XFCE4 desktop environment. Supports configuration files for custom presets and init-system service management. Default presets are aimed to provide better performance on different systems by disabling compositing and unnecessary XFCE4 services, but can also be used to extend the gaming functionality by starting/stopping applications and services during games. Managing normal services (without root access) does not require any additional manipulation when starting/stopping, but to manage services of the init-system, you must enter a password in the PolicyKit dialog box.

## Installation

```
$ git clone https://github.com/itz-me-ZaPPeX/xfce4-gamemode.git
$ cd xfce4-gamemode
$ chmod u+x install.sh
$ sudo ./install.sh
```

## Usage

For usage information, enter this command:
```
xfce4-gamemode help
```
Output:
```
Usage: xfce4-gamemode [OPERAND]
   or: xfce4-gamemode [OPERAND] [PARAMETERS]

Available operands:

enable                     Enable gamemode
disable                    Disable gamemode
set                        Management of presets and init-system services
info                       Utility information
help                       Help
edit                       Edit configuration files
keybind                    Enable/disable the utility depending on its state (may be useful for creating a keyboard shortcut)
uninstall                  Uninstall utility
reset                      Reset utility settings
update                     Update utility

Additional operand parameters:

set                        --preset <default, performance, high-performance, custom-preset>
                           --init-manage <true, false>
edit                       --custom-preset
                           --init-manage
reset                      --config
                           --data
                           --all
```
For a better experience, you can create keyboard shortcuts to control the utility, for example to enable/disable you can use this command:
```
xfce4-gamemode keybind
```
instead of
```
xfce4-gamemode enable
xfce4-gamemode disable
```

### Example

![example](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/example.png)

## Presets

| Name | Disables |
| ---- | -------- |
| Default | Screen blanking, compositing |
| Performance | Screen blanking, compositing, xfdesktop, xfce4-clipman |
| High-performance | Screen blanking, compositing, xfdesktop, xfce4-clipman, xfce4-panel, nm-applet, blueman-applet, xfce4-power-manager, light-locker, xfce4-notifyd |

## Tests in "Tomb Raider 2013" (Proton 7.0.3)

### Tested system

All tests were done on a freshly installed Manjaro Linux XFCE 21.3.0 (full edition) without any optimizations. Steam was preinstalled, only Flameshot and Mangohud were installed

![screenshot-1](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/screenshot-1.png)

### Graphics settings

![screenshot-2](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/screenshot-2.png)
![screenshot-3](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/screenshot-3.png)

### Results

#### XFCE4-GAMEMODE DISABLED

![gamemode-off](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/gamemode-off.png)

#### XFCE4-GAMEMODE ENABLED ("default" preset)

![gamemode-default](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/gamemode-default.png)

#### XFCE4-GAMEMODE ENABLED ("performance" preset)

![gamemode-performance](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/gamemode-performace.png)

#### XFCE4-GAMEMODE ENABLED ("high-performance" preset)

![gamemode-high-performance](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/gamemode-high-performance.png)

## Conclusion

On my hardware, difference between presets isn't noticeable (within the margin of error), but may help users with a weaker computer.
Also, don't forget to tune your distribution to improve performance.
