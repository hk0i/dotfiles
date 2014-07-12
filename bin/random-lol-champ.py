#!/usr/bin/env python

import random
import json
import urllib
import os
import os.path

LEAGUE_CHAMPIONS_JSON_URL = 'http://ddragon.leagueoflegends.com/cdn/4.10.7/data/en_US/champion.json'
LOCAL_CHAMPS_DB = 'champs.json'
MAX_RETRY = 2

def download_new_champion_list():
    ''' downloads json with league of legends champion data '''
    filePointer = urllib.urlopen(LEAGUE_CHAMPIONS_JSON_URL)
    try:
        championData = json.load(filePointer)['data']
        fp = open(LOCAL_CHAMPS_DB, 'w')
        json.dump(championData, fp)
        fp.close()
    except Exception as ex:
        print 'Encountered issues: %s' % ex

g_retry = 0
def get_champion_list():
    ''' retrieves champion list from storage, or creates storage if none available '''
    global g_retry
    try:
        if os.path.isfile(LOCAL_CHAMPS_DB) and os.stat(LOCAL_CHAMPS_DB).st_size > 0:
            fp = open(LOCAL_CHAMPS_DB, 'r')
            champList = json.load(fp)
            fp.close()

            return champList

        elif g_retry < MAX_RETRY: #if there is no file, download it
            if g_retry == 0:
                #don't retry the download more than once, just wait til the file is ready.
                download_new_champion_list()
            g_retry += 1

            return get_champion_list()

    except Exception as ex:
        print 'Something went wrong getting champion list: %s' % ex

def pick_random_champion():
    champs = get_champion_list()
    if champs:
        return random.choice(champs.keys())

print pick_random_champion()
