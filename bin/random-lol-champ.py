#!/usr/bin/env python

import random
import json
import urllib

LEAGUE_CHAMPIONS_JSON_URL = 'http://ddragon.leagueoflegends.com/cdn/4.10.7/data/en_US/champion.json'

def download_champion_list():
    ''' downloads json with league of legends champion data '''
    filePointer = urllib.urlopen(LEAGUE_CHAMPIONS_JSON_URL)
    try:
        return json.load(filePointer)['data']
    except:
        return None

def pick_random_champion():
    champs = download_champion_list()
    if champs:
        return random.choice(champs.keys())
        # pprint(champs['data'].keys())

print pick_random_champion()
