handleStats: (ins, currBalance, currPrice, currAssets, botType) ->
	storage.startBalance ?= currBalance
	storage.startPrice ?= currPrice
	storage.startAssets ?= currAssets
	sellOrdersAmount = 0
	buyOrdersAmount = 0
	if storage.timeFollower
		storage.timeFollower++
	storage.timeFollower ?= 1
	if botType == 'trading'
	    i = 0
	    while i < trading.getActiveOrders().length
	        if trading.getActiveOrders()[i].side == 'sell'
	            sellOrdersAmount += (trading.getActiveOrders()[i].amount)
	        if trading.getActiveOrders()[i].side == 'buy'
	            buyOrdersAmount += (trading.getActiveOrders()[i].amount)
	            buyOrdersPrice = trading.getActiveOrders()[i].price
	        i++
	else if botType == 'margin'
	    info "bot type is margin, not finished yet"
	warn "============================="
	debug "Day: #{Math.round((storage.timeFollower / 1440) * 10) / 10}"
	debug "Start #{ins.base()}: #{storage.startBalance}  |  Current #{ins.base()}: #{currBalance}"
	debug "Start #{ins.asset()}: #{storage.startAssets}  |  Current #{ins.asset()}: #{currAssets}"
	info "Total Account Value: #{currBalance + (currAssets * currPrice) + (sellOrdersAmount * currPrice) + (buyOrdersAmount * buyOrdersPrice)}"
	debug "B&H Performance: #{Math.round((((currPrice / storage.startPrice) - 1) * 100) * 100) / 100}%"
	info "Bot Performance: #{Math.round(((((@portfolio.positions[ins.base()].amount + (@portfolio.positions[ins.asset()].amount * currPrice) + (sellOrdersAmount * currPrice) + (buyOrdersAmount * buyOrdersPrice)) / storage.startBalance) - 1) * 100) * 100) / 100}%"
	warn "============================="
	
	#This function will print an output of bot stats to the console, generalized enough for any bot.
	#call once at the end of handle, pass in instrument, current account balance, current price, current available assets,
	#and the type of bot ('trading' or 'margin')
	#example: handleStats(primaryTradingInstrument, currentValue, currentPrice, availableAssets, 'trading')
