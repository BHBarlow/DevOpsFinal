#! /usr/bin/env bash 

# THIS FILE IS USED TO AUTOMATE THE PROCESS OF SETTING UP THE SERVER ENVIROMENT
# AND DEPLOYING THE WEB APPLICATION USING THE APPROPRIATE USER SPECIFIED ENVIROMENT
#   - Connects to web server 
#   - connects to webdev server
#   - "#" lines are comments 
#   - blank lines are ignored 
#   - uses ansible/git/cron to manage servers
#----------------------------------------------------------------------------------#

#                                CODE STARTS HERE

# Reading in user input
read -p "Hello which server would you like to push to(dev or test): " input


# Insureing all lowercase
useroption=$(echo "$input" | tr '[:upper:]' '[:lower:]')

# input validation 
while [ "$useroption" !=  "dev" ] && [ "$useroption" != "test" ];
do
  # Keeps asking till correct response is passed
  read -p "Invalid Option: Please choose "dev" or "test": " newinput
  
  # Insureing all lowercase
  useroption=$(echo "$newinput" | tr '[:upper:]' '[:lower:]')
done


# Checks if user input is equal to "test"
if [ "$useroption" == "test" ];
then

  # Finding correct file path needed to call ansible file no matter location on server
  webfilelocal=$(find ~ -type f -name "**webserver.yml")
    
  # Check if the file was found
  if [ -n "$webfilelocal" ]; then

    # calling ansible playbook
    ansible-playbook "$webfilelocal"

  else
      # Raises error if file not found
      echo "ERROR: File Not Found."
      exit 1
  fi
   
# Checks if user input is equal to "dev"
elif [ "$useroption" == "dev" ];
then

  # Finding correct file path needed to call ansible file no matter location on server
  devfilelocal=$(find ~ -type f -name "**webdevserver.yml")

  # Check if the file was found
  if [ -n "$devfilelocal" ]; then

    # calling ansible playbook
    ansible-playbook "$devfilelocal"

  else
      # Raises error if file not found
      echo "ERROR: File Not Found."
      exit 1
  fi
fi
