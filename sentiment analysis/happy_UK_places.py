#to run this code, write in terminal:
#$ python happiest_state.py <sentiment_file> <tweet_file>
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


#using happieste_place help function given in the instructions for the assignment
def happiest_states(filename, sentiment_file):
    scores = read_scores(sentiment_file)
    state_feeling={}
    tweet_file = open(filename)
    for line in tweet_file:
        tweets = json.loads(line)
        count=0
        #print tweets
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
                #else:
                    #print state
                if "text" in tweets:
                    status=tweets["text"].encode('utf-8').split()
                    #print "new sentence" +str(status)
                    count=0
                    for word in status:
                        word=word.lower()
                        #print word
                        if word in scores:
                            #print word
                            count+=scores[word]
                    #print "state is" + str(statecode) +str(count)
                    lista=state_feeling.keys()
                    if state_feeling=={}:
                        state_feeling[statecode]=count
                        #print "initialising dict"
                        #print statecode, count
                    if statecode in lista:
                        #print "updating dict"
                        #print statecode, count, state_feeling[statecode]
                        state_feeling[statecode]+=count
                        #print state_feeling[statecode]
                    if statecode not in lista:
                        #print "generating new entry in the dict"
                        #print statecode, count
                        state_feeling[statecode]=count
    #print "Results of sentiment analysis applied to UK regions:"
    for key in sorted(state_feeling, key=state_feeling.get, reverse=True):
        print "%s ,%s" % (key, state_feeling[key])
    if state_feeling=={}:
        print "There are no tweets from GB"
                    
                            


def main():
    start=timer()
    sentiment_file=sys.argv[1]
    filename = sys.argv[2]
    happiest_states(filename, sentiment_file)
    end = timer()
    #print "Time to run in seconds: %f" %(end-start)


if __name__ == '__main__':
    main()