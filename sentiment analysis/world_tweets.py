#to run this code, write in terminal:
#$ python happY_SA_EU.py <sentiment_file> <tweet_file>

#THIS FILE CONSIDERS ALL EUROPEAN COUNTRIES, AS GEOGRAPHICALLY DEFINED, 
#INCLUDING ICELAND, AND TURKEY
import sys
import json
import re
from timeit import default_timer as timer




#want the coordinates of all tweets, if the coordinates are divulged
def world_tweets(filename):
    #initialising the dictionary with every word and corresponding frequency
    dict={}
    tweet_file = open(filename)
    for line in tweet_file:
        tweets = json.loads(line)
        count=0
        #print tweets
        if "coordinates" in tweets and tweets['coordinates']!=None:
            coordlist=tweets['coordinates']
            coord=coordlist['coordinates']
            print "%s,%s" % (coord[0], coord[1])
                
                    
                            


def main():
    start=timer()
    filename = sys.argv[1]
    world_tweets(filename)
    end = timer()
    #print "Time to run in seconds: %f" %(end-start)


if __name__ == '__main__':
    main()