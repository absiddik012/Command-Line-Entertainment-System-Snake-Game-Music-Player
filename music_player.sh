#!/bin/bash

# Directory containing music files
MUSIC_DIR="./music"

# Ensure mpg123 is available
if ! command -v mpg123 &> /dev/null; then
    echo "mpg123 is not installed. Please install it to proceed."
    exit 1
fi

# Function to speak text using Google Text-to-Speech
function speak {
    local text="$1"
    gtts-cli "$text" --output /tmp/speech.mp3     # Convert text to speech and save as mp3.
    mpg123 /tmp/speech.mp3 2>/dev/null            # Play the speech file quietly.
}


# Load all songs from the directory
declare -a songs
function load_songs {
    local i=1
    while IFS= read -r line; do
        songs[i++]="$line"
    done < <(find "$MUSIC_DIR" -type f -name '*.mp3' -print | sort)
}

# Display all available songs and allow the user to select one to play.
function list_songs {
    echo "Available Songs:"
    for (( i=1; i<${#songs[@]}+1; i++ )); do
        echo "$i. $(basename "${songs[i]}")"
    done
    echo "Enter the number of the song to play or '0' to cancel:"
    read -r choice

    #listing the songs with awk command.    
    #echo "Available Songs:"
    #for (( i=1; i<${#songs[@]}+1; i++ )); do
        #echo "$i. $(basename "${songs[i]}" | awk -F'.' '{print $1}')"
    #done
    #echo "Enter the number of the song to play or '0' to cancel:"
    #read -r choice
    
    # listing the songs with sed command.
    #echo "Available Songs:"
    #for (( i=1; i<${#songs[@]}+1; i++ )); do
        #echo "$i. $(basename "${songs[i]}" | sed 's/_/ /g')"
    #done
    #echo "Enter the number of the song to play or '0' to cancel:"
    #read -r choice
    
    if [[ $choice -gt 0 && $choice -le ${#songs[@]} ]]; then
        play_song $choice
    elif [[ $choice -eq 0 ]]; then
        return
    else
        echo "Invalid selection."
    fi
}

function play_song {
    local song_index=$1
    echo "Playing: $(basename "${songs[song_index]}")"
    nohup mpg123 -q "${songs[song_index]}" </dev/null &>/dev/null &
    PID=$!
    control_music
}

# Function to stop music
function stop_music {
    if [[ $PID ]]; then
        kill -9 $PID
        wait $PID 2>/dev/null
    fi
}

function control_music {
    echo "                      .+++++++++++++++*****************############-                      "
    echo "                      .++++++++++************######################-                      "
    echo "                      .+++++++**************#######################-                      "
    echo "                      :+++++***************########################-                      "
    echo "                      :+++****************#####**+=--:.-###########-                      "
    echo "                      :****************=--::.          .###########-                      "
    echo "                      :***************                 .###########-                      "
    echo "                      :*************#+             .:: .###########-                      "
    echo "                      :************##+  .::-==+**#####..###########-                      "
    echo "                      :******########+ =##############..###########-                      "
    echo "                      :##############* =##############..###########-                      "
    echo "                      :##############* =#############+ .###########-                      "
    echo "                      :##############= =#########+-:   .#########**-                      "
    echo "                      :##########*=-.  =########:      .#######****-                      "
    echo "                      :########*.      =#######=       -#####******-                      "
    echo "                      :########:       +########:    .=###*********-                      "
    echo "                      :########=      +###########**####***********-                      "
    echo "                      :##########+++*################**************-                      "
    echo "                      :############################****************:                      "
    echo "                      :##########################******************:                      "
    echo "                      :########################********************:                      "
    echo "                      :######################*********************+:                      "

    echo -e "1. Pause/Resume\n2. Stop\n3. Next Track\n4. Previous Track\n5. Volume Up\n6. Volume Down\n7. Exit Control Menu"
    local control_choice
    while true; do
        read -p "Choose an option: " control_choice
        case "$control_choice" in
            1)  # Toggle pause/resume
                kill -STOP $PID
                read -p "Press any key to resume..." -n 1
                kill -CONT $PID
                ;;

            2)  # Stop the music
                kill -9 $PID
                wait $PID 2>/dev/null
                break
                ;;

            3)  # Next track
                stop_music
                current_song=$((current_song % ${#songs[@]} + 1))
                play_song $current_song
                ;;

            4)  # Previous track
                stop_music
                current_song=$(((current_song - 2 + ${#songs[@]}) % ${#songs[@]} + 1))
                play_song $current_song
                ;;

            5)  # Volume Up
                amixer sset Master 10%+ > /dev/null 2>&1
		echo "Volume increases by 10%."
                ;;

            6)  # Volume Down
                amixer sset Master 10%- > /dev/null 2>&1
		echo "Volume decreases by 10%."
                ;;

            7)  # Exit Control Menu
                return
                ;;
            *) echo "Invalid option. Please try again."
                ;;
        esac
    done
}

function show_menu {
    while true; do
	echo -e "		........................,;+****+;;:,.................	"
        echo -e "		......................,**%?????%****+;,..............	"
	echo -e "		......................*?*?%%%%%%++++++*+:,...........	"
	echo -e "		......................*?*%S%%%%%**++++*+;+;,.........	"
	echo -e "		......................*?%SSSSSS%%%??*+++;;++:........	"
	echo -e "		......................+?SS#SSSS%%%%?***+*+;;+;.......	"
	echo -e "		......................,*%S#S##%%S%%????*******+,.....	"
	echo -e "		.......................,*%###SSSS%%%%?*******+**,....	"
	echo -e "		........................,*S@####SSSSS%??%??***+*+....	"
	echo -e "		........................,??%######SS%%%%%%????**?,...	"
	echo -e "		.......................,*????%#####SS%SSS%%%%%%??:...	"
	echo -e "		......................:*%SSS%?%#####SSSSS%%%%%???+...	"
	echo -e "		....................,;?%S#S%?*++?SSSSSSSS%%%%%%??;...	"
	echo -e "		..................,;%##S%+;,,...,;**??%%%?????%?:....	"
	echo -e "		.................,*S#S?;,..........:;++*******+,.....	"
	echo -e "		.................:%%?,.....................,.........	"
	echo -e "		.................;?*+,....,..........................	"
	echo -e "		.................,+*;,...:**,........................	"
	echo -e "		..................:;*+,::+*S*,.......................	"
	echo -e "		................,.::;*+;:::+?,.......................	"
	echo -e "		......,,;++*******??******++*+:,.....................	"
	echo -e "		....,;++**?S%%SSS##SSSSSSSS%%?**+,...................	"
	echo -e "		...:+***?%%SS#############SSS%?*?*;,,................	"
	echo -e "		..,;?SSSSS%%S%%%%SS%S%%%%SS%%%%%%?+;+,...............	"
	echo -e "		....?#%%%??%%%%?*????????????***#%..;:...............	"
	echo -e "		....?S?????????SSSSSSSS%**???*+*#%..,;+%??*+.........	"
	echo -e "		...,%S%????%??%SS%S#SSS%*?????*?SS,...,:;;+;.........	"
	echo -e "		...;##%?%%????%#SSSSSSS%??**????##:..................	"
	echo -e "		..:*##%SS%%%%%%????**?*?%%??????#S+:.................	"
	echo -e "		.:??SSSSSSSSSSSSSS%SSS%%S%%%%%%%%%?*:................	"
	echo -e "		:?%%%%%%%%?%??%????????%???????????%?;,..............	"
	echo -e "		?SS#?;;;;;;;;;;::::::::::::::::::;%%%?,..............	"

	echo "Welcome to the Matrix of Melodies folks, Enjoy with your favorite songs."
        echo "Music Player Menu:"
        echo "1. List and Play Songs"
        echo "2. Exit Music Player"
	speak "Welcome to the Matrix of Melodies folks. Enjoy with your favorite songs. Now select an option below."
        read -p "Select an option: " choice
        case "$choice" in
            1) list_songs ;;
            2) echo "Exiting Music Player..."; [[ $PID ]] && kill -9 $PID; exit 0 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

load_songs
show_menu

