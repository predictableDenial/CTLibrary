
#===============================Standard template

###
  The script engine is based on CoffeeScript (http://coffeescript.org)
  The Cryptotrader API documentation is available at https://cryptotrader.org/api
###

trading = require "trading" #import core trading module
startingParameters = require "params" #import starting parameters module
talib = require "talib" #import technical indicators library

#initiate necessary variables
currentPrice = 0
availableCurrency = 0
availableAssets = 0
assetWorth = 0
currentAccountValue = 0

#any methods will go here
#...

init: -> #Init is called every time the bot is started
	#Initialization things go here
	info "Starting Bot..."
    
handle: -> #handle will run once per time period interval
	#All bot trading logic goes here
	primaryTradingInstrument = @data.instruments[0] #provides access to market data
	currentPrice = primaryTradingInstrument.price #you'll want this for most bot ordering and trading logic
	availableCurrency = @portfolio.positions[primaryTradingInstrument.base()].amount #gives the amount of currency available in the account
	availableAssets = @portfolio.positions[primaryTradingInstrument.asset()].amount #gives the amount of assets available in the account
	assetWorth = availableAssets * currentPrice #the current worth of the assets
	currentAccountValue = availableCurrency + assetWorth #the current total value of the account (assets + currency)
	storage.startingBalance ?= availableCurrency #the account balance that the bot was started at
	storage.startingPrice ?= currentPrice #the price that the asset was at when the bot was started
	storage.tick ?= 0 #has a multitude of uses based on time that has passed
    
	#logic checking if conditions are met in order to make a trade:
	#...
	
	
	storage.tick++ #will increment tick each time handle is run
    
onStop: -> #Called when the bot stops
	#closing statements/logic goes here
	warn "Bot has stopped"
    

#===============================Margin template
#to come



#===============================Multi-Pair template
#to come
