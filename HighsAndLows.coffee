#fancy way of saying high(peak) and low(valley)

getGeography: (price, reset) ->
    storage.peak ?= price
    storage.valley ?= price
    
    if price < storage.valley
        storage.valley = price
    if price > storage.peak
        storage.peak = price
    
    if reset
        if storage.tick % reset == 0
            storage.peak = price
           	storage.valley = price

    #This function will find set the high or low of a given timeframe (or leave reset == null for unlimited timeframe)
    #call once at the start of handle before your trade logic, pass in the currentPrice and the reset timeframe,
	#ie: if running on 1hr periods, pass in 24 to reset every 1 day, if running on 15m periods, 96 will reset every 1 day
	#example: getGeography(currentPrice, 96)
