##What is ver

This tool is headed to those like me that keep a large number of video downloads on one folder. As time passes, you get everyday harder and harder to find the file you want to play. This is one of such tasks than are more difficult with a GUI program. So this script is to be run from your terminal.

>Before running it, take a look to the code. You have to modify DIR environment variable to the path where your files are deposited in. Then go to the last lines and change the player to your favourite. I use vlc, but you can easily change to whatever you see fit.

The scripts accepts as parameter the title, complete or partial, of the file you are looking for. If there is just one matching file, ver.sh will play it straight. If there are several files that match, the script will show you a text menu which is easily understandable. Once entered the number you want, it will go playing the selected file.

Since I created this script I save a lot of time. I hope it works for you too.

##Options

Notice: All options have to be passed as first argument: '''ver [option] search string'''. This is because all and every options are incompatible with each other. They do specific tasks for you that cannot be combined.

*-v : By default, ver hides files you've already watched. If you want ver to list all the files related to your search string, including this option will make all visible again.

*-nv : Say you want to list all files you haven't watched yet. This is your option. This option wont take any other arguments.

*--reset : Once you have seen all episodes of your favourite series, yoy might want to start watching it again from the begining. This option will remove your series from the database so you can see it all over again.

*^[search string] : Since ver knows which episodes you've already seen from the series you are quering, this option (just adding an '^' before your search string) will make ver go straight forward to play the next episode for you, without pauses.

##Examples

Note: all the examples are made with the query string "abc xyz". You can change if for the title you want.

>Remember that all commands work like: ver \[options\] \[query string\]

'''ver abc xyz'''

Lists all files that match with "abc xyz". You will be able to choose the one you want "ver" to play for you. By default, already seen files won't show.


'''ver -v abc xyz'''

Lists all files that match "abc xyz", including the ones you already have played before.


'''ver -nv'''

Show all files that haven't been played so far.


'''ver --reset abc xyz'''

Reset "abc xyz" series to begin watching it from the begining all over again.


'''ver ^abc xyz'''

Play the next episode of series "abc xyz" (works with films too).

##Prerequisites

	*sqlite
	*Any video player

##The future

I'm looking for a way to query imdb. It would be nice to search for actors, directors, etc. And it would be nice to add some options to see video details.

If you have problems using it or have ideas that could improve it, feel free to write me to <a href="mailto:mhysterio@gmail.com">mhysterio at gmail dot com</a>