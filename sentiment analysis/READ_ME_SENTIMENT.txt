These files run steps within the sentiment analysis framework. We only use standard packages, even though there are nowadays many specialised packages. The complete list of python script files, which accept json files and return their running time, are as follows:

* top_twenty.py —it computes the top 20 hashtags 
* world_tweets.py — gets the coordinates, if available, of the tweets
* lang_in_USA.py — given tweets, it determines whether they have been sent from any US state, and returns their language (extracted from twitter API), coordinates and state. Code is able to deal with noisy data.
* lang_in_UK.py — given tweets, it determines whether they have been sent from the UK, and returns their language (extracted from twitter API), coordinates and region. 
* lang_EU.py — given tweets, it determines whether they have been sent from any country in Europe, and returns their language (extracted from twitter API), coordinates and region. 
* happy_UK_places.py — given tweets sent from the UK, it runs sentiment analysis on each tweet to determine which UK regions sent tweets with higher scores.
* happy_sa_EU.py — given tweets sent from Europe, it runs sentimental analysis on each tweet to determine what is each country’s cumulative score.
* frequency.py —computes the frequency of sentiment words given a set of tweets


We have interfaced with the twitter API for an approximate period of 13 hours, starting at approximately 10pm UK time of 31st December 2015. 

For the sentiment analysis, we used the simplest metric of finding the words in tweets which carried a sentiment score. For the sentiment scores, we used AFINN-111 (please see below).




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
