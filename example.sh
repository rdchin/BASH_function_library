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
VERSION="2020-08-08 07:50"
THIS_FILE="example_template.sh"
TEMP_FILE=$THIS_FILE"_temp.txt"
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
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
#?    Usage: bash example.sh [OPTION]
#? Examples:
#?
#?bash example.sh text       # Use Cmd-line user-interface (80x24 min.).
#?                dialog     # Use Dialog   user-interface.
#?                whiptail   # Use Whiptail user-interface.
#?
#?bash example.sh --help     # Displays this help message.
#?                -?
#?
#?bash example.sh --about    # Displays script version.
#?                --version
#?                --ver
#?                -v
#?
#?bash example.sh --history  # Displays script code history.
#?                --hist
#?
#? Examples using 2 arguments:
#?
#?bash example.sh --hist text
#?                --ver dialog
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
##
## 2020-08-08 *Updated to latest standards.
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
      #================================================================================
      # EDIT THE LINE BELOW TO DEFINE $THIS_FILE AS THE ACTUAL FILE NAME WHERE THE 
      # ABOUT, CODE HISTORY, AND HELP MESSAGE TEXT IS LOCATED.
      #================================================================================
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
      sed -n "s/$2//"p $THIS_DIR/$THIS_FILE >> $TEMP_FILE
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
#     Rev: 2020-07-01
#  Inputs: None.
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
      MENU_TITLE="Main_Menu"  # Menu title must substitute underscores for spaces
      TEMP_FILE=$THIS_DIR/$THIS_FILE"_menu_main_temp.txt"
      #
      f_create_show_menu $GUI $GENERATED_FILE $MENU_TITLE $MAX_LENGTH $MAX_LINES $MAX_CHOICE_LENGTH $TEMP_FILE
      #
      if [ -r $GENERATED_FILE ] ; then
         rm $GENERATED_FILE
      fi
      #
} # End of function f_menu_main.
#
# +----------------------------------------+
# |           Function f_do_stuff          |
# +----------------------------------------+
#
#     Rev: 2020-05-23
#  Inputs: None
#    Uses: TEMP_FILE.
# Outputs: None.
#
f_do_stuff () {
      # man dialog --colors
      # Interpret embedded "\Z" sequences in the Dialog text by the following
      # character, which tells Dialog to set colors or video attributes:
      # •   0 through 7 are the ANSI color numbers used in curses: black, red, green,
      #     yellow, blue, magenta, cyan and white respectively.
      # •   Bold is set by 'b', reset by 'B'.
      # •   Reverse is set by 'r', reset by 'R'.
      # •   Underline is set by 'u', reset by 'U'.
      # •   The settings are cumulative, e.g., "\Zb\Z1" makes the following text bold
      #     (perhaps bright) red.
      # •   Restore normal settings with "\Zn".
      #
      # BASH commands to change the color of characters in a terminal.
      # bold    "$(tput bold)"
      # black   "$(tput setaf 0)"
      # red     "$(tput setaf 1)"
      # green   "$(tput setaf 2)"
      # yellow  "$(tput setaf 3)"
      # blue    "$(tput setaf 4)"
      # magenta "$(tput setaf 5)"
      # cyan    "$(tput setaf 6)"
      # white   "$(tput setaf 7)"
      # reset   "$(tput sgr0)"
      #
TEMP_FILE=$THIS_FILE"_temp.txt"
f_message $GUI "NOK" "0. Start tests" "Starting tests now..."
# Test 1
f_message $GUI "OK" "1. String in quotes, expect msgbox-ok" "This is a test of a \Z6software BASH script.\Zn\nI hope it works!"
#
# Test 2
echo "This is the Captain speaking, \"All hands stand-down from Red Alert.\"" >$TEMP_FILE
echo "Stand-by to receive guests..." >>$TEMP_FILE
f_message $GUI "OK" "2. Text file, Expect textbox-ok" $TEMP_FILE
#
# Test 3
echo "This is the Captain speaking, \"All hands stand-by for shore leave.\"" >$TEMP_FILE
echo "Stand-by main martinis..." >>$TEMP_FILE
f_message $GUI "NOK" "3. Text file, Expect textbox-nok" $TEMP_FILE
#
# Test 4 - The quotes around "$STRING" are required.
STRING=$(echo "This is the Captain speaking, \"All hands to \Z1\ZbRED Alert!\Zn This is not a drill!\"")
f_message $GUI "OK" "4. String in var, expect msgbox-ok" "$STRING"
#
# Test 5
f_message $GUI "OK" "5. String in quotes, expect msgbox-ok" "This is the Captain speaking, \"All hands to \Z1\ZbRED Alert!\Zn This is not a drill!\""
#
# Test 6
STRING=$(echo "This is the Captain speaking, \"All hands to \Z4\ZbCode Blue!\Zn This is not a drill!\"")
f_message $GUI "NOK" "6. String in var, expect infobox-nok" "$STRING"
#
# Test 7
f_message $GUI "NOK" "7. String in quotes, expect infobox-nok" "This is the Captain speaking, \"All hands to \Z5\ZbCode Magenta!\Zn This is not a drill!\""
#
} # End of function f_do_stuff.
#
# +----------------------------------------+
# |          f_download_library            |
# +----------------------------------------+
#
#     Rev: 2020-06-23
#  Inputs: $1=GitHub Repository
#          $2=file name to download.
#    Uses: ARRAY_FILE, GENERATED_FILE, MENU_TITLE.
# Outputs: None.
#
# PLEASE NOTE: RENAME THIS FUNCTION WITHOUT SUFFIX "_TEMPLATE" AND COPY
#              THIS FUNCTION INTO ANY SCRIPT WHICH DEPENDS ON THE
#              LIBRARY FILE "common_bash_function.lib".
#
f_download_library () { # Create and display the Main Menu.
      #
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
      exit 0
      #
} # End of function f_download_library.
#
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
#     Rev: 2020-07-01
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
# Invoke common BASH function library.
FILE_DEPENDENCY="common_bash_function.lib"
if [ -x "$FILE_DEPENDENCY" ] ; then
   source $FILE_DEPENDENCY
else
   echo "File Error"
   echo
   echo "Error with required file:"
   echo "\"$FILE_DEPENDENCY\""
   echo
   echo "File is missing or file is not executable."
   echo
   echo "Do you want to download the file: $FILE_DEPENDENCY"
   echo -n "from GitHub.com? (Y/n): " ; read ANS
   case $ANS in
        "" | [Yy] | [Yy][Ee] | [Yy][Ee][Ss] )
           f_download_library "https://raw.githubusercontent.com/rdchin/BASH_function_library/master/" "common_bash_function.lib"
           ;;
        *)
           echo
           echo "Cannot continue, exiting program script."
           echo "Error with required file:"
           echo "\"$FILE_DEPENDENCY\""
           sleep 3
           exit 1  # Exit with error.
           ;;
   esac
   #
fi
#
# Invoke libraries required for this script.
 for FILE_DEPENDENCY in example_library.lib  # LIBRARY1.lib LIBRARY2.lib LIBRARY3.lib
    do
       if [ ! -x "$FILE_DEPENDENCY" ] ; then
          f_message "text" "OK" "File Error"  "Error with required file:\n\"$FILE_DEPENDENCY\"\n\n\Z1\ZbFile is missing or file is not executable.\n\n\ZnCannot continue, exiting program script." 3
          echo
          f_abort text
       else
          source "$FILE_DEPENDENCY"
       fi
    done
#
# # Test for files required for this script.
# for FILE_DEPENDENCY in FILE1 FILE2 FILE3
#     do
#        if [ ! -x "$FILE_DEPENDENCY" ] ; then
#           f_message "text" "OK" "File Error"  "Error with required file:\n\"$FILE_DEPENDENCY\"\n\n\Z1\ZbFile is missing or file is not executable.\n\n\ZnCannot continue, exiting program script." 3
#           echo
#           f_abort text
#        fi
#     done
# #
# # If an error occurs, the f_abort() function will be called.
# # trap 'f_abort' 0
# # set -e
# #
# Set THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
#
# Set default TARGET DIRECTORY.
TARGET_DIR=$THIS_DIR
#
# Test for Optional Arguments.
f_arguments $1 $2 # Also sets variable GUI.
#
# If command already specifies GUI, then do not detect GUI i.e. "bash dropfsd.sh dialog" or "bash dropfsd.sh text".
if [ -z $GUI ] ; then
   # Test for GUI (Whiptail or Dialog) or pure text environment.
   f_detect_ui
fi
#
# Show Brief Description message.
f_about $GUI "NOK" 3
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Test for BASH environment.
f_test_environment
#
f_menu_main
#
# The function f_do_stuff is also called from f_menu_main.
#f_do_stuff
#
clear # Blank the screen. Nicer ending especially if you chose custom colors for this script.
#
exit 0  # This cleanly closes the process generated by #!bin/bash. 
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
        #
# All dun dun noodles.
