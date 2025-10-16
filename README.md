his app helps you identify students who haven’t submitted a specific assignment.

To use it, first run create_environment.sh and enter your name when prompted. This creates a folder like submission_reminder_yourname with all necessary files.

Next, go into that folder and run ./startup.sh. The app will show a list of students who have not submitted the current assignment, based on the settings in the configuration file.

To check a different assignment, run ../copilot_shell_script.sh from inside your app folder, enter the new assignment name, and the app will update and re-run automatically.

Always run the app from within your submission_reminder_yourname directory to ensure all files are found correctly.
