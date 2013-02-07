Facebook Friend Rings
=====================

Class project for CS 467 at UIUC. 
Team members: Emelyn Baker, Cole Gleason, and Drayden Lin.

A visualization of Facebook messages from your friends to you.

This visualization is designed to show the interaction between you and your friends in your Facebook inbox.
It uses total number of messages and message frequency.  As nodes around the user send messages to the user, the distance between the friend and the center decrease.

 * Frequesncy is computed as (# of messages from a user in the past 30 days)/(max number from any user in the past 30 days).
 * Each message increases the proximity between that node and the central user.
 * Each step of the animation is a new time unit, usually the smallest unit is each message.

##How To Use With Your Own Data##
1. Open parse_message_html.py and set the your_name variable to your full Facebook profile name (this filters out messages from you).
2. Download an archive of your Facebook data, move messages.html into the fb-friend-rings directory, and then run parse_message_html.py.
3. Move the new fbmessages.csv file into visualization/data, overwriting the included dataset.
4. Open visualization.pde and set username variable to your facebook username.
5. Run it!

