# iOS Password Manager & Android Password Hasher (Salting)

I think this is a good spot to send you what I have. There is always something to add and It’s easy to get carried away. The task was enjoyable, and I appreciated the time flexibility. It’s nice not feeling rushed. I spent a couple of hours 12/8 - 12/11 working on the apps, mostly the iOS app.

**The iOS App**

I created a password manager on iOS, Main features:
* Handles the first launch. Welcomes user and sets the master password.
* Has 4 sections
  * Accounts: See your accounts
  * Add an account
  * About me: Links to my professional social media
  * Settings: Change the master password
* The master password is stored using Apple KeyChain
* The user can log in with Face ID or Touch ID if they have it.
* Auto layout and custom colors and Icons were used.

The iOS app is FAR from perfect but for 4 days I think it's pretty good.

**The Android app**

The Android app is simple. A user will type in a password. The app then hashes it using Bcrypt and Salting with a cost of 10. The app then displays the hash for the demonstration. Then once the user types in their password in the last field it will verify the password using the hash and it will either be successful or not. No key is stored, if the password was in a database. It would be harder for a hacker to decrypt the password.

- - - -

As a note:
The iOS app was made using iOS 13 and XCode Version 11.3 (11C29). The app should work fine on an emulator. I'm afraid I didn’t have an iOS13 device to test it on. If you experience any issues, feel free to let me know. The Android app was made with Kotlin in the latest version of Android Studios. Thanks for the opportunity and I hope I showed enough ambition.
