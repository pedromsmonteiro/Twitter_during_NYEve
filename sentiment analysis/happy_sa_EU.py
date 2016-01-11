#to run this code, write in terminal:
#$ python happY_SA_EU.py <sentiment_file> <tweet_file>

#THIS FILE CONSIDERS ALL EUROPEAN COUNTRIES, AS GEOGRAPHICALLY DEFINED, 
#INCLUDING ICELAND, AND TURKEY
import sys
import json
import re
from timeit import default_timer as timer

#using the help function given in the instructions for the assignment
def read_scores(sentiment_file):
    afinnfile = open(sentiment_file)
    scores = {} # initialize an empty dictionary
    for line in afinnfile:
        term, score  = line.split("\t")  # The file is tab-delimited. "\t" means "tab character"
        scores[term] = int(score)  # Convert the score to an integer.
    return scores


#getting the score for each tweet
def tweet_score(tweet, scores):
    #the default score will be zero
    return sum(scores.get(word, 0) for word in tweet)


#using happiest_place help function given in the instructions for the assignment
def happiest_countries(filename, sentiment_file):
    scores = read_scores(sentiment_file)
    #total number of words
    country_feeling={}
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
            tempcountry=data1["country_code"]
            if tempcountry in listEUcountries:
                countrycode=tempcountry
                if "text" in tweets:
                    status=tweets["text"].encode('utf-8').split()
                    for word in status:
                        word=word.lower()
                        #print word
                        if word in scores:
                            #print word
                            count+=scores[word]
                            #print count
                    lista=country_feeling.keys()
                    if country_feeling=={}:
                        country_feeling[countrycode]=count
                        #print "initialising dict"
                        #print statecode, count
                    if countrycode in lista:
                        #print "updating dict"
                        #print countrycode, count, country_feeling[countrycode]
                        country_feeling[countrycode]+=count
                        #print state_feeling[statecode]
                    if countrycode not in lista:
                        #print "generating new entry in the dict"
                        #print countrycode, count
                        country_feeling[countrycode]=count
    print "EU country code and respective sentiment analysis code:"              
    for key in sorted(country_feeling, key=country_feeling.get, reverse=True):
        print "%s %s" % (key, country_feeling[key])
    if country_feeling=={}:
        print "There are no tweets from Europe"
                    
                            


def main():
    start=timer()
    sentiment_file=sys.argv[1]
    filename = sys.argv[2]
    happiest_countries(filename, sentiment_file)
    end = timer()
    print "Time to run in seconds: %f" %(end-start)


if __name__ == '__main__':
    main()