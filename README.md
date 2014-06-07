CSSA Door State System
----------------------


This contains all of the code that runs the CSSA door state system.

There is an Arduino attached to a reed switch that prints out the voltage (high or low) over serial every 10 seconds.

A ruby program picks this up, and then sends the state (open or closed) to the primary server.

The main server is running on heroku at cssadoor.herokuapp.com.

The server is set up to return the status as the index in the form of JSON.

i.e. '''GET http://cssadoor.herokuapp.com/''' returns '''{"state":"open"}'''  (or whatever is happens to be)

Clients
-------

The simple cli one liner (requires python2):

'''
    curl -s 'http://cssadoor.herokuapp.com' | python2 -c 'import json,sys;obj=json.load(sys.stdin);print obj["state"]'
'''

Also check out the fancy angular web2.0 thingy in this repo.

