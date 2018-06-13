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

#example: getGeography(currentPrice, 96)
