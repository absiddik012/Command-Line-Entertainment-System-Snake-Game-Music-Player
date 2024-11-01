
# Command Line Entertainment System: Snake Game & Music Player




## Introduction
This project integrates two classic forms of entertainment into your command line: a music player and a snake game, both developed using Bash scripting. It offers a fun way to engage with your terminal through interactive gaming and music listening.

## Key Features

### Music Player

- Play, pause, and stop music directly from the command line.
- Control music playback (next, previous, volume up, and volume down).
- Load and play music from a designated directory.
### Snake Game:

- Classic snake gameplay in the command line environment.
- Score tracking with local high score recording.
- Adjustable game speed for increased difficulty.
## Code Structures

- The Command Line Entertainment System is structured into several Bash scripts, each handling a different aspect of the system's functionality:

### 1. main_menu.sh:

- **Purpose:** Serves as the entry point for the system, presenting a menu to the user to choose between playing music or playing the snake game.

### Functions:
- **speak():** Uses Google Text-to-Speech to provide auditory feedback to the user.
- **flush_input():** Clears any pending input to avoid accidental command triggers.
- **Main loop:** Handles user input to navigate between different functionalities (music player, snake game, exit).


### 2. music_player.sh:

- **Purpose:** Manages music playback functionalities.

### Functions:
- **load_songs():** Loads song files from a specified directory.
- **list_songs():** Displays a list of available songs and handles user selection.
- **play_song():** Plays the selected song.
- **control_music():** Provides controls for pause/resume, stop, next track, previous track, volume up, and volume down.
- **show_menu():** Displays the music player's specific menu and handles user interactions.


### 3. snake_game.sh:

- **Purpose:** Implements the classic snake game within the terminal.

### Functions:
- **initialize_game():** Sets up the game area and initializes game variables.
- **place_food():** Places food randomly within the game area.
- **print_game_area():** Outputs the current state of the game area to the terminal.
- **read_input():** Non-blocking read operation to handle arrow key inputs for snake direction.
- **move_snake():** Updates the snake's position based on the current direction and checks for game over conditions.
- **show_menu():** Shows the snake game menu and handles speed selection and game starting.
- **select_speed():** Allows the user to select the game speed (slow, medium, fast).


### 4. high_score.dat:

- **Purpose:** Stores the high scores for the snake game.
- **Usage:** Read and written by the snake game script to keep track of the highest scores achieved.


## Additional Resources
- **Sound Effects:** Utilizes mpg123 for playing music and sound effects, enhancing the user experience with auditory feedback.
- **Visual Aesthetics:** Uses basic text and ASCII art to create a visually engaging interface directly in the command line.
## Prerequisite

- Linux OS or a compatible Unix environment.
- mpg123 for music playback.
- gtts-cli for text-to-speech functionality.
## Installation

### Clone this repository:



```bash
git clone https://github.com/absiddik012/command-line-entertainment.git

cd command-line-entertainment

```
    
### Make scripts executable
```bash
chmod +x main_menu.sh music_player.sh snake_game.sh
```
## Usage

1. **Start the main menu**
```bash
./main_menu.sh
```

2. **Follow on-screen prompts to choose between the music player and snake game.**
- Choose option from the menu to play music or the snake game.
- Navigate the music player or game using the provided commands.
## Example 

To get started with the Command Line Entertainment System, follow these steps:

1. Launch the System: Open your terminal and run the main menu script:
```bash
./main_menu.sh
```
2. Navigate the Menu:

- You will be greeted with the main menu options: 
Command Line Music Player and Snake Game
Welcome to the Command Line Entertainment System!
Let's have fun with our Music Player and Snake Game.
This system is under development by Final Project Team 2.

 1. Play Music
 2. Play Snake Game
 3. Exit

- Use your keyboard to select 1 to play music, 2 to start the snake game, or 3 to exit the system.

3. Music Player:

- If you choose to play music, follow the prompts to navigate through your music library and control playback.

4. Snake Game:

- If you choose the snake game, use the arrow keys to control the snake and try to eat the food without colliding with the walls or yourself.

5. Exit:

- At any point, you can exit the current activity and return to the main menu by following the on-screen prompts, or close the system entirely by selecting the exit option.
## Project Highlights

- **Dual Functionality:** Integrates two distinct applications—a music player and a snake game—into one streamlined command line interface, offering both entertainment and functionality without the need to switch contexts.

- **Command Line Optimization:** Designed specifically for command line use, this project leverages native shell scripting capabilities to ensure smooth performance and low resource consumption, making it ideal for systems with limited GUI capabilities or for users who prefer terminal-based applications.

- **Accessibility and Control:** Provides easy-to-use controls and commands that are accessible directly from the keyboard, enhancing usability and making it suitable for all levels of users—from beginners to advanced terminal users.

- **Customizable Settings:** Includes adjustable settings such as game speed in the snake game and volume control in the music player, allowing users to customize their experience according to their preferences.

- **Extensibility:** Built with modularity in mind, enabling easy expansion and customization. Developers can add more games, enhance the music player features, or integrate additional tools into the system.

- **Community-Driven Development:** Encourages contributions from the community, allowing users and developers to continuously improve the system by adding features, fixing bugs, and updating documentation.

- **Portable and Lightweight:** Runs on any Unix-like system with minimal dependencies, making it portable across different distributions and easy to include in any developer's toolkit.
## Authors

- [Abu Bakar Siddik](https://github.com/absiddik012)


## License

This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/) License - see the [LICENSE.md](LICENSE.md) file for details.

