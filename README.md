Elite Copilot for OS-X: Proof of Concept v1.0

Elite Copilot is a companion program to Elite 4, aka Elite:Dangerous by Frontier Development. It provides voice activated, user-configurable, macro commands to activate in-game features and provides voice responses to those actions.

This program is written entirely separate from and without the knowledge, approval or help of Frontier Development. It is believed by the author, Frank Nichols, that use of Elite Copilot is in compliance with all Elite 4 terms and conditions. If any violations of the terms and conditions are determined, the author's sole responsibility will be to correct the program to bring it into compliance, or to stop development and distribution if it is not possible to correct the problem to Frontier Development's satisfaction.

This program is developed and distributed under the Creative Commons 3.0 with attribution license.

https://creativecommons.org/licenses/by/3.0/us/

PLEASE READ THE FOLLOWING:

The motivation for the first release of the Proof of concept is to gather information about various user configurations running some basic functions that will be required in the final release of the Elite Copilot for OS-X.

THIS RELEASE IS NOT COMPLETE and may CRASH.

Elite Copilot for OS-X is targeted to OS-X systems version 10.10 (Yosemite) or newer. You are welcome to try it on older versions of OS-X but it probably won't work and unless there is overwhelming demand there is no intent to make it compatible with older versions.

Estimated release of version 1.0 (it is yet to be determined what features version 1.0 will implement) is late December 2015. Prior to that a series of prototype/Alpha, Beta and Gold Master versions will be released.

●	Prototype/Alpha versions are defined as some features present which may or may not work. Limited specifications will be available.

●	Beta versions are defined as a complete version.  The specification is frozen and the program implements all features for that version. Not all features will necessarily work properly on all supported platforms. (There may/will be bugs.)

●	Gold Master is defined as all functions/features of the upcoming release are implemented and are believed to work on all supported platforms.

●	Release version is feature complete and stable - this is the recommended version for most users. NO NEW FEATURES will be added to released versions. Some minor version updates will occur in the case of serious bugs being found and fixed. Minor bug fixes will be delayed until the next released version.

The following features are available for testing in this release - 

●	Import the Elite Control Bindings from the users’ game so that Elite Copilot can use the same keybindings for its voice activated macros.

●	Allow user-settable timing for Keydown-to-Keyup events in the actions, this permits testing of timing requirements for different systems. You are encouraged to adjust these timings to the lowest (or highest) values that will result in reliable operation.

●	Using the Built-in OS-X Dictation services for voice commands.

The following features are NOT available for testing in this release:

●	Sequences of actions activated by a single spoken command. 

●	Voice responses. In future releases, the voice responses will be user configurable and will be able to be configured for either voice-acted recordings or text to speech synthesis or a mixture of both.

●	Conditional execution of actions/command/responses based on state of the game or location of the ship. 

●	Saving and sharing configurations/commands/responses etc.

●	Use of third party "voice packs" with prerecorded voice responses to actions and game status.

User Guide to testing this Proof of Concept

●	Download the .zip file from the Github website: https://github.com/frnic/Elite-Copilot
  ○	This will place a .zip file in the location your web browser downloads to.
  ○	Unzip the file and you will have a folder called Elite-Copilot-master. 
  ○	Inside the folder is a file called EliteCopilot.app - move this folder to your desktop or where you want to save and run it from (the Applications folder will work also)
  ○	Double clicking (launching) the app may result in the security in your system telling you that you can not run this program because it is “unsigned”. If this happens you will need to go to your System Preferences and select the Security & Privacy option and at the bottom grant permission to run the application anyway. The source code is available with the application if you are concerned with possible security problems/issues. The final release of the problem will be signed by an Apple Developer (me) and this step will not be necessary. 
●	Hello World Test
  ○	Launch Elite CoPilot
  ○	At the bottom center area of the window that opens, click the + sign to add a new command. The new command will be added to the command list on the top left, and the command details will be displayed on the top right.
  ○	In the top right area the command should be filled in with data.
■	Change the “Key_?” to a key with a known action in your game. For example I use “Key_U” to deploy hard points. (Note do not enter the quote marks, and the Key_ is a necessary prefix for now, it is the Elite:Dangerous convention)
  ○	Click Start Button to start speech recognition.
  ○	Speak into your microphone the words “Hello World”. 
■	The system should respond with a voice stating “Yes Commander, Hello World”.
■	If you have Elite:Dangerous Running in the background switch to it enter a safe location for testing (training target practice works well) and say “Hello World”. It should deploy or retract the Hard Points and say, “Yes Commander, Hello World”
●	Define your own actions, click the + to add another command and edit the settings:
  ○	The Key setting is the key to be sent to the game.
  ○	The Key Time is how long before the key is released, it works with the Key Pressed and Key Released check boxes. 
■	If the Key Released is checked, then the Key Time determines how long the key is held down before being released and is in seconds - 0.5 is ½ second.
■	If the Key Released is NOT checked, then if the Key Time is greater than 0.0, the key will be automatically released anyway after the specified amount of time. 1.5 would mean 1 ½ seconds later the key would be automatically released.
■	If the Key Released is NOT checked and the Key Time is 0.0, the key will not be released until you execute another command that releases it.
■	For example, you could have a command that turns on Yaw Left and leaves it on, causing your ship to rotate continuously to the left.
●	Command = Yaw Left On 
●	Key is Key_A
●	Key Pressed is checked 
●	Key Time is 0.0 
●	Key Released is not checked.
■	Then have a Yaw Left Off command which would turn off the Yay Left (release the Key_A) and if Flight Assist is on, you will stop turning.
●	Command Yaw Left Off
●	Key is Key_A
●	Key Pressed is NOT checked
●	Key Time is 0.0 for no delay releasing, or 1.5 to wait an additional 1.5 seconds before releasing the key.
●	Key Released is Checked. 
●	Next up, try loading your default control bindings. This file is normally located in your Library folder. Along the bottom of the window is the path for my Custom.binds file. Yours WILL be different, at the least you need to change my name (frank) to your user name. Once the path points to your Custom.bands, click the Import button and it will load your control settings. 
  ○	If you don’t have a Custom.bands file, go into the game, into options, into controls, and select the Keyboard and Mouse. Change one setting, for example I change Reset Mouse to F9. 
  ○	Then save and exit the game. 
  ○	You now have a Custom.binds file based on the standard Keyboard and mouse settings with the only change being for Mouse Reset.
  ○	relaunch your game.
●	After loading the control settings file, click Start button and switch into your game. 
  ○	Speak the names of the settings - for example DeployHardPoints, or ShipSpotLight, etc. All should work - the computer will say, “Yes Commander, ShipSpotLight”, etc.. and the spot light should toggle on and off each time you speak the command. (Note: a quiet location is preferable for testing, my Air conditioner sounds like it is saying “Pause” to the Mac, and my dogs barking issue interesting commands).
○	On the Elite Copilot window below the command list is a pair of buttons labels Active and All, clicking the Active button will display only the controls/commands that have Key assignments, clicking the All button will display all commands in the Custom.binds file, even those without key assignments. 
○	You may select a command with no key assignment and assign a key to it to activate it. 
○	THIS DOES NOT MAKE THE ASSIGNMENT IN THE GAME, IT ONLY TELLS ELITE COPILOT TO SEND THAT KEY TO THE GAME WHEN YOU SPEAK THAT COMMAND. 
○	Either assign a key that will cause something to happen in the game, or go into your control settings in the game and make the change there also. If you make the change in the control settings and save the changes, then the next time you click either, Import, All, or Active buttons, the Custom.binds will be reloaded and reflect the changes you made in game.

●	Known Bugs
  ○	The bug is associated with sorting the command list by clicking the Column header over the Command Name column. This will sort the commands, but it then disables the Import, ALL and Active buttons until you relaunch the program.
  ○	A bug exists that causes the Command selected after speaking a command to change randomly. If you are looking at the command list and speaking commands, the list should change to select the command you just spoke, this works “sometimes”, but doesn’t work other times. It seems sorting the list helps it work. But it still fails randomly and selects the wrong Command, even though the correct command is recognized and send to the game.
