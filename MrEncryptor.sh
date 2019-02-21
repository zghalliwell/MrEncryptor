#!/bin/bash

#############################################################################
# This tool will prompt the user to input a word or phrase                  #
# and then will encrypt their input and save the output to the clipboard as #
# an encrypted string along with a salt and passphrase to decrypt           #
# the string.                                                               #
#############################################################################
#                                                                           #
# To decrypt the string:                                                    #
# First, in whatever script you need to use the encrypted                   #
# string, establish this function:                                          #
#                                                                           #
# function DecryptString() {                                                #
#	echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}" #
#  }                                                                        #
#                                                                           #
# Once that function is established you can call the "DecryptString"        #
# function alongside the encrypted string, salt, and passphrase to          #
# decrypt the Encrypted String as so:                                       #
#                                                                           #
# DecryptString "EncryptedString" "Salt" "Passphrase"   					# 
#                  														    #
# It is recommended for added security to pass the                          #
# Encryped String as a parameter from Jamf so that both                     #
# pieces of the key live in separate places   							    #
#																			#
# For example:																#
#																			#
# DecryptString "$4" "Salt" "Passphrase".                                   #
#																			#
#############################################################################

#Establish the function for the encryption process
function GenerateEncryptedString() {
	local STRING="${1}"
	local SALT=$(openssl rand -hex 8)
	local K=$(openssl rand -hex 12)
	local ENCRYPTED=$(echo "${STRING}" | openssl enc -aes256 -a -A -S "${SALT}" -k "${K}")
	echo "Encrypted String: ${ENCRYPTED} | Salt: ${SALT} | Passphrase: ${K}"
}

#Prompt the user for the word or phrase they would like to encrypt and save it as a variable
stringToEncrypt=$(osascript -e 'text returned of (display dialog "Please enter the phrase you would like to encrypt" default answer "" buttons {"OK"} default button 1)')

#Encrypt the user's input and save the finished encryption set as a variable
encryptedOutput=$(GenerateEncryptedString "$stringToEncrypt")

#Save the finished encryption, salt, and passphrase to the user's clipboard
echo $encryptedOutput | pbcopy

#Launch Jamf Helper and display encryption output
"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType utility -title "Mr. Encryptor" -heading "Encryption Finished!" -alignHeading center -description "Your encrypted string, salt, and passphrase have been copied to your clipboard. Have a super day!" -alignDescription center -button1 Close -defaultButton 0 



