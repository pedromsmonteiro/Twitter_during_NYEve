#to run this code, write in terminal:
#$ python lang_in_UK.py output.txt

import sys
import json




def lang_tweet(filename):
    my_dict={}
    count=0
    tweet_file = open(filename)
    for line in tweet_file:
        tweets = json.loads(line)
        if 'lang' in tweets and tweets['lang']!=None:# and "text" in tweets: 
            if "coordinates" in tweets and tweets['coordinates']!=None:
                if 'place' in tweets and tweets['place']!=None:
                    data1=tweets['place']
                    if data1["country_code"]=="GB":
                        state=data1["full_name"].split(", ")
                #unfortunately this is noisy data, and there are places where
                #the information is not (city, state), but rather (state, country)
                #print state
                        if len(state)==2 and state[1]=='United Kingdom':
                    #print state
                            statecode=state[0]
                    #print state, statecode
                        elif len(state)==2:
                    #state[1]=state[1].encode('utf-8')
                #data is noisy and doesn't always place state on the second position
                    #print state
                            statecode=state[1]
                        if statecode=='London':
                            statecode='England'
                        lang=tweets['lang'].encode('utf-8')
                        status=tweets["text"].encode('utf-8')
                        my_dict[lang]=status 
                        coordlist=tweets['coordinates']
                        coord=coordlist['coordinates']
                        print "%s,%s,%s,%s" % (lang, coord[0], coord[1], statecode)
                        count+=1
    #to check number of points extracted
    #print count
                    
if __name__ == '__main__':
    tweet_file = sys.argv[1]
    lang_tweet(tweet_file)
                
                