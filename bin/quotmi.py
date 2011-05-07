#!/usr/bin/env python

## Sets current status to the latest quotmi entry.

# import dbus
import json
import urllib
import os

## @var base_url
#       the base url for the quotmi website
base_url = 'http://quotmi.com/'
# bus = dbus.SessionBus()
# obj = bus.get_object('im.pidgin.purple.PurpleService',
                     # '/im/pidgin/purple/PurpleObject')
# 
# purple = dbus.Interface(obj, 'im.pidgin.purple.PurpleInterface')
# 
# def set_message(message):
    # ''' Sets current status on pidgin '''
    #Get current status type (Available/Away/etc.)
    # current = purple.PurpleSavedstatusGetType(purple.PurpleSavedstatusGetCurrent())
    #Create new transient status and activate it
    # status = purple.PurpleSavedstatusNew("", current)
    # purple.PurpleSavedstatusSetMessage(status, message)
    # purple.PurpleSavedstatusActivate(status)

def set_adium_status(message):
    ''' Sets the current status on adium using applescript '''
    osa_script='''osascript << EOF
set msg to "%(status)s"
tell application "System Events"
    if exists process "iChat" then tell application "iChat" to set status message to msg
    if exists process "Adium" then tell application "Adium" to set status message of every account to msg
end tell
EOF
''' % {'status': message}
    # print osa_script
    # now execute it somehow.
    os.system(osa_script)

def quotmi_get_latest(user = None):
    ''' Grabs latest quotmi quote from user using a get request.
    If a user is not specified, it grabs the latest quote on the entire site.
    '''
    if user == None:
        url = base_url + 'quotes/view/latest/json'
    else:
        url = base_url + 'users/view/' + user + '/json/1'

    # fetch quote json
    url_fp = urllib.urlopen(url)
    qjson = url_fp.read()
    url_fp.close()


    quote = json.loads(qjson)

    print quote
    if user == None:
        quoteMsg = quote['quote']
    else:
        quoteMsg = quote[0]['quote']

        quoteMsg = quoteMsg + '\n\nPulled from ' \
              + 'http://quotmi.com/users/view/%s' % user

    quoteMsg = quoteMsg.replace("'", "\\'").replace('"', '\\"')
    print quoteMsg
    set_adium_status(quoteMsg)

quotmi_get_latest('grego')
