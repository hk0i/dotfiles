#!/usr/bin/env python

import re
import urllib
from datetime import datetime

# LEAGUE_CHAMPIONS_URL = 'http://localhost/test.html'
LEAGUE_CHAMPIONS_URL = 'http://leagueoflegends.com/champions'

def remove_html_tags(data):
    p = re.compile(r'<.*?>')
    return p.sub('', data)

champs = list()

def extract_name(html):
    ''' extracts a name from a bunch of html '''
    regx = re.compile(r'(?<=<span class="highlight">)(<a href="/champions.+$)')
    name =  regx.search(html)
    if name:
        return remove_html_tags(name.group(0)).strip()
    else:
        return False

def download_and_extract_names():
    ''' Downloads and extracts the latest champion list '''
    fp = urllib.urlopen(LEAGUE_CHAMPIONS_URL)
    lines = fp.readlines()
    fp.close()
    for line in lines:
        champ = extract_name(line)
        if champ:
            champs.append(champ)

def print_champ_list():
    for champ in champs:
        print '\t"' + champ + '",'

def print_script():
    print '#!/usr/bin/env python'
    print
    print '#random-lol-champ.py -- generated at: ' \
            + str(datetime.now())
    print 'import random'
    print
    print 'champs = ['
    print_champ_list()
    print ']'
    print 'print random.choice(champs)'

download_and_extract_names()
print_script()
