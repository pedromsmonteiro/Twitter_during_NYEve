#to run this code, write in terminal:
#$ python lang_in_UK.py output.txt
#-*- coding: utf-8 -*-

import sys
import json
import unicodedata
from unidecode import unidecode


def lang_tweet(filename):
    my_dict={}
    states_dic={'AL':'Alabama', 'AK':'Alaska', 'AZ':'Arizona', 'AR':'Arkansas', 
    'CA':'California', 'CO':'Colorado', 'CT':'Connecticut',
    'DC':'District of Columbia', 'Washington':'District of Columbia', 'DE':'Delaware', 
    'FL':'Florida','GA':'Georgia', 'HI':'Hawaii', 'ID':'Idaho', 
    'IL':'Illinois', 'IN':'Indiana', 'IA':'Iowa', 'KS':'Kansas', 'KY':'Kentucky', 
    'LA':'Louisiana', 'ME':'Maine','MD':'Maryland', 'MA':'Massachusetts', 
    'MI':'Michigan', 'MN':'Minnesota', 
    'MS':'Mississippi', 'MO':'Missouri', 'MT':'Montana', 'NE':'Nebraska', 
    'NV':'Nevada', 'NH':'New Hampshire',
    'NJ':'New Jersey', 'NM':'New Mexico', 'NY':'New York', 'New York':'New York', 
    'NC':'North Carolina', 
    'ND':'North Dakota', 'OH':'Ohio', 'OK':'Oklahoma', 'OR':'Oregon', 
    'PA':'Pennsylvania', 'PR':'Puerto Rico','RI':'Rhode Island', 
    'SC':'South Carolina', 'SD':'South Dakota', 'TN':'Tennessee', 'TX':'Texas',
    'UT':'Utah', 'VT':'Vermont', 
    'VA':'Virginia', 'WA':'Washington', 
    'WV':'West Virginia', 'WI':'Wisconsin', 
    'WY':'Wyoming', 'VI':'Virgin Islands'}
    places_dic={'Dallas':'Texas', 'Houston':'Texas','Arlington':'Texas', 
    'San Francisco':'California', 
    'Jacksonville':'Florida', 'Austin':'Texas', 'San Antonio':'Texas', 
    'Brooklyn':'New York',
    'Boston':'Massachusetts', 'Manhattan':'New York', 'Atlanta':'Georgia', 
    'Tucson':'Arizona', 'Cambridge':'Massachusetts', 'Seattle':'Washington',
    'Columbus':'Ohio', 'Philadelphia':'Pennsylvania', 'Los Angeles':'California', 
    'Milwaukee':'Wyoming', 'Queens':'New York','Houston':'Texas', 'Portland':'Oregon', 
    'Sunnyvale':'Oregon', 'San Jose':'California',
    'Paradise':'Virgin Islands', 'Washington':'District of Columbia', 
    'Puerto Rico':'Puerto Rico', 'New York':'New York', 
    'Detroit':'Michigan', 'Chicago':'Illinois'}
    list_of_states_values=states_dic.values()
    list_of_places=places_dic.keys()
    count=0
    tweet_file = open(filename)
    for line in tweet_file:
        tweets = json.loads(line)
        if 'lang' in tweets and tweets['lang']!=None:# and "text" in tweets: 
            if "coordinates" in tweets and tweets['coordinates']!=None:
                if 'place' in tweets and tweets['place']!=None:
                    data1=tweets['place']
                    if data1["country_code"]=="US":
                        state=data1["full_name"].split(", ")
                        #print state
                        #print state
            #need to convert
                        if len(state)==2 and state[1]=='USA':
                            state_id = state[0]
                            #print state_id
                        elif len(state)==2 and state[0] in list_of_states_values:
                            state_id = states_dic[state[0]]
                        #    print state_id
                        #    print state
                        elif len(state)==2 and state[1] in list_of_places:
                            state_id=places_dic[state[1]]
                        elif len(state)==1:
                            state_id='NA'
                        else:    
                            state[1]=remove_accents(state[1])
                            state_id= states_dic[state[1]]
                        lang=tweets['lang'].encode('utf-8')
                        #status=tweets["text"].encode('utf-8')
                        #my_dict[lang]=status 
                        coordlist=tweets['coordinates']
                        coord=coordlist['coordinates']
                        print "%s,%s,%s,%s" % (lang, coord[0], coord[1], state_id.encode("ascii", "ignore"))
                        count+=1
    #to check number of points extracted
    #print count
                    
if __name__ == '__main__':
    tweet_file = sys.argv[1]
    lang_tweet(tweet_file)
                
                