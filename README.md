This app helps you identify students who have pending submissions on a specific assignment.

To use it, first run create_environment.sh and enter your name when prompted. This creates a directory like submission_reminder_yourname with all necessary files.

Next, move into the directory and run ./startup.sh. The app will show a list of students who have not submitted the current assignment, based on the settings in the configuration file.

To check a different assignment, run ./copilot_shell_script.sh from inside your app folder, enter the new assignment name, and the app will update and re-run automatically.

Always run the app from within your submission_reminder_yourname directory to ensure all files are found correctly.
