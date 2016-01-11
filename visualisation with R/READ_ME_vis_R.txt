These files run steps within the sentiment analysis framework. We only use standard packages, even though there are nowadays many specialised packages. The complete list of python script files, which accept json files and return their running time, are as follows:

* statesUS.R —plots all languages in tweets sent from US states
* world_tweets.R — produces a world map with all tweets sent over NYE (given their coordinates: lat and long)
* EU_lang.R — plots European tweets given the tweets coordinates.
* languages_UK.R — given tweets, it determines whether they have been sent from the UK, and plots their locations by language. 
* worldclouds.R — pictures world clouds with the words from tweets carrying sentiments by their frequency.


We have interfaced with the twitter API for an approximate period of 13 hours, starting at approximately 10pm UK time of 31st December 2015. 



AFINN is a list of English words rated for valence with an integer
between minus five (negative) and plus five (positive). The words have
been manually labeled by Finn Årup Nielsen in 2009-2011. The file
is tab-separated. There are two versions:

AFINN-111: Newest version with 2477 words and phrases.

AFINN-96: 1468 unique words and phrases on 1480 lines. Note that there
are 1480 lines, as some words are listed twice. The word list in not
entirely in alphabetic ordering.  

The list was used in: 

Lars Kai Hansen, Adam Arvidsson, Finn Årup Nielsen, Elanor Colleoni,
Michael Etter, "Good Friends, Bad News - Affect and Virality in
Twitter", The 2011 International Workshop on Social Computing,
Network, and Services (SocialComNet 2011).


This database of words is copyright protected and distributed under
"Open Database License (ODbL) v1.0"
http://www.opendatacommons.org/licenses/odbl/1.0/ or a similar
copyleft license.
