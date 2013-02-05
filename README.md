libertyautomator
================

A more thorough "How-To": 

 At https://github.com/katelynsills/libertyautomator, click on the button labeled 'zip' to download the file.  Make sure the file in a location you can easily access (let's just say it's on the desktop), and unzip it.  
 
 Then go to your terminal. (I use Macs, so these instructions will be for those).  You should see a prompt that looks like this:  
 
 "Last login: Sun Feb  3 13:43:55 on ttys000 Katelyns-MacBook-Pro:~ katelynsills$"  
 
 Type "cd Desktop". This moves to the Desktop. Type "cd libertyautomator-master", which will open the file folder.   
 
 Now type "open libertyautomator.rb" to open the file in a text editor. You'll want to edit the gmail_address and gmail_password such that it reads something like gmail_address = 'example@gmail.com" and gmail_password = '123'.  Save the file and exit the text editor.  
 
 Back at the terminal, you'll want to download some helpful plugins called ruby gems in order to run the script. Type "gem install nokogiri" and press enter and when that's done type "gem install restclient" and then "gem install csv" and then "gem install gmail"  
 
 FINALLY, type "ruby libertyautomator.rb" to run the script. That's it! Enjoy! 
