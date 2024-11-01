#!/bin/bash

function flush_input {
    read -t 1 -n 10000 discard
}

# Function to speak text using Google Text-to-Speech
function speak {
    local text="$1"
    gtts-cli "$text" --output /tmp/speech.mp3
    mpg123 /tmp/speech.mp3 2>/dev/null
}

# Terminal settings for reading arrow keys without waiting for a line return
stty -echo -icanon time 0 min 0

# Declare and initialize game-related variables
declare -A game_area  # Array to represent the game area
declare -i game_width=70 game_height=20     # Game area dimensions
declare -i food_x food_y     # Food coordinates
declare -i score=0 high_score=0     # Score tracking
declare -a snake_body     # Array to store snake's body segments
declare game_running=true    # Game state flag
declare direction="RIGHT"     # Initial movement direction of the snake
declare input_key=""     # Variable to capture player's keyboard input
declare -i tick_rate=3  # Speed setting, adjust accordingly

# Load high score if it exists
[[ -f "high_score.dat" ]] && read -r high_score < high_score.dat

#if [[ -f "high_score.dat" ]]; then
    #read -r line < high_score.dat
    #high_score_name=${line%%:*}
    #high_score=${line##*:}
#fi

# Initialize the game by setting up the game area and placing the snake and food
function initialize_game {
    clear     # Clear the console

    # Set initial position of the snake in the middle of the game area
    snake_x=$((game_width / 2))
    snake_y=$((game_height / 2))
    snake_length=3    # Initial length of the snake
    snake_body=()     # Reset snake body array

    # Reset snake body
    for ((i=0; i<snake_length; i++)); do
        snake_body[$i]="$snake_y,$((snake_x-i))"
    done

    # Initialize the game area with empty spaces and borders
    for ((y=0; y<=game_height; y++)); do
        for ((x=0; x<=game_width; x++)); do
            if (( y == 0 || y == game_height || x == 0 || x == game_width )); then
                game_area[$y,$x]="#"    # Set borders
            else
                game_area[$y,$x]=" "    # Set empty space
            fi
        done
    done
    # Place initial snake position on the game board
    game_area[$snake_y,$snake_x]="S"
    place_food
}

# Place food at a random location
function place_food {
    while true; do
        food_x=$((1 + RANDOM % (game_width - 2)))
        food_y=$((1 + RANDOM % (game_height - 2)))
        if [[ "${game_area[$food_y,$food_x]}" == " " ]]; then
            game_area[$food_y,$food_x]="F"    # Mark the food location
            echo -ne '\007'  # Sound for placing food
            break
        fi
    done
}

# Print the current state of the game area
function print_game_area {
    clear    # Clear the console for a fresh fram
    for ((y=0; y<=game_height; y++)); do
        for ((x=0; x<=game_width; x++)); do
            printf "${game_area[$y,$x]}"      # Print each cell of the game area
        done
        echo
    done
    echo "Score: $score High Score: $high_score"    # Display scores
}

# Read player input using non-blocking read with arrow key support
function read_input {
    read -s -n 3 -t 0.1 input_key
    case "$input_key" in
        $'\e[A'|$'\eOA') [[ "$direction" != "DOWN" ]] && direction="UP" ;;
        $'\e[B'|$'\eOB') [[ "$direction" != "UP" ]] && direction="DOWN" ;;
        $'\e[C'|$'\eOC') [[ "$direction" != "LEFT" ]] && direction="RIGHT" ;;
        $'\e[D'|$'\eOD') [[ "$direction" != "RIGHT" ]] && direction="LEFT" ;;
    esac
}

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Show main menu with enhanced visuals with colors and the design of an anaconda.
function show_menu {
    local choice

    while true; do
        clear
        echo -e "${GREEN}Welcome to the Command Line Entertainment System!${NC}"
        echo -e "Let's have fun with our ${MAGENTA}Music Player${NC} and ${MAGENTA}Snake Game${NC}."
        echo -e "${GREEN}This system is under development by Final Project Team 2.${NC}"
        echo
        echo -e "                 __    __    __    __"
        echo -e "                /  \  /  \  /  \  /  \ "
        echo -e "_______________/  __\/  __\/  __\/  __\________________________________"
        echo -e "_________________/  /__/  /__/  /__/  /________________________________"
        echo -e "                 | / \   / \   / \   / \  \____ "
        echo -e "                 |/   \_/   \_/   \_/   \    o \ "
        echo -e "                 /                       \_____/--< "
        echo
        echo -e "${BLUE}1.${NC} Start Game"
        echo -e "${BLUE}2.${NC} View High Score"
        echo -e "${BLUE}3.${NC} Exit"
        echo -e "${WHITE}Select an option:${NC} "
	flush_input
        read -n 1 choice
        echo
        case "$choice" in
            1) 
                select_speed
                break
                ;;
            2) 
                view_high_score
                break
                ;;
            3) 
                echo -e "${GREEN}Exiting...${NC}"
		speak "I hope you enjoyed the game so far. We are exiting now."
                #./main_menu.sh
		exit 0
                ;;
            *) 
                echo -e "Sorry! Wrong input, please try again."
		speak "Sorry! Wrong input, Please try again."
                sleep 2  # Pause before clearing the screen and re-prompting and it is for 2 seconds
        esac
    done
}

# Function to select game speed
function select_speed {
    echo "Select the speed:"
    echo "1. Slow"
    echo "2. Medium"
    echo "3. Fast"
    speak "Now choose the speed to continue."
    read -n 1 speed_choice
    echo

    case $speed_choice in
        1) tick_rate=5 
	   speak "You want to play with slow speed.";;
        2) tick_rate=3 
	   speak "You want to play with Medium speed.";;
        3) tick_rate=1 
	   speak "You want to play with the high speed.";;
        *) 
	   echo "Invalid choice. Defaulting to Medium speed."; tick_rate=3
   	   speak "You have chosen an invalid option. So, you are redirecting with the default speed which is medium.";;
    esac
    initialize_game
}

# Function to view the highest score
function view_high_score {
    echo "The highest score is: $high_score"
    echo "Press any key to return to the main menu..."
    speak "The highest score is $high_score"
    speak "Press any key to return to the main menu..."
    read -n 1
    show_menu
}

# Update game state
function move_snake {
    local old_head="${snake_body[0]}"
    local new_head_y=${old_head%,*}
    local new_head_x=${old_head#*,}

    case $direction in
        UP)    ((new_head_y--)) ;;
        DOWN)  ((new_head_y++)) ;;
        LEFT)  ((new_head_x--)) ;;
        RIGHT) ((new_head_x++)) ;;
    esac

    # Check for collisions
    if [[ "${game_area[$new_head_y,$new_head_x]}" == "#" || "${game_area[$new_head_y,$new_head_x]}" == "S" ]]; then
        echo -ne '\a'  # Sound for game over
        game_running=false
        return
    fi

    # Move the snake
    snake_body=("$new_head_y,$new_head_x" "${snake_body[@]}")
    if [[ "$new_head_y" -eq "$food_y" && "$new_head_x" -eq "$food_x" ]]; then
        ((snake_length++))
        ((score++))

	# Check and update high score
        ((score > high_score)) && high_score=$score && echo $high_score > high_score.dat
	
	#if [[ "$score" -gt "$high_score" ]]; then
            #echo "New high score! Enter your name:"
            #read player_name
            #high_score=$score
            #echo "$player_name:$high_score" > high_score.dat
        #fi

        place_food
    else
        local old_tail="${snake_body[-1]}"
        unset snake_body[-1]
        game_area[${old_tail%,*},${old_tail#*,}]=" "
    fi

    # Update the snake on the game area
    for pos in "${snake_body[@]}"; do
        game_area[${pos%,*},${pos#*,}]="S"
    done
    game_area[$food_y,$food_x]="F"
}

# Main game loop
show_menu
while $game_running; do
    print_game_area
    read_input
    move_snake
    sleep 0.$tick_rate
done


echo "Game Over!"
echo "Final Score: $score"
echo "Press any key to continue..."
speak "Game Over!"
speak "Your final Score is $score"
speak "Press any key to continue"
read -n 1
show_menu

#if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#    show_menu  # Show the menu if the script is run directly.
#    echo "You have exited the Snake Game."  # Optionally perform any cleanup or final statements.
#else
#    show_menu  # Just show the menu if sourced, do not exit or echo anything.
#fi
