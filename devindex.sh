#! /usr/bin/env bash

# This file is meant to update the website by pulling any new info from the git repository


# ensureing SSH Connection
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519 


# Set the repository URL and branch name
repo_url="git@github.com:ttu-bburchfield/swollenhippofinal.git"
branch_name="dev"
local_directory="$HOME/html"

# make sure in home directory
cd

# Clone from repo with branch specification and final file path
git clone -b "$branch_name" "$repo_url" "$local_directory"

# Checking if html file exist
if [ -d "/var/www/html" ];
then
  # remove html file to be replaced with one from git
  sudo rm -r /var/www/html
fi

# move repo called html to filepath 
sudo mv  "$local_directory" "/var/www/"
