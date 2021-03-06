# Creates a (persistent) ShareJS server
# Roughly copied from https://github.com/share/ShareJS/wiki/Getting-started

# See docs for options. {type: 'redis'} to enable persistance.
# Using special options from https://github.com/share/ShareJS/blob/master/src/server/index.coffee
options =
  db: {type: 'none'}
  browserChannel: {cors: '*'}
  staticPath: null
  # rest: null

# Lets try and enable redis persistance if redis is installed...
try
  Npm.require('redis')
  options.db = {type: 'redis'}
  Meteor._debug "ShareJS: Redis persistence is enabled."
catch e
  Meteor._debug "ShareJS: Redis module not found. Documents will be in-memory only."

# Grab the meteor connect server
server = __meteor_bootstrap__.app

# Attach the sharejs REST and Socket.io interfaces as middleware
sharejs = Npm.require('share').server
sharejs.attach(server, options);
