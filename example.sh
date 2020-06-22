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
VERSION="2020-06-22 01:14"
THIS_FILE="example_template.sh"
TEMP_FILE=$THIS_FILE"_temp.txt"
GENERATED_FILE=$THIS_FILE"_menu_generated.lib"
#
# +----------------------------------------+
# |            Brief Description           |
# +----------------------------------------+
#
#@ Brief Description
#@
#@ Description goes here.
#@ This is a example of a bare-bones script which uses
#@ the library example_library.lib.
#@ 
#@ Required scripts: first.sh, second.sh, third.sh,
#@                   example_module_main.lib
#@
#@ Usage: bash example.sh
#@        (not sh example.sh)
#
# +----------------------------------------+
# |             Help and Usage             |
# +----------------------------------------+
#
#?    Usage: bash example.sh [OPTION]
#? Examples:
#?
#?bash example.sh text       # Use Cmd-line user-interface (80x24 min.).
#?               dialog     # Use Dialog   user-interface.
#?               whiptail   # Use Whiptail user-interface.
#?
#?bash example.sh --help     # Displays this help message.
#?               -?
#?
#?bash example.sh --about    # Displays script version.
#?               --version
#?               --ver
#?               -v
#?
#?bash example.sh --history  # Displays script code history.
#?               --hist
#
# +----------------------------------------+
# |           Code Change History          |
# +----------------------------------------+
#
## Code Change History
##
## (After each edit made, please update Code History and VERSION.)
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
# +----------------------------------------+
# |         Function f_script_path         |
# +----------------------------------------+
#
#     Rev: 2020-04-20
#  Inputs: $BASH_SOURCE (System variable).
#    Uses: None.
# Outputs: SCRIPT_PATH, THIS_DIR.
#
f_script_path () {
      #
      # BASH_SOURCE[0] gives the filename of the script.
      # dirname "{$BASH_SOURCE[0]}" gives the directory of the script
      # Execute commands: cd <script directory> and then pwd
      # to get the directory of the script.
      # NOTE: This code does not work with symlinks in directory path.
      #
      # !!!Non-BASH environments will give error message about line below!!!
      SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
      THIS_DIR=$SCRIPT_PATH  # Set $THIS_DIR to location of this script.
      #
} # End of function f_script_path.
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
# **************************************
# ***     Start of Main Program      ***
# **************************************
#
#     Rev: 2020-04-28
#
if [ -e $TEMP_FILE ] ; then
   rm $TEMP_FILE
fi
#
clear  # Blank the screen.
#
echo "***********************************"
echo "***  Running script $THIS_FILE  ***"
echo "***   Rev. $VERSION     ***"
echo "***********************************"
echo
sleep 1  # pause for 1 second automatically.
#
clear # Blank the screen.
#
# If an error occurs, the f_abort() function will be called.
# f_abort depends on f_message which must be in this script.
# (especially if library file *.lib is missing).
#
# trap 'f_abort' 0
# set -e
#
# Set THIS_DIR, SCRIPT_PATH to directory path of script.
f_script_path
#
# Set Temporary file using $THIS_DIR from f_script_path.
TEMP_FILE=$THIS_DIR/$THIS_FILE"_temp.txt"
#
# Does library file exist and is readable in the same directory as this script?
if [ -r /$THIS_DIR/example_library.lib ] ; then
   # Invoke library file "example_library.lib".
   . /$THIS_DIR/example_library.lib
else
   echo "Required module file \"example_library.lib\" is missing."
   echo "Missing file: $THIS_DIR/example_library.lib"
   echo
   echo "Cannot continue, exiting program script."
   echo
   sleep 2
   exit 1
fi
#
# Test for Optional Arguments.
f_arguments $1  # Also sets variable GUI.
#
# If command already specifies GUI, then do not detect GUI i.e. "bash dropfsd.sh dialog" or "bash dropfsd.sh text".
if [ -z $GUI ] ; then
   # Test for GUI (Whiptail or Dialog) or pure text environment.
   f_detect_ui
fi
#
#GUI="whiptail"  # Diagnostic line.
#GUI="dialog"    # Diagnostic line.
#GUI="text"      # Diagnostic line.
#
# Test for BASH environment.
f_test_environment
#
#f_main_menu
#
f_do_stuff
#
clear # Blank the screen. Nicer ending especially if you chose custom colors for this script.
#
exit 0  # This cleanly closes the process generated by #!bin/bash. 
        # Otherwise every time this script is run, another instance of
        # process /bin/bash is created using up resources.
        #
# all dun dun noodles.
