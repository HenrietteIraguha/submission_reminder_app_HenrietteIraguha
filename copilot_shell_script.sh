#!/bin/bash

main_dir="submission_reminder_*/"
start_script="startup.sh"
config="./submission_reminder_*/config/config.env"
assignment_name=""  # Initialize the variable to hold the user's input

copilot_function() {
    # The assignment name is passed as the first argument
    assignment="$1"

    if [ ! -d $main_dir ]; then
        sleep 1
        echo "The directory doesn't exist. Please run the file create_environment.sh"
        echo " "
        exit 1
    else
        sed -i "s/ASSIGNMENT=\".*\"/ASSIGNMENT=\"$assignment_name\"/" $config

        echo "Processing '$assignment' assignment"

        cd $main_dir || exit 1
        if [ ! -f $start_script ]; then
            echo "Error: $start_script not found."
            exit 1
        else
            ./$start_script
            cd .. || exit 1
        fi
    fi
}

echo " "
echo "Which assignment do you want to check?"

# Read the assignment name directly into assignment_name
read -p "Enter the assignment name: " assignment_name

# Call the function, passing the name the user typed
copilot_function "$assignment_name"

echo ""
echo "Excellent"
