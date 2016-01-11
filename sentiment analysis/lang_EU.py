#to run this code, write in terminal:
#$ python happY_SA_EU.py <sentiment_file> <tweet_file>

#THIS FILE CONSIDERS ALL EUROPEAN COUNTRIES, AS GEOGRAPHICALLY DEFINED, 
#INCLUDING ICELAND, AND TURKEY
import sys
import json
import re
from timeit import default_timer as timer




#using happiest_place help function given in the instructions for the assignment
def EU_tweets(filename):
    #initialising the dictionary with every word and corresponding frequency
    dict={}
    tweet_file = open(filename)
    listEUcountries=['AL', 'AD', 'AM', 'AT', 'BY', 'BE', 'BA', 'BG', 'CH', 
    'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 'FO', 'FI', 'FR', 'GB', 'GE', 'GI',
    'GR', 'HU', 'HR', 'IE', 'IS', 'IT', 'LT', 'LU', 'LV', 'MC', 'MK', 
    'MT', 'NO', 'NL', 'PL', 'PT', 'RO', 'RU', 'SE', 'SI', 'SK', 'SM', 'TR', 'UA', 
    'VA']
    for line in tweet_file:
        tweets = json.loads(line)
        count=0
        #print tweets
        if 'place' in tweets and tweets['place']!=None:
            data1=tweets['place']
            #print data1
            tempcountry=data1["country_code"]
            if tempcountry in listEUcountries:
                countrycode=tempcountry
                if 'lang' in tweets and tweets['lang']!=None and "text" in tweets: 
                    if "coordinates" in tweets and tweets['coordinates']!=None:
                        lang=tweets['lang'].encode('utf-8')
                        coordlist=tweets['coordinates']
                        coord=coordlist['coordinates']
                        print "%s,%s,%s,%s" % (lang, coord[0], coord[1], countrycode)
                
                    
                            


def main():
    start=timer()
    filename = sys.argv[1]
    EU_tweets(filename)
    end = timer()
    #print "Time to run in seconds: %f" %(end-start)


if __name__ == '__main__':
    main()