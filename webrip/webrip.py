import urllib
import urllib.request
from urllib.request import urlopen, urlretrieve, Request

import re

# matchobj = re.search(pattern, input_str, flags=0)
# regexstr = r"([aA])"
# https://regexone.com/reference/python

# urlretrieve(site, fileName)

def grabSoundDict(word):
    word = word.lower()
    wText = ""
    regPat = "<source src=\"([A-Za-z0-9./:]*)\" type=\"audio/mpeg\">"
    siteOpened = False
    
    try:
        wText = str(urlopen("http://www.dictionary.com/browse/" + word).read())
        siteOpened = True
    except Exception as e:
        print("Couldn't open site with desired word.")
        siteOpened = False

    if(siteOpened):
        
        if(re.search(regPat, wText, flags=0)):

            match = re.search(regPat, wText, flags=0)
            rawStr = wText[match.start():match.end()]
            if("http://" in rawStr):
                start = rawStr.index("http://")
                end = rawStr.index("mp3") + 3

            refinedStr = rawStr[start:end]
            urlretrieve(refinedStr, "sounds/" + str(word) + "-dictionary.mp3")
            
        else:
            print("No match")

def grabSounds(words, site):

    if(site == "dictionary"):
        for word in words:
            grabSoundDict(word)
    else:
        print("Site not found: " + site)

def detectWebsites(file):
    with open(file) as f:
        sites = f.readline().split()
        words = f.read().split()
        for site in sites:
            grabSounds(words, site)
        
detectWebsites("data.txt")


#grabSounds(["red", "apple", "face", "late", "lateness"])



















        

        
