#to run this code, write in the terminal
#python top_ten.py <tweet_file>

import sys
import json
import re




#using the help function given in the instructions for the assignment
def top_ten(filename):
    #total number of words
    total_counting=0
    #initialising the dictionary with every word and corresponding frequency
    dict={}
    tweet_file = open(filename)
    for line in tweet_file:
        tweets = json.loads(line) 
        if 'entities' in tweets:
            data1=tweets['entities']
            data2=data1['hashtags'] 
            for data3 in data2:
                hashtags=data3["text"].encode('ascii','ignore')
                #there were many underscores in the hashtags which we had to remove
                hashtags=filter(None, re.split("[_]+", hashtags))
                for hashtag in hashtags:
                    if hashtag in dict:
                    #updating the number of times it appears
                        dict[hashtag] +=1
                        total_counting +=1
                    elif hashtag !="" and hashtag not in dict:
                        dict[hashtag]=1
                        total_counting +=1
    print 'total number of hashtags is ' + str(total_counting)
    print 'top 20 count and corresponding frequency are:'
    print 'hashtag and frequency' 
    number_items=0
    for key in sorted(dict, key=dict.get, reverse=True):
        freq=float(dict[key])/float(total_counting)
        number_items+=1
        if number_items<21:
            print "%d - %s: %0.3f" % (number_items, key, freq)



def main():
    filename = sys.argv[1]
    top_ten(filename)


if __name__ == '__main__':
    main()