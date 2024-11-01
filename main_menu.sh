#!/bin/bash

# This function is to flush the inputs.
function flush_input {
    read -t 0.1 -n 10000 discard
}



# Check if 'mpg123' is installed
if ! command -v mpg123 &>/dev/null; then
    echo "Error: 'mpg123' is required but it's not installed."
    exit 1
fi

# Function to speak text using Google Text-to-Speech
function speak {
    local text="$1"
    gtts-cli "$text" --output /tmp/speech.mp3
    mpg123 /tmp/speech.mp3 2>/dev/null
}

# Welcome message
#speak "Welcome to the Command Line Music Player and Snake Game. Please select an option."

while true; do
    clear
    echo "Command Line Music Player and Snake Game"
    echo -e "Welcome to the Command Line Entertainment System!"
    echo -e "Let's have fun with our Music Player and Snake Game."
    echo -e "This system is under development by Final Project Team 2."
    echo 
    echo "1. Play Music"
    echo "2. Play Snake Game"
    echo "3. Exit"
    speak "Welcome to the command line music player and snake game. This application is still under development by team 2 entertainers. Please select an option below."
    flush_input
    read -p "Select an option: " choice
    flush_input

    case "$choice" in
        1)
            speak "You have chosen to play music."
            # Ensure the music_player.sh is executable or handle it appropriately
            ./music_player.sh
            ;;
        2)
            speak "You have chosen to play the snake game."
            # Ensure the snake_game.sh is executable or handle it appropriately
            ./snake_game.sh
            ;;
        3)
            speak "Exiting the application. Thank you for using our service."
            echo "Exiting..."
            exit 0
            ;;
        *) 
            speak "Invalid option. Please try again."
            echo "Invalid option. Please try again."
            ;;
    esac
done

