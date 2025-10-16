#!/bin/bash

# Prompt for the user's name
read -p "Enter your name: " name

# Main directory for the application
main_dir="submission_reminder_$name"

# Create main directory structure
mkdir -p "$main_dir/app" "$main_dir/modules" "$main_dir/assets" "$main_dir/config"

# Create required files
touch "$main_dir/app/reminder.sh"
touch "$main_dir/modules/functions.sh"
touch "$main_dir/assets/submissions.txt"
touch "$main_dir/config/config.env"
touch "$main_dir/startup.sh"

#reminder.sh 
cat > "$main_dir/app/reminder.sh" <<'REMINDER'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file (fixed path handling)
submissions_file="$(dirname "$0")/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
REMINDER

#functions.sh 
cat > "$main_dir/modules/functions.sh" <<'FUNCTION'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
FUNCTION

#submissions.txt
cat > "$main_dir/assets/submissions.txt" <<'SUBMISSION'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Clarke, Shell Navigation, submitted
Marjorie, Git, not submitted
Roscoe, Shell basics, not submitted
Ross, shell Navigation, submitted
Phoebe, Git, not submitted
Diane, Git, not submitted
Jean, Git, submitted
Clarke, Shell Navigation, submitted
Marjorie, Git, not submitted
Roscoe, Shell basics, not submitted
Ross, shell Navigation, submitted
Phoebe, Git, not submitted
Rachel, Shell Navigation, not submitted
SUBMISSION

#config.env 
cat > "$main_dir/config/config.env" <<'CONFIG'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
CONFIG

# startup.sh 
cat > "$main_dir/startup.sh" <<'STARTUP'
#!/bin/bash

#absolute path of this script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to reminder.sh
reminder_script="$script_dir/app/reminder.sh"

# Check if config file exists
if [ ! -f "$script_dir/config/config.env" ]; then
    echo "Error: config.env not found. Please run this script from inside $script_dir"
    exit 1
fi

# Launch the reminder app
bash "$reminder_script"
STARTUP

#Permissions 
chmod +x "$main_dir/app/"*.sh
chmod +x "$main_dir/modules/"*.sh
chmod +x "$main_dir/startup.sh"

# Completion Message 
echo
echo "Environment for submission reminder app created successfully ✅"
echo "To start the app, run the following commands:"
echo "------------------------------------------------"
echo "cd $main_dir"
echo "./startup.sh"
echo "------------------------------------------------"

# Display created structure (if tree is available)
tree "$main_dir" || ls -R "$main_dir"
