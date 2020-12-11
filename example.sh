#!/bin/bash
#
# ©2020 Copyright 2020 Robert D. Chin
#
# Usage: bash example.sh
#        (not sh example.sh)
#
# +----------------------------------------+
# |        Default Variable Values         |
# +----------------------------------------+
#
VERSION="2020-12-11 00:14"
THIS_FILE="example.sh"
TEMP_FILE=$THIS_FILE"_temp.txt"
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
#
#================================================================
# EDIT THE LINES BELOW TO SET REPOSITORY SERVERS AND DIRECTORIES
# AND TO INCLUDE ALL DEPENDENT SCRIPTS AND LIBRARIES TO DOWNLOAD.
#================================================================
#
# Set variables to check for network connectivity.
#
# Ping Local File Server Repository
PING_LAN_TARGET="[FILE SERVER NAME]"
PING_LAN_TARGET="scotty"
#
# Ping Web File Server Repository
PING_WAN_TARGET="[WEB FILE REPOSITORY]"
PING_WAN_TARGET="raw.githubusercontent.com"
#
# Set variables to mount the Local Repository to a mount-point.
#
# Local File Server Directory.
# LAN File Server shared directory.
SERVER_DIR="[ FILE SERVER DIRECTORY NAME GOES HERE ]"
SERVER_DIR="//scotty/files"
#
# Local Client PC Mount-Point Directory.
MP_DIR="[ LOCAL MOUNT-POINT DIRECTORY NAME GOES HERE ]"
MP_DIR="/mnt/scotty/files"
#
# Local PC target directory, sub-directory below mount-point directory.
TARGET_DIR="[ LOCAL MOUNT-POINT DIRECTORY/REPOSITORY SUB-DIRECTORY PATH GOES HERE ]"
TARGET_DIR="/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"
#
# Local PC file name to compare.
# FILE_TO_COMPARE="[ LOCAL FILE NAME ]"
FILE_TO_COMPARE=$THIS_FILE
#
# Each file script contains the string "VERSION=[ YYYY-MM-DD HH:MM ]"
# i.e. VERSION="2020-12-31 23:59"
#
# Version of TARGET_FILE.
# Format: YYYY-MM-DD_HH:MM string.
VERSION_TO_COMPARE=$(echo $VERSION | tr ' ' '_')
#
FILE_LIST=$THIS_FILE"_file_temp.txt"
#
# Format: [File Name]^[Local/Web]^[Local repository directory]^[web repository directory]
echo "$THIS_FILE^Local^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository"           > $FILE_LIST
echo "example_library.lib^Local^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository" >> $FILE_LIST
echo "common_bash_function.lib^Web^/mnt/scotty/files/LIBRARY/PC-stuff/PC-software/BASH_Scripting_Projects/Repository^https://raw.githubusercontent.com/rdchin/BASH_function_library/master/" >> $FILE_LIST
#
ERROR=0
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
#& Brief Description
#&
#& Description goes here.
#& This is a example of a bare-bones script which uses
#& the library example_library.lib.
#& 
#& Required scripts: first.sh, second.sh, third.sh,
#&                   example_module_main.lib
#&
#& Usage: bash example.sh
#&        (not sh example.sh)
#
# +----------------------------------------+
# |             Help and Usage             |
# +----------------------------------------+
#
#?    Usage: bash example.sh [OPTION(S)]
#? Examples:
#?
#? bash example.sh text       # Use Cmd-line user-interface (80x24 min.).
#?                 dialog     # Use Dialog   user-interface.
#?                 whiptail   # Use Whiptail user-interface.
#?
#? bash example.sh --help     # Displays this help message.
#?                 -?
#?
#? bash example.sh --about    # Displays script version.
#?                 --version
#?                 --ver
#?                 -v
#?
#? bash example.sh --update   # Update script.
#?                 -u
#?
#? bash example.sh --history  # Displays script code history.
#?                 --hist
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
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
#     Rev: 2020-08-07
#  Inputs: $1=GUI - "text", "dialog" or "whiptail" the preferred user-interface.
#          $2=Delimiter of text to be displayed.
#          $3="NOK", "OK", or null [OPTIONAL] to control display of "OK" button.
#          $4=Pause $4 seconds [OPTIONAL]. If "NOK" then pause to allow text to be read.
#          THIS_DIR, THIS_FILE, VERSION_TO_COMPARE.
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
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME WHERE THE 
      # ABOUT, CODE HISTORY, AND HELP MESSAGE TEXT IS LOCATED.
      #================================================================================
                              #
      THIS_FILE="example.sh"  # <<<--- INSERT ACTUAL FILE NAME HERE.
                              #
      TEMP_FILE=$THIS_FILE"_temp.txt"
      #
      # Set $VERSION according as it is set in the beginning of $THIS_FILE.
      # X="VERSION=YYYY-MM-DD HH:MM"
      # Use command "eval" to set $VERSION.
      #
      echo -n "Script: $THIS_FILE. Version: " > $TEMP_FILE
      echo $VERSION_TO_COMPARE | tr '_' ' ' >> $TEMP_FILE
      echo >>$TEMP_FILE
      #
      # Display text (all lines beginning ("^") with $2 but do not print $2).
      # sed substitutes null for $2 at the beginning of each line
      # so it is not printed.
      sed --silent "s/$2//p" $THIS_FILE >> $TEMP_FILE
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
# |          Function f_menu_main          |
# +----------------------------------------+
#
#     Rev: 2020-09-18
#  Inputs: $1=GUI.
#    Uses: ARRAY_FILE, GENERATED_FILE, MENU_TITLE.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO THE MAIN SCRIPT WHICH WILL CALL IT.
#
f_menu_main () { # Create and display the Main Menu.
      #
      THIS_FILE="example.sh"
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
         #================================================================================
         # EDIT THE LINE BELOW TO DEFINE $ARRAY_FILE AS THE ACTUAL FILE NAME (LIBRARY)
         # WHERE THE MENU ITEM DATA IS LOCATED. THE LINES OF DATA ARE PREFIXED BY "#@@".
         #================================================================================
         #
         # Specify library file name with menu item data.
         ARRAY_FILE="example_library.lib"
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
# |       Function f_choose_dl_source      |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1="Web" or "Local".
#          $2=file to download.
# Outputs: ANS.
#
f_choose_dl_source () {
      #
      DL_FILE=$(echo $DL_LINE | awk -F "^" '{ print $1 }')
      DL_SOURCE=$(echo $DL_LINE | awk -F "^" '{ print $2 }')
      # Format [File name]^[Local/Web]
      DL_LINE=$(echo $DL_LINE | awk -F "^" '{ print $1"^"$2}')
      #
      f_choose_download_source $DL_SOURCE $DL_FILE
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
} # End of function f_choose_dl_source.
#
# +----------------------------------------+
# |    Function f_choose_download_source   |
# +----------------------------------------+
#
#     Rev: 2020-10-22
#  Inputs: $1="Web" or "Local".
#          $2=file to download.
# Outputs: ANS.
#
f_choose_download_source () {
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
} # End of function f_choose_download_source.
#
# +----------------------------------------+
# |      f_dwnld_library_from_web_site     |
# +----------------------------------------+
#
#     Rev: 2020-10-06
#  Inputs: $1=GitHub Repository
#          $2=file name to download.
#          $3=ERROR.
#    Uses: None.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
f_dwnld_library_from_web_site () {
      #
      ERROR=$3
      #
      if [ $ERROR -eq 0 ] ; then
         # $1 ends with a slash "/" so can append $2 immediately after $1.
         wget --show-progress $1$2
         ERROR=$?
         if [ $ERROR -ne 0 ] ; then
            echo
            echo "!!! wget download failed !!!"
            echo "from GitHub.com for file: $2"
            echo
         fi
         #
         # Make downloaded file executable.
         chmod 755 $2
         #
      fi
      #
} # End of function f_dwnld_library_from_web_site.
#
# +------------------------------------------+
# |   f_dwnld_library_from_local_repository  |
# +------------------------------------------+
#
#     Rev: 2020-10-06
#  Inputs: $1=Local Repository Directory.
#          $2=File to download.
#          $3=ERROR.
#    Uses: TEMP_FILE, SMBUSER, PASSWORD, ERROR.
# Outputs: TEMP_FILE.
#
# This is used to download any file with a text-only UI. 
# This can be used to download the Common Function Library.
# Used to download any file before the Common Library is even downloaded. 
#
f_dwnld_library_from_local_repository () {
      #
      if [ $ERROR -eq 0 ] ; then
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
      fi
      #
      if [ $ERROR -ne 0 ] ; then
         echo
         echo -e "Error occurred\nError copying $2."
      else
         echo
         echo -e "Successful Update of $2.\n\nLatest version was successfully copied for use.\nScript must be re-started to use the latest version."
         echo "____________________________________________________"
      fi
      #
} # End of function f_dwnld_library_from_local_repository.
#
# +------------------------------------------+
# |               f_mount_local              |
# +------------------------------------------+
#
#     Rev: 2020-10-10
#  Inputs: $1=Server Directory.
#          $2=Local Mount Point Directory
#          TEMP_FILE
#    Uses: TARGET_DIR, UPDATE_FILE, ERROR.
# Outputs: ERROR.
#
f_mount_local () {
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
         unset SMBUSER PASSWORD
      fi
      #
} # End of function f_mount_local.
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
# **************************************
# **************************************
# ***     Start of Main Program      ***
# **************************************
# **************************************
#     Rev: 2020-10-23
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
#clear  # Blank the screen.
#
echo "Running script $THIS_FILE"
echo "***   Rev. $VERSION   ***"
echo
sleep 5  # pause for 1 second automatically.
#
clear # Blank the screen.
#
# Create list of dependent library files to download and write to temporary file, FILE_DL_LIST.
FILE_DL_LIST=$THIS_FILE"_file_dl_temp.txt"
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
# From FILE_LIST (list of script and library files), find the files which are missing and need to be downloaded.
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
# If there are files to download, then mount local repository.
if [ -s "$FILE_DL_LIST" ] ; then
   #
   # **************************************************
   # Select Download Source of Common Function Library.
   # **************************************************
   #
   #----------------------------------------
   # Get the download source of the Library.
   #----------------------------------------
   #
   DL_LINE=$(grep common_bash_function.lib $FILE_DL_LIST)
   #
   # If Library is in the download file list, then choose download source.
   if [ -n "$DL_LINE" ] ; then
      f_choose_dl_source $DL_LINE
   fi
   #
   # **************************************************
   # Select Download Source of Dependent Project Files.
   # **************************************************
   # Set download source for all dependent files/libraries using the same source
   # used by this file ($THIS_FILE).
   #
   #------------------------------------------
   # Get the download source for this project.  
   #------------------------------------------
   # Grep $FILE_LIST not $FILE_DL_LIST to get the download source for this project.
   #
   DL_LINE=$(grep $THIS_FILE $FILE_LIST)
   #
   # If this file ($THIS_FILE) is in the download file list, then choose download source.
   if [ -n "$DL_LINE" ] ; then
      f_choose_dl_source $DL_LINE
   fi
   #
   #-----------------------------------------------------------------------
   # Set the download source for all the dependent files to the same source
   # used by this file ($THIS_FILE).
   #-----------------------------------------------------------------------
   # Change or substitute the new download choice for each project file
   # in the download file list.
   #
   # Get download choice for this project and save as DL_SOURCE.
   DL_LINE=$(grep $THIS_FILE $FILE_LIST)
   #
   while read LINE
         do
            DL_FILE=$(echo $LINE | awk -F "^" '{ print $1 }')
            DL_SOURCE=$(echo $DL_LINE | awk -F "^" '{ print $2 }')
            # Format [File name]^[Local/Web]
            DL_LINE=$(echo $LINE | awk -F "^" '{ print $1"^"$2}')
            # All other files, substitute DL_LINE_NEW for LINE.
            # DL_SOURCE [Local/Web] is the project's download choice for all project files.
            # DL_SOURCE will over-write any existing value [Local/Web] for each project file.
            # Substitute DL_SOURCE for existing value whether "Local" or "Web".
            DL_LINE_NEW=${DL_LINE/$DL_FILE^Local/$DL_FILE^$DL_SOURCE}
            DL_LINE_NEW=${DL_LINE/$DL_FILE^Web/$DL_FILE^$DL_SOURCE}
            sed -i "s/$DL_LINE/$DL_LINE_NEW/" $FILE_DL_LIST
         done < $FILE_DL_LIST
   #
   #--------------------------------------------------------------------------------------
   # Check if there is a LAN (Local network) connection before mounting local mount-point.
   #--------------------------------------------------------------------------------------
   #
   # Initialize Error Flag.
   ERROR_LAN=0
   #
   grep --silent "Local" $FILE_DL_LIST
   ERROR=$?
   # exit code 0 - menu items in this file.
   #           1 - no menu items in this file.
   #               file name of file containing menu items must be specified.
   #
   if [ $ERROR -eq 0 ] ; then
      #
      # Check if there is an LAN connection before doing a download.
      ping -c 1 -q $PING_LAN_TARGET >/dev/null # Ping server address.
      ERROR=$?
      #
      if [ $ERROR -ne 0 ] ; then
         echo -e "\n\nPing Test Network Connection\n\nNo network connection to local file server." 
         ERROR_LAN=1
      else
         echo -e "\n\nPing Test Network Connection\n\nNetwork connnection to local file server is good."
         ERROR_LAN=0
         #
         #-------------------------------------------------
         # LAN connection is OK so mount local mount-point.
         #-------------------------------------------------
         #
         # Mount the Local Repository to the mount-point.
         f_mount_local $SERVER_DIR $MP_DIR
         #
      fi
   fi
   #
   #------------------------------------------------------------------
   # Check if there is a WAN (Web) connection before doing a download.
   #------------------------------------------------------------------
   #
   # Initialize Error Flag.
   ERROR_WAN=0
   #
   grep --silent "Web" $FILE_DL_LIST
   ERROR=$?
   # exit code 0 - menu items in this file.
   #           1 - no menu items in this file.
   #               file name of file containing menu items must be specified.
   if [ $ERROR -eq 0 ] ; then
      #
      # Check if there is an LAN connection before doing a download.
      ping -c 1 -q $PING_WAN_TARGET >/dev/null # Ping server address.
      ERROR=$?
      #
      if [ $ERROR -ne 0 ] ; then
         echo -e "\n\nPing Test Network Connection\n\nNo network connection to Web server." 
         ERROR_WAN=1
      else
         echo -e "\n\nPing Test Network Connection\n\nNetwork connnection to Web server is good."
         ERROR_WAN=0
      fi
   fi
   #
   #----------------------------------------------------------------------------------------
   # Select alternative download source if no network connection to primary download source.
   #----------------------------------------------------------------------------------------
   #
   # If Local connection failed, switch to Web file server download.
   if [ $ERROR_LAN -eq 1 ] ; then
      # Format [File name]^[Local/Web]
      sed -i "s/^Local^/^Web^/" $FILE_DL_LIST
   fi
   #
   # If Web connection failed, switch to Local file server download.
   if [ $ERROR_WAN -eq 1 ] ; then
      # Format [File name]^[Local/Web]
      sed -i "s/^Web^/^Local^/" $FILE_DL_LIST
   fi
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
                    f_dwnld_library_from_local_repository $TARGET_DIR $DL_FILE $ERROR
                 ;;
                 Web)
                    f_dwnld_library_from_web_site $DL_REPOSITORY $DL_FILE $ERROR
                 ;;
            esac
            #
         done < $FILE_DL_LIST
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
#***************************************************************
# Process Any Optional Arguments and Set Variables THIS_DIR, GUI
#***************************************************************
#
# Set THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_FILE"_temp.txt"
#
# Test for Optional Arguments.
f_arguments $1 $2 # Also sets variable GUI.
#
# If command already specifies GUI, then do not detect GUI i.e. "bash men.sh dialog" or "bash men.sh text".
if [ -z $GUI ] ; then
   # Test for GUI (Whiptail or Dialog) or pure text environment.
   f_detect_ui
fi
#
# If an error occurs, the f_abort() function will be called.
# trap 'f_abort' 0
# set -e
#
#********************************
# Show Brief Description message.
#********************************
f_about $GUI "NOK" 1
#
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Test for BASH environment.
f_test_environment
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
if [ -r  $FILE_LIST ] ; then
   rm  $FILE_LIST
fi
#
if [ -r  $FILE_DL_LIST ] ; then
   rm  $FILE_DL_LIST
fi
#
exit 0  # This cleanly closes the process generated by #!bin/bash. 
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
# All dun dun noodles.
