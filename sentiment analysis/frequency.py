#to run this code, write in terminal:
#$ python frequency.py <tweet_file>


import sys
import json
import re
import string
from timeit import default_timer as timer



#helper function to check whether the words are English words
def read_scores(sentiment_file):
    afinnfile = open(sentiment_file)
    scores = {} # initialize an empty dictionary
    for line in afinnfile:
        term, score  = line.split("\t")  # The file is tab-delimited. "\t" means "tab character"
        scores[term] = int(score)  # Convert the score to an integer.
    return scores


def all_words(filename, sentiment_file):
    dict_scores=read_scores(sentiment_file)
    #total number of words
    total_counting=0
    #initialising the dictionary with every word and corresponding frequency
    dict={}
    newList=[]
    tweet_file = open(filename)
    #reading each line at a time
    tweets = (json.loads(line).get('text','').encode('utf-8').split() for line in tweet_file)
    for words in tweets:
        #doing one more cycle because there exist tweets with words concatenated via commas
        for word in words:
            word = re.split(r'[,:"]', word)
            #remove empty words
            wordi=filter(None, word)
            for pal in wordi:
                pal=pal.lower()
                #only filter the words which are sentiment-worthy
                if pal in dict_scores:
                    if pal in dict:
                    #updating the number of times it appears
                        dict[pal] +=1
                        total_counting +=1
                    else:
                        dict[pal]=1
                        total_counting +=1
    #Uncomment if I want all the words and frequency pairs
    #print 'total_counting is ' + str(total_counting)
    #print 'word and frequency'
    #for palavra, total in dict.items():
        #print str(palavra) + "," + str(total)
        #freq=float(total)/float(total_counting)
        #print str(palavra)+ " " + "%0.3f" %freq
    #Uncomment if I want all the words and frequency pairs sorted
    #for key in sorted(dict):
    #    freq=float(dict[key])/float(total_counting)
    #    print "%s: %0.3f" % (key, freq)
    print "By order of frequency: top 20"
    for key in sorted(dict, key=dict.get, reverse=True)[:20]:
        freq=float(dict[key])/float(total_counting)
        print "keyword, appearance-count, freq: "+ "%s, %s, %0.3f" % (key, dict[key], freq)

def main():
    start = timer()
    sentiment_file= sys.argv[1]
    filename = sys.argv[2]
    all_words(filename, sentiment_file)
    end = timer()
    print "Time to run in seconds: %f" %(end-start)


if __name__ == '__main__':
    main()
