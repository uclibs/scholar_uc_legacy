The clamav gem seems to have problems with ClamAV 0.98.4 on the Mac.  

#### Use the instructions below to force homebrew to install ClamAV 0.98.3:

1. `brew uninstall clamav` (this will uninstall your current clamav version if there is one)
1. Replace the contents of /usr/local/Library/Formula/clamav.rb with the contents of [https://github.com/Homebrew/homebrew/blob/d74fffd597fabce4f3dcfa26b0ab81b41b45d727/Library/Formula/clamav.rb](https://github.com/Homebrew/homebrew/blob/d74fffd597fabce4f3dcfa26b0ab81b41b45d727/Library/Formula/clamav.rb)
1. `brew install clamav` (brew should start to install clamav 0.98.3)
    * If you get an OpenSSL error, do a `brew install openssl` and then `brew link openssl --force`.  Then try the `brew install clamav` command again.
1. Check your ClamAV version with `clamscan --version` (verify you have 0.98.3)
1. Download the virus definitions with `freshclam`
    * If the freshclam command fails, look in /usr/local/etc/ for a freshclam.conf example file.  Rename it to 'freshclam.conf' and edit it to comment out the line that has "Example" on it.  Then try running `freshclam` again.
1. Test that ClamAV can scan a file with `clamscan <some file>`

#### After ClamAV and the virus definitions are installed, install the clamav gem:

1. Change to your curate_uc app directory and do a `gem install clamav`
    * If the gem install fails, try again using the command `gem install clamav -- --with-clamav-include=/usr/local/Cellar/clamav/0.98.3/include/ --with-clamav-lib=/usr/local/Cellar/clamav/0.98.3/lib/`
1. Try running the app and see if everything works.
