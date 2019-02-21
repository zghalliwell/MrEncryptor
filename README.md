# MrEncryptor
Mr. Encryptor

This tool is a variation of Jamf's "Encrypted Script Parameters" script that can be found here:
https://github.com/jamf/Encrypted-Script-Parameters
I essentially just tweaked it a bit to make it a little more user friendly and include a GUI so that you 
don't have to bake your string into the script every time you want to encrypt something.

This tool will prompt the user to input a word or phrase
and then will encrypt their input and save the output to the clipboard as
an encrypted string along with a salt and passphrase to decrypt the string.    

To decrypt the string:
First, in whatever script you need to use the encrypted string, establish this function:

function DecryptString() {
  echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
  }

Once that function is established you can call the "DecryptString"
function alongside the encrypted string, salt, and passphrase to
decrypt the Encrypted String as so:

DecryptString "EncryptedString" "Salt" "Passphrase"

It is recommended for added security to pass the
Encryped String as a parameter from Jamf so that both
pieces of the key live in separate places

For example:

DecryptString "$4" "Salt" "Passphrase"

## License

```
Copyright (c) 2015, JAMF Software, LLC. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this
      list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this
      list of conditions and the following disclaimer in the documentation and/or
      other materials provided with the distribution.
    * Neither the name of the JAMF Software, LLC nor the names of its contributors
      may be used to endorse or promote products derived from this software without
      specific prior written permission.
      
THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE,
LLC BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
