#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

# Specify the desired Arkenfox version
set ARKENFOX_VERSION "128.0"

# Determine the operating system (macOS or Linux)
switch (uname -s)
case "Darwin"
    set profile_base_dir "$HOME/Library/Application Support/Firefox/Profiles"
    set find_command 'find $profile_base_dir -maxdepth 1 -type d -name "*.dev-edition-default"'
case "*inux"
    set profile_base_dir "$HOME/snap/firefox/common/.mozilla/firefox/"
    set find_command 'find $profile_base_dir -maxdepth 1 -type d -name "*.default"'
case '*'
    echo "Unsupported operating system."
    exit 0
end

# Find the Firefox profile folder
set profile_folder (eval $find_command | head -n 1)

if test -z "$profile_folder"
    echo "Firefox profile folder not found. Make sure Firefox is installed and has a default profile."
    exit 0
end

# GitHub release URL for the Arkenfox user.js
set release_url "https://github.com/arkenfox/user.js/archive/refs/tags/$ARKENFOX_VERSION.tar.gz"

# Create a temporary directory for downloading and extracting the release files
set temp_dir (mktemp -d)

# Download and extract the release files
curl -sLo $temp_dir/arkenfox-user.js.tar.gz "$release_url"

if test $status -ne 0
    echo "Failed to download the Arkenfox user.js release."
    rmdir $temp_dir
    exit 1
end

tar -xzf $temp_dir/arkenfox-user.js.tar.gz -C $temp_dir >/dev/null

# Copy the user.js, prefsCleaner.sh, and updater.sh files to the Firefox profile folder
cp $temp_dir/user.js-$ARKENFOX_VERSION/{user.js,prefsCleaner.sh,updater.sh} $profile_folder/

ln -sf $DOTFILES_ROOT/firefox/user-overrides.js $profile_folder/user-overrides.js

# Run updater.sh to append overrides to user.js
bash $profile_folder/updater.sh -s >/dev/null

# run prefsCleaner.sh
bash $profile_folder/updater.sh -s >/dev/null

# Clean up the temporary directory
rm -r $temp_dir



