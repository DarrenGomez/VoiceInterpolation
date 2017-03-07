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

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-dictionary.mp3")
            except Exception as e:
                print(e)
        else:
            print("No match")

def grabSoundOxford(word):
    word = word.lower()
    wText = ""
    regPat = "<audio src=\"([A-Za-z0-9./:_]*)\"></audio>"
    siteOpened = False
    
    try:
        wText = str(urlopen("https://en.oxforddictionaries.com/definition/" + word).read())
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
                end = rawStr.index(".mp3") + 4

            refinedStr = rawStr[start:end]

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-oxford.mp3")
            except Exception as e:
                print(e)
                
        else:
            print("No match")

def grabSoundMacmill(word):
    word = word.lower()
    wText = ""
    regPat = "data-src-mp3=\"([A-Za-z0-9./:_]*)\""
    siteOpened = False
    
    try:
        wText = str(urlopen("http://www.macmillandictionary.com/us/dictionary/american/" + word + "").read())
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
                end = rawStr.index(".mp3") + 4

            refinedStr = rawStr[start:end]

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-macmillan.mp3")
            except Exception as e:
                print(e)
                
        else:
            print("No match")

def grabSoundCambridge(word):
    word = word.lower()
    wText = ""
    regPat = "data-src-mp3=\"([A-Za-z0-9./:_]*)\""
    siteOpened = False
    
    try:
        wText = str(urlopen("http://dictionary.cambridge.org/us/dictionary/english/" + word + "").read())
        siteOpened = True
    except Exception as e:
        print("Couldn't open site with desired word.")
        siteOpened = False

    if(siteOpened):

        with open("html.txt", "w") as w:
            w.write(wText)
        
        if(re.search(regPat, wText, flags=0)):

            match = re.search(regPat, wText, flags=0)
            rawStr = wText[match.start():match.end()]
            if("http://" in rawStr):
                start = rawStr.index("http://")
                end = rawStr.index(".mp3") + 4

            refinedStr = rawStr[start:end]

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-cambridge.mp3")
            except Exception as e:
                print(e)
                
        else:
            print("No match")

def grabSoundFreeDict(word):
    word = word.lower()
    wText = ""
    regPat = "<span class=\"snd\" data-snd=\"([A-Za-z0-9./:_']*)\"></span>"
    siteOpened = False
    
    try:
        wText = str(urlopen("http://thefreedictionary.com/" + word + "").read())
        siteOpened = True
    except Exception as e:
        print("Couldn't open site with desired word.")
        siteOpened = False

    if(siteOpened):
        
        if(re.search(regPat, wText, flags=0)):

            match = re.search(regPat, wText, flags=0)
            rawStr = wText[match.start():match.end()]
            if("data-snd=" in rawStr):
                start = rawStr.index("data-snd=") + 10
                end = rawStr.index("\"", start)
            else:
                print("Couldn't find the data string for " + word)
                return

            data = rawStr[start:end]

            refinedStr = "http://img.tfd.com/hm/mp3/" + data + ".mp3"

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-freedict.mp3")
            except Exception as e:
                print(e)
                
        else:
            print("No match")

def grabSoundCollins(word):
    word = word.lower()
    wText = ""
    regPat = "data-src-mp3=\"([A-Za-z0-9./:_']*)\" data-lang="
    siteOpened = False
    
    try:
        wText = str(urlopen("https://www.collinsdictionary.com/us/dictionary/english/" + word + "").read())
        siteOpened = True
    except Exception as e:
        print("Couldn't open site with desired word.")
        siteOpened = False

    if(siteOpened):
        
        if(re.search(regPat, wText, flags=0)):

            match = re.search(regPat, wText, flags=0)
            rawStr = wText[match.start():match.end()]
            if("data-src-mp3=" in rawStr):
                start = rawStr.index("data-src-mp3=") + 14
                end = rawStr.index(".mp3", start) + 4
            else:
                print("Couldn't find the data string for " + word)
                return

            data = rawStr[start:end]

            refinedStr = "http://www.collinsdictionary.com/" + data

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-collins.mp3")
            except Exception as e:
                print(e)
                
        else:
            print("No match")

#Merriam webster is hiding the sound in the web page as an embedded element, cannot grab sound
def grabSoundMerr(word):
    word = word.lower()
    wText = ""
    regPat = "<a class=\"play-pron\" data-lang=\"en_us\" (data-file=\"[A-Za-z0-9]*\" data-dir=\"[A-Za-z]*\") href=\"javascript:void\(0\)\" title=\"Listen to the pronounciation"
    siteOpened = False
    
    try:
        wText = str(urlopen("http://www.merriam-webster.com/dictionary/" + word).read())
        siteOpened = True
    except Exception as e:
        print("Couldn't open site with desired word.")
        siteOpened = False

    if(siteOpened):
        
        if(re.search(regPat, wText, flags=0)):

            match = re.search(regPat, wText, flags=0)
            rawStr = wText[match.start():match.end()]
            print(rawStr)
            if("data-file" in rawStr):
                start = rawStr.index("data-file") + 11
                end = rawStr.index("\"", start)
                dataFile = rawStr[start:end]
            else:
                dataFile = word + "01"



            if("data-lang" in rawStr):
                start = rawStr.index("data-lang") + 11
                end = rawStr.index("\"", start)
                dataLang = rawStr[start:end]
            else:
                dataLang = "en_us"


            if("data-dir" in rawStr):
                start = rawStr.index("data-dir") + 10
                end = rawStr.index("\"", start)
                dataDir = rawStr[start:end]
            else:
                dataDir = "r"



            refinedStr = ("https://www.merriam-webster.com/dictionary/" + word + "?pronunciation&lang=" + dataLang +
                          "&dir=" + dataDir + "&file=" + dataFile)
        
            print(refinedStr)

            try:
                urlretrieve(refinedStr, "sounds/" + str(word) + "-merriam.mp3")
            except Exception as e:
                print("Found mathcing url, however no sound was there")
            
        else:
            print("No match")

def grabSounds(words, site):

    if(site == "dictionary"):
        for word in words:
            grabSoundDict(word)
    elif(site == "oxford"):
        for word in words:
            grabSoundOxford(word)
    elif(site == "macmillan"):
        for word in words:
            grabSoundMacmill(word)
    elif(site == "cambridge"):
        for word in words:
            grabSoundCambridge(word)
    elif(site == "freedict"):
        for word in words:
            grabSoundFreeDict(word)
    elif(site == "collins"):
        for word in words:
            grabSoundCollins(word)
    else:
        print("Site not found: " + site)

def grabData(file):
    try:
        with open(file) as f:
            sites = f.readline().split()
            words = f.read().split()
            for site in sites:
                grabSounds(words, site)
    except Exception as e:
        print(e)
        
grabData("data.txt")

#grabSoundCollins("face")



















        

        
