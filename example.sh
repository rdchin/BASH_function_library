#!/bin/bash
#
# ©2021 Copyright 2021 Robert D. Chin
# Email: RDevChin@Gmail.com
#
# Usage: bash example.sh
#        (not sh example.sh)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# +----------------------------------------+
# |        Default Variable Values         |
# +----------------------------------------+
#
VERSION="2021-02-23 19:46"
THIS_FILE="$0"
TEMP_FILE=$THIS_FILE"_temp.txt"
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
#
#
#================================================================
# EDIT THE LINES BELOW TO SET REPOSITORY SERVERS AND DIRECTORIES
# AND TO INCLUDE ALL DEPENDENT SCRIPTS AND LIBRARIES TO DOWNLOAD.
#================================================================
#
#
#-------------------------------------------------
# Set variables to check for network connectivity.
#-------------------------------------------------
#
# Ping Local File Server Repository
# PING_LAN_TARGET="[FILE SERVER NAME]"
PING_LAN_TARGET="scotty"
#
# Ping Web File Server Repository
# PING_WAN_TARGET="[WEB FILE REPOSITORY]"
PING_WAN_TARGET="raw.githubusercontent.com"
#
#--------------------------------------------------------------
# Set variables to mount the Local Repository to a mount-point.
#--------------------------------------------------------------
#
# LAN File Server shared directory.
SERVER_DIR="//scotty/files"
#
# Local PC mount-point directory.
MP_DIR="/mnt/scotty/files"
#
# Local PC target directory, sub-directory below mount-point directory.
# TARGET_DIR="[ LOCAL MOUNT-POINT DIRECTORY/REPOSITORY SUB-DIRECTORY PATH GOES HERE ]"
TARGET_DIR="/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"
#
#
#=================================================================
# EDIT THE LINES BELOW TO SPECIFY THE FILE NAMES TO UPDATE.
# FILE NAMES INCLUDE ALL DEPENDENT SCRIPTS LIBRARIES.
#=================================================================
#
#
# --------------------------------------------
# Create a list of all dependent library files
# and write to temporary file, FILE_LIST.
# --------------------------------------------
#
# Temporary file FILE_LIST contains a list of file names of dependent
# scripts and libraries.
# Format: [File Name]^[Local/
#
FILE_LIST=$THIS_FILE"_file_temp.txt"
#
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]
echo "$THIS_FILE^Local^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"           > $FILE_LIST
echo "example.lib^Local^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository" >> $FILE_LIST
echo "common_bash_function.lib^Web^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository^https://raw.githubusercontent.com/rdchin/BASH_function_library/master/" >> $FILE_LIST
#
# Create a list of files FILE_DL_LIST, which need to be downloaded.

# From FILE_LIST (list of script and library files), find the files which
# need to be downloaded and put those file names in FILE_DL_LIST.
#
FILE_DL_LIST=$THIS_FILE"_file_dl_temp.txt"
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
#& Brief Description
#&
#& Description goes here.
#& This is a example of a bare-bones script which uses
#& the library example.lib.
#& 
#& Required scripts: example.sh
#&                   example_module_main.lib
#&                   common_bash_function.lib
#&
#& Usage: bash example.sh
#&        (not sh example.sh)
#&
#&    This program is free software: you can redistribute it and/or modify
#&    it under the terms of the GNU General Public License as published by
#&    the Free Software Foundation, either version 3 of the License, or
#&    (at your option) any later version.
#&
#&
#&    This program is distributed in the hope that it will be useful,
#&    but WITHOUT ANY WARRANTY; without even the implied warranty of
#&    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#&    GNU General Public License for more details.
#&
#&    You should have received a copy of the GNU General Public License
#&    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# +----------------------------------------+
# |             Help and Usage             |
# +----------------------------------------+
#
#?    Usage: bash example.sh [OPTION(S)]
#?
#? Examples:
#?
#?                            Force display to use a different UI.
#? bash example.sh text       Use Cmd-line user-interface (80x24 min.)
#?                 dialog     Use Dialog   user-interface.
#?                 whiptail   Use Whiptail user-interface.
#?
#? bash example.sh --help     Displays this help message.
#?                 -?
#?
#? bash example.sh --about    Displays script version.
#?                 --version
#?                 --ver
#?                 -v
#?
#? bash example.sh --update   Update script.
#?                 -u
#?
#? bash example.sh --history  Displays script code history.
#?                 --hist
#?
#? Examples using 2 arguments:
#?
#? bash example.sh --hist text
#?                 --ver dialog
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Notes
##
## To disable the [ OPTION ] --update -u to update the script:
##    1) Comment out the call to function fdl_download_missing_scripts in
##       Section "Start of Main Program".
##
## To completely delete the [ OPTION ] --update -u to update the script:
##    1) Delete the call to function fdl_download_missing_scripts in
##       Section "Start of Main Program".
##    2) Delete all functions beginning with "f_dl"
##    3) Delete instructions to update script in Section "Help and Usage".
##
## To disable the Main Menu:
##    1) Comment out the call to function f_menu_main under "Run Main Code"
##       in Section "Start of Main Program".
##    2) Add calls to desired functions under "Run Main Code"
##       in Section "Start of Main Program".
##
## To completely remove the Main Menu and its code:
##    1) Delete the call to function f_menu_main under "Run Main Code" in
##       Section "Start of Main Program".
##    2) Add calls to desired functions under "Run Main Code"
##       in Section "Start of Main Program".
##    3) Delete the function f_menu_main.
##    4) Delete "Menu Choice Options" in example.lib located under
##       Section "Customize Menu choice options below".
##       The "Menu Choice Options" lines begin with "#@@".
##
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
##
## 2021-02-21 *Section "Code Change History" added instructions.
##
## 2021-02-19 *fdl_download_missing_scripts added to modulize existing code
##             under Section "Main Program" to allow easier deletion of code
##             the "Update Version" feature is not desired.
##            *Functions related to "Update Version" renamed with an "fdl"
##             prefix to identify dependent functions to delete if that
##             function is not desired.
##            *Section "Code Change History" added instructions on how to
##             disable/delete "Update Version" feature or "Main Menu".
##
## 2021-02-13 *Changed menu item wording from "Exit to command-line" prompt.
##                                         to "Exit this menu."
##
## 2021-02-11 *Updated to latest standards.
##
## 2021-02-07 *Updated to latest standards.
##
## 2021-01-30 *Section "Default Variable Values" moved variable
##             initializations from Main section into this section.
##            *Updated to latest standards.
##
## 2020-10-27 *Updated to latest standards.
##
## 2020-10-23 *f_arguments, "Help and Usage" added option --update -u.
##            *f_check_version updated to latest standards.
##
## 2020-10-22 *Main added functionality to download any dependent file or
##             library from this script.
##            *f_choose_dl_source, f_source added to optimize the enhanced
##             download functionality and to allow user a choice between
##             downloading file and library dependencies from a local
##             or a web repository.
##
## 2020-09-30 *Updated to latest standards.
##
## 2020-09-09 *Updated to latest standards.
##
## 2020-05-15 *Main added TEMP_FILE and more example code.
##
## 2020-04-22 *f_message split into several functions for clarity and
##             simplicity f_msg_(txt/ui)_(file/string)_(ok/nok).
##            *f_yn_question split off f_yn_defaults.
##
## 2020-04-19 *Found bug in VERSION setting in f_about, f_code_history,
##             f_help_message. Need to set $VERSION using correct $THIS_FILE.
##
## 2020-04-18 *Fixed bug affecting menu items "About", "Code History",
##             and "Help" where f_update menu_gui/txt did not substitute
##             the "^" <carot> for <space> in FUNC="f_<function>^$GUI".
##             So $1 was never set to $GUI when calling f_about,
##             f_code_history, and f_help_message.
##
## 2020-04-15 *Standardized code to latest implementations.
##            *f_message total rewrite to handle text file, strings with
##             or without embedded "/n" or "/Zn" commands.
##
## 2020-04-07 *Cosmetic formatting changes in if-then, case, statements
##             and comment lines.
##
## 2020-04-06 *f_arguments standardized.
##
## 2020-04-06 *Initial Release.
#
# +------------------------------------+
# |     Function f_display_common      |
# +------------------------------------+
#
#     Rev: 2021-02-08
#  Inputs: $1=GUI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Delimiter of text to be displayed.
#          $3="NOK", "OK", or null [OPTIONAL] to control display of "OK" button.
#          $4=Pause $4 seconds [OPTIONAL]. If "NOK" then pause to allow text to be read.
#          THIS_DIR, THIS_FILE, VERSION.
#    Uses: X.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
f_display_common () {
      #
      # Specify $THIS_FILE name of the file containing the text to be displayed.
      # $THIS_FILE may be re-defined inadvertently when a library file defines it
      # so when the command, source [ LIBRARY_FILE.lib ] is used, $THIS_FILE is
      # redefined to the name of the library file, LIBRARY_FILE.lib.
      # For that reason, all library files now have the line
      # THIS_FILE="[LIBRARY_FILE.lib]" deleted.
      #
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME WHERE THE
      # ABOUT, CODE HISTORY, AND HELP MESSAGE TEXT IS LOCATED.
      #================================================================================
      #
      #
                              #
      THIS_FILE="example.sh"  # <<<--- INSERT ACTUAL FILE NAME HERE.
                              #
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
      #
      # Set $VERSION according as it is set in the beginning of $THIS_FILE.
      X=$(grep --max-count=1 "VERSION" $THIS_FILE)
      # X="VERSION=YYYY-MM-DD HH:MM"
      # Use command "eval" to set $VERSION.
      eval $X
      #
      echo "Script: $THIS_FILE. Version: $VERSION" > $TEMP_FILE
      echo >>$TEMP_FILE
      #
      # Display text (all lines beginning ("^") with $2 but do not print $2).
      # sed substitutes null for $2 at the beginning of each line
      # so it is not printed.
      sed --silent "s/$2//p" $THIS_DIR/$THIS_FILE >> $TEMP_FILE
      #
      case $3 in
           "NOK" | "nok")
              f_message $1 "NOK" "Message" $TEMP_FILE $4
           ;;
           *)
              f_message $1 "OK" "(use arrow keys to scroll up/down/side-ways)" $TEMP_FILE
           ;;
      esac
      #
} # End of function f_display_common.
#
# +----------------------------------------+
# |             Function f_source          |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1=File name to source.
# Outputs: ANS.
#
f_source () {
      #
      if [ -x "$1" ] ; then
         # If $1 is a library, then source it.
         case $1 in
              common_bash_function.lib)
                 source $1
              ;;
              *.lib)
                 source $1
              ;;
         esac
      fi
      #
} # End of function f_source.
#
# +----------------------------------------+
# |          Function f_menu_main          |
# +----------------------------------------+
#
#     Rev: 2021-02-13
#  Inputs: $1=GUI.
#    Uses: ARRAY_FILE, GENERATED_FILE, MENU_TITLE.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO THE MAIN SCRIPT WHICH WILL CALL IT.
#
f_menu_main () { # Create and display the Main Menu.
      #
      #
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME WHERE THE
      # ABOUT, CODE HISTORY, AND HELP MESSAGE TEXT IS LOCATED.
      #================================================================================
      #
      #
                              #
      THIS_FILE="example.sh"  # <<<--- INSERT ACTUAL FILE NAME HERE.
                              #
      GENERATED_FILE=$THIS_DIR/$THIS_FILE"_menu_main_generated.lib"
      #
      # Does this file have menu items in the comment lines starting with "#@@"?
      grep --silent ^\#@@ $THIS_DIR/$THIS_FILE
      ERROR=$?
      # exit code 0 - menu items in this file.
      #           1 - no menu items in this file.
      #               file name of file containing menu items must be specified.
      if [ $ERROR -eq 0 ] ; then
         # Extract menu items from this file and insert them into the Generated file.
         # This is required because f_menu_arrays cannot read this file directly without
         # going into an infinite loop.
         grep ^\#@@ $THIS_DIR/$THIS_FILE >$GENERATED_FILE
         #
         # Specify file name with menu item data.
         ARRAY_FILE="$GENERATED_FILE"
      else
         #
         #
         #================================================================================
         # EDIT THE LINE BELOW TO DEFINE $ARRAY_FILE AS THE ACTUAL FILE NAME (LIBRARY)
         # WHERE THE MENU ITEM DATA IS LOCATED. THE LINES OF DATA ARE PREFIXED BY "#@@".
         #================================================================================
         #
         #
         # Specify library file name with menu item data.
         # ARRAY_FILE="[FILENAME_GOES_HERE]"
         ARRAY_FILE="$THIS_DIR/example.lib"
      fi
      #
      # Create arrays from data.
      f_menu_arrays $ARRAY_FILE
      #
      # Calculate longest line length to find maximum menu width
      # for Dialog or Whiptail using lengths calculated by f_menu_arrays.
      let MAX_LENGTH=$MAX_CHOICE_LENGTH+$MAX_SUMMARY_LENGTH
      #
      # Create generated menu script from array data.
      #
      # Note: ***If Menu title contains spaces,
      #       ***the size of the menu window will be too narrow.
      #
      # Menu title MUST use underscores instead of spaces.
      MENU_TITLE="CLI_Action_Menu"  # Menu title must substitute underscores for spaces
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_menu_main_temp.txt"
      #
      f_create_show_menu $1 $GENERATED_FILE $MENU_TITLE $MAX_LENGTH $MAX_LINES $MAX_CHOICE_LENGTH $TEMP_FILE
      #
      if [ -r $GENERATED_FILE ] ; then
         rm $GENERATED_FILE
      fi
      #
      if [ -r $TEMP_FILE ] ; then
         rm $TEMP_FILE
      fi
      #
} # End of function f_menu_main.
#
# +----------------------------------------+
# |      Function fdl_choose_dl_source     |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1="Web" or "Local".
#          $2=file to download.
# Outputs: ANS.
#
fdl_choose_dl_source () {
      #
      DL_FILE=$(echo $DL_LINE | awk -F "^" '{ print $1 }')
      DL_SOURCE=$(echo $DL_LINE | awk -F "^" '{ print $2 }')
      # Format [File name]^[Local/Web]
      DL_LINE=$(echo $DL_LINE | awk -F "^" '{ print $1"^"$2}')
      #
      fdl_choose_download_source $DL_SOURCE $DL_FILE
      # Insert ANS into FILE_DL_LIST.
      # Substitute DL_LINE_NEW for DL_LINE.
      # ANS [Local/Web] is the project's download choice for all project files.
      # ANS will over-write any existing value [Local/Web] for each project file.
      # Substitute ANS for existing value whether "Local" or "Web".
      DL_LINE_NEW=${DL_LINE/$DL_FILE^Local/$DL_FILE^$ANS}
      DL_LINE_NEW=${DL_LINE/$DL_FILE^Web/$DL_FILE^$ANS}
      #
      # Change or substitute new ANS or download choice into download file list.
      sed -i "s/$DL_LINE/$DL_LINE_NEW/" $FILE_DL_LIST
      #
} # End of function fdl_choose_dl_source.
#
# +----------------------------------------+
# |   Function fdl_choose_download_source  |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1="Web" or "Local".
#          $2=file to download.
# Outputs: ANS.
#
fdl_choose_download_source () {
      #
      # Is $1 specified or "local"?
      ANS=""
      if [ $1 != "Local" ] ; then
         while [ "$ANS" = "" ]
               do
                  echo
                  echo "Do you want to download the file: $2"
                  echo -n "from the web repository? (W)eb or the local repository (L)ocal ($1):" ; read ANS
                  case $ANS in
                       [Ww])
                          ANS="Web"
                       ;;
                       [Ll] | "")
                          ANS="Local"
                       ;;
                       *)
                          ANS="$1"
                       ;;
                  esac
               done
      else
         # If "Local" download source, do not give a choice, use Local Repository for download.
         ANS="Local"
      fi
      #
} # End of function fdl_choose_download_source.
#
# +----------------------------------------+
# |       fdl_dwnld_file_from_web_site     |
# +----------------------------------------+
#
#     Rev: 2021-02-23
#  Inputs: $1=GitHub Repository
#          $2=file name to download.
#    Uses: None.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
fdl_dwnld_file_from_web_site () {
      #
      # $1 ends with a slash "/" so can append $2 immediately after $1.
      wget --show-progress $1$2
      ERROR=$?
      if [ $ERROR -ne 0 ] ; then
            echo
            echo "!!! wget download failed !!!"
            echo "from GitHub.com for file: $2"
            echo
            echo "Cannot continue, exiting program script."
            sleep 3
            exit 1  # Exit with error.
      else
         # Make file executable (useable).
         chmod +x $2
         #
         if [ -x $2 ] ; then
            # File is good.
            ERROR=0
         else
            echo
            echo "File Error"
            echo -e "$2 is missing or file is not executable.\n\nCannot continue, exiting program script."
            sleep 2
            ERROR=1
         fi
      fi
      #
      # Make downloaded file executable.
      chmod 755 $2
      #
      echo
      echo ">>> Please run program again after download. <<<"
      echo
      # Delay to read messages on screen.
      echo -n "Press \"Enter\" key to continue" ; read X
      #
} # End of function fdl_dwnld_file_from_web_site.
#
# +------------------------------------------+
# |    fdl_dwnld_file_from_local_repository  |
# +------------------------------------------+
#
#     Rev: 2021-02-23
#  Inputs: $1=Local Repository Directory.
#          $2=File to download.
#    Uses: TEMP_FILE, SMBUSER, PASSWORD, ERROR.
# Outputs: TEMP_FILE.
#
# This is used to download any file with a text-only UI.
# This can be used to download the Common Function Library.
# Used to download any file before the Common Library is even downloaded.
#
fdl_dwnld_file_from_local_repository () {
      #
      eval cp -p $1/$2 .
      ERROR=$?
      #
      if [ $ERROR -ne 0 ] ; then
         echo
         echo -e "Error occurred\nError copying $2."
         sleep 2
         ERROR=1
      else
         # Make file executable (useable).
         chmod +x $2
         #
         if [ -x $2 ] ; then
            # File is good.
            ERROR=0
         else
            echo
            echo "File Error"
            echo -e "$2 is missing or file is not executable.\n\nCannot continue, exiting program script."
            sleep 3
            ERROR=1
         fi
      fi
      #
      if [ $ERROR -ne 0 ] ; then
         echo
         echo -e "Error occurred\nError copying $2."
      else
         echo
         echo -e "Successful Update of $2 to latest version.\n\nScript must be re-started to use the latest version."
         echo "____________________________________________________"
      fi
      #
} # End of function fdl_dwnld_file_from_local_repository.
#
# +------------------------------------------+
# |              fdl_mount_local             |
# +------------------------------------------+
#
#     Rev: 2021-01-30
#  Inputs: $1=Server Directory.
#          $2=Local Mount Point Directory
#          TEMP_FILE
#    Uses: TARGET_DIR, UPDATE_FILE, ERROR.
# Outputs: ERROR.
#
fdl_mount_local () {
      #
      # Mount local repository on mount-point.
      mountpoint $2 >/dev/null 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
      ERROR=$?
      if [ $ERROR -ne 0 ] ; then
         # Mount directory.
         echo
         read -p "Enter user name: " SMBUSER
         echo
         read -s -p "Enter Password: " PASSWORD
         echo
         sudo mount -t cifs -o username="$SMBUSER" -o password="$PASSWORD" $1 $2
         mountpoint $2 >/dev/null 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE. Get status of mountpoint, mounted?.
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            echo "Mount failure"
            echo
            echo "Directory mount-point $2 is not mounted."
            echo
            echo -e "Mount using Samba failed. Are \"samba\" and \"cifs-utils\" installed?"
            echo
            echo -e "Press \"Enter\" key to continue."
         fi
         unset SMBUSER PASSWORD
      fi
      #
} # End of function fdl_mount_local.
#
# +----------------------------------------+
# |  Function fdl_download_missing_scripts |
# +----------------------------------------+
#
#     Rev: 2021-02-23
#  Inputs: $1=File name to source.
# Outputs: ANS.
#
fdl_download_missing_scripts () {
      #
      #----------------------------------------------------------------
      # Variables FILE_LIST and FILE_DL_LIST are defined in the section
      # "Default Variable Values" at the beginning of this script.
      #----------------------------------------------------------------
      #
      # Delete any existing temp file.
      if [ -r  $FILE_DL_LIST ] ; then
         rm  $FILE_DL_LIST
      fi
      #
      # ****************************************************
      # Create new list of files that need to be downloaded.
      # ****************************************************
      #
      while read LINE
            do
               FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
               if [ ! -x $FILE ] ; then
                  # File needs to be downloaded or is not executable
                  chmod +x $FILE 2>$TEMP_FILE # Write any error messages to file $TEMP_FILE.
                  ERROR=$?
                  if [ $ERROR -ne 0 ] ; then
                     # File needs to be downloaded. Add file name to a file list in a text file.
                     # Build list of files to download.
                     echo $LINE >> $FILE_DL_LIST
                  fi
               fi
            done < $FILE_LIST
      #
      # If there are files to download (listed in FILE_DL_LIST), then mount local repository.
      if [ -s "$FILE_DL_LIST" ] ; then
         echo
         echo "There are missing file dependencies which must be downloaded from"
         echo "the local repository or web repository."
         echo
         echo "Missing files:"
         while read LINE
               do
                  echo $LINE | awk -F "^" '{ print $1 }'
               done < $FILE_DL_LIST
         echo
         echo "You will need to present credentials."
         echo
         echo -n "Press '"Enter"' key to continue." ; read X ; unset X
         #
         #----------------------------------------------------------------------------------------------
         # From list of files to download created above $FILE_DL_LIST, download the files one at a time.
         #----------------------------------------------------------------------------------------------
         #
         while read LINE
               do
                  # Get Download Source for each file.
                  DL_FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
                  DL_SOURCE=$(echo $LINE | awk -F "^" '{ print $2 }')
                  TARGET_DIR=$(echo $LINE | awk -F "^" '{ print $3 }')
                  DL_REPOSITORY=$(echo $LINE | awk -F "^" '{ print $4 }')
                  #
                  # Initialize Error Flag.
                  ERROR=0
                  #
                  # If a file only found in the Local Repository has source changed
                  # to "Web" because LAN connectivity has failed, then do not download.
                  if [ -z DL_REPOSITORY ] && [ $DL_SOURCE = "Web" ] ; then
                     ERROR=1
                  fi
                  #
                  case $DL_SOURCE in
                       Local)
                          # Download from Local Repository on LAN File Server.
                          # Are LAN File Server directories available on Local Mount-point?
                          fdl_mount_local $DL_REPOSITORY $TARGET_DIR
                          if [ $ERROR -ne 0 ] ; then
                             # Failed to mount File Server directory on Local Mount-point
                             # So download from Web Repository.
                             fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                          else
                             # Sucessful mount of File Server directory. 
                             fdl_dwnld_file_from_local_repository $TARGET_DIR $DL_FILE
                          fi
                       ;;
                       Web)
                          # Download from Web Repository.
                          fdl_dwnld_file_from_web_site $DL_REPOSITORY $DL_FILE
                          if [ $ERROR -ne 0 ] ; then
                             # Failed so download from Local Repository on LAN File Server.
                             fdl_mount_local $DL_REPOSITORY $TARGET_DIR
                             if [ $ERROR -ne 0 ] ; then
                                fdl_dwnld_file_from_local_repository $TARGET_DIR $DL_FILE
                             fi
                          fi
                       ;;
                  esac
                  #
               done < $FILE_DL_LIST
         #
         # Delete temporary files.
         if [ -e $TEMP_FILE ] ; then
            rm $TEMP_FILE
         fi
         #
         if [ -r  $FILE_LIST ] ; then
            rm  $FILE_LIST
         fi
         #
         if [ -r  $FILE_DL_LIST ] ; then
            rm  $FILE_DL_LIST
         fi
         #
         echo
         echo ">>> Please run program again after download. <<<"
         echo
         echo "Cannot continue, exiting program script."
         sleep 3
         exit 1  # Exit script after downloading dependent files and libraries.
         #
      fi
      #
      # Source each library.
      #
      while read LINE
            do
               FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
               # Invoke any library files.
               f_source $FILE
            done < $FILE_LIST
      #
} # End of function fdl_download_missing_scripts.
#
#
# **************************************
# **************************************
# ***     Start of Main Program      ***
# **************************************
# **************************************
#     Rev: 2021-02-21
#
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
clear  # Blank the screen.
#
echo "Running script $THIS_FILE"
echo "***   Rev. $VERSION   ***"
echo
sleep 1  # pause for 1 second automatically.
#
clear # Blank the screen.
#
#-------------------------------------------------------
# Detect and download any missing scripts and libraries.
#-------------------------------------------------------
fdl_download_missing_scripts
#
#***************************************************************
# Process Any Optional Arguments and Set Variables THIS_DIR, GUI
#***************************************************************
#
# Set THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
#
# Test for Optional Arguments.
# Also sets variable GUI.
f_arguments $1 $2
#
# If command already specifies GUI, then do not detect GUI.
# i.e. "bash example.sh dialog" or "bash example.sh text".
if [ -z $GUI ] ; then
   # Test for GUI (Whiptail or Dialog) or pure text environment.
   f_detect_ui
fi
#
# Final Check of Environment
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Delete temporary files.
if [ -r  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -r  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
# Test for X-Windows environment. Cannot run in CLI for LibreOffice.
# if [ x$DISPLAY = x ] ; then
#    f_message text "OK" "\Z1\ZbCannot run LibreOffice without an X-Windows environment.\ni.e. LibreOffice must run in a terminal emulator in an X-Window.\Zn"
# fi
#
# Test for BASH environment.
f_test_environment $1
#
# If an error occurs, the f_abort() function will be called.
# trap 'f_abort' 0
# set -e
#
#********************************
# Show Brief Description message.
#********************************
#
f_about $GUI "NOK" 1
#
#***************
# Run Main Code.
#***************
#
f_menu_main $GUI
#
# Delete temporary files.
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
if [ -e  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -e  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
# Nicer ending especially if you chose custom colors for this script.
# Blank the screen.
clear
#
exit 0  # This cleanly closes the process generated by #!bin/bash.
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
        #
# All dun dun noodles.
