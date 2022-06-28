# Xfce4-gamemode

Gamemode tweak for XFCE4 desktop.

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/146c6a2273a94ffca4a29359fd6f4076)](https://www.codacy.com/gh/itz-me-ZaPPeX/xfce4-gamemode/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=itz-me-ZaPPeX/xfce4-gamemode&amp;utm_campaign=Badge_Grade)
[![license](https://img.shields.io/badge/license-Apache--2.0-blue)](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/LICENSE)
[![platfotm](https://img.shields.io/badge/platform-linux-lightgrey)](https://en.wikipedia.org/wiki/Linux)
[![DE](https://img.shields.io/badge/desktop%20environment-xfce--4.16%20tested-blue)](https://www.xfce.org/?lang=en)

## Description

This utility created on Bash that supports controlling various commands from the terminal. It is intended to extend the gaming functionality of the XFCE4 desktop environment. Supports configuration files for custom presets and init-system service management. The default presets are aimed to provide better performance on different systems by disabling compositing and unnecessary XFCE4 services, but can also be used to extend the gaming functionality by starting/stopping applications and services during games. Managing normal services (without root access) does not require any additional manipulation when starting/stopping, but to manage services of the init-system, you must enter a password in the PolicyKit dialog box.

## INSTALLIATION

## Installing git version from a branch:

```
$ git clone https://github.com/itz-me-ZaPPeX/xfce4-gamemode.git
$ cd xfce4-gamemode
$ chmod u+x install.sh
$ sudo ./install.sh
```

## Installing stable version:

```
$ wget https://github.com/itz-me-ZaPPeX/xfce4-gamemode/releases/download/vX.X.X/xfce4-gamemode-X-X-X.tar.gz
$ tar zxvf xfce4-gamemode-X-X-X.tar.gz
$ cd xfce4-gamemode-X-X-X
$ chmod u+x install.sh
$ sudo ./install.sh
```

## USAGE

For usage information, enter this command:
```
xfce4-gamemode --help
```
Output:
```
Usage: xfce4-gamemode [OPERAND]
   or: xfce4-gamemode [OPERAND] [PARAMETERS]

Available operands:

--enable, -e                 Enable XFCE4-GAMEMODE
--disable, -d                Disable XFCE4-GAMEMODE
--set, -s                    Management of presets and init-system services
--info, -i                   Utility information
--help, -h                   Help
--edit, -ed                  Editing configuration files
--keybind, -k                Designed to enable/disable the XFCE4-GAMEMODE with one key combination (works by recognizing the activity of the utility)

Utility management:

--remove, -rm                Remove utility
--reset, -r                  Reset utility settings

Additional operand parameters:

--set, -s                    preset <default, performance, high-performance, custom-preset>; init-manage <true, false>
--edit, -ed                  custom-preset; init-config
--reset, -r                  config; data; all
```
For a better experience, you can create keyboard shortcuts to control the utility, for example to enable/disable you can use this command:
```
xfce4-gamemode --keybind
```
instead of
```
xfce4-gamemode --enable
xfce4-gamemode --disable
```

### Example:

![screenshot-4](https://github.com/itz-me-ZaPPeX/xfce4-gamemode/blob/main/images/screenshot-4.png)

## PRESETS AND INIT-MANAGE

Standard presets:
```
Default - disables screen darkening and shutdown along with XFWM window manager compositing (set by default)
    
Performance - same as "Default", but also disables XFDESKTOP with XFCE4-CLIPMAN
    
High-performance - same as "Performance", but also disables XFCE4-PANEL, NM-APPLET, BLUEMAN-APPLET, XFCE4-POWER-MANAGER, LIGHT-LOCKER, XFCE4-NOTIFYD
```

Custom preset:
```
Custom-preset - lets you fully customize the start/stop of applications when XFCE4-GAMEMODE starts and ends
```

Init-system service management:
```
Init-config - requires user edits, also improves performance when configured normally
```

Change of preset:
```
xfce4-gamemode --set preset default/performance/high-performance/custom-preset
```

Enable/disable init-system service management:
```
xfce4-gamemode --set init-manage true/false
```
## TESTS IN "TOMB RAIDER 2013" (Proton 7.0.3)

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

### Conclusion

On my hardware, the difference between the presets is not noticeable (within the margin of error), but may help users with a weaker computer.
Also, don't forget to tune your distribution to improve performance.
