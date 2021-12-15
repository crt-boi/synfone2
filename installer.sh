#!/bin/bash
if ! [ -x "$(command -v dialog)" ]; then
  echo 'Error: dialog not installed, please install that you donkey'
  echo 'Trying to auto install it enter sudo password if necessary'
    if ! [ -x "$(command -v apt)" ]; then
        echo "Oge this aint a debian machine"
    else
        echo "Debian based distro detected, installing dialog"
        sudo apt install dialog
    fi
    if ! [ -x "$(command -v pacman)" ]; then
        echo "this aint archlinux aswell, what madness are you trying to install this on?"
    else
        sudo pacman -S dialog --noconfirm
    fi

fi
dialog --backtitle "crt-quickdep" --title "itl_chorus client ezy-compile" --msgbox "Bro don use this its not done yet" 6 58
HEIGHT=15
WIDTH=70
CHOICE_HEIGHT=4
BACKTITLE="crt-quickdep"
TITLE="itl_chorus client ezy-compile"
MENU="Choose the appropriate installer please:"

OPTIONS=(1 "Compile for my machine, do not autostart"
         2 "Compile for my machine, and configure autostart")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            dialog --title "crt quickdep" \
            --yesno "Would you like to compile Synfone2?" 7 60
            result=$?
            case $result in
            0)
            clear
                if ! [ -x "$(command -v cargo)" ]; then
                        echo 'Error: cargo not installed, trying to install rustup for you :)'
                        echo 'Please follow the rustup installer'
                        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
                        echo 'oge rust should now be installed unless you canceled it '
                fi

                if ! [ -x "$(command -v alsamixer)" ]; then
                        echo 'Error: alsa utils not installed, trying to install them for you :)'
                        echo 'Please follow the installer if necessary'
                                            if ! [ -x "$(command -v pacman)" ]; then
                                                if ! [ -x "$(command -v apt)" ]; then
                                                    echo 'Compatible package manager not found'
                                                else
                                                    sudo apt install alsa-utils
                                                    ##untested
                                                fi
                                            else
                                                sudo pacman -S alsa-utils

                                            fi
                        echo 'oge alsa utils should be installed now if you didnt fuck it up'
                fi

            cargo build --release


            ;;
            1)     dialog --title "Installation canceled" --msgbox "Okay uhm great i guess?" 5 40;clear ;;
            255)   echo "Action Cancelled – Presssed [ESC] key.";;
            esac
            echo "Sel1"
            ;;
        2)
            dialog --title "crt quickdep" \
            --yesno "Would you like to install Synfone2 binary for 64bit Archlinux machine? )" 7 60
            result=$?
            case $result in
            0)
            clear
            echo "Starting installer, please dont touch your damn keyboard!"
            sleep 10
            cd ~ ||exit
            sudo pacman -Syyy
            sudo pacman -S rust unzip pulseaudio-alsa
            wget https://512mb.org/files/itl_chorus/bin/hp-client-64bit.zip
            unzip ./hp-client-64bit.zip
            cd ./hp-client-64bit ||exit
            chmod a+x synfone
            echo "installation complete, well the basic one atleast. Autosignon and autostarts will be added later (tm) to this installer!"
            dialog --title "crt quickdep" \
            --yesno "Would you like to configure autostart? (Press no to test run synfone2 and ESC to exit)" 7 60
            autostart=$?
            case $autostart in
            0)
                clear #todo
                ;;
            1)
                clear #todo
                ;;
            255)
                clear #todo
                ;;
            esac
            ;;
            1)     dialog --title "Installation canceled" --msgbox "Okay uhm great i guess?" 5 40;clear ;;
            255)   echo "Action Cancelled – Presssed [ESC] key.";;
            esac
            echo "Binary HP desktop installer (amd64 64bit) Should work on most machines"
            ;;
esac
