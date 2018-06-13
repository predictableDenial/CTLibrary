handleStats: (ins, currBalance, currPrice, currAssets) ->
	storage.startBalance ?= currBalance
	storage.startPrice ?= currPrice
	storage.startAssets ?= currAssets
	if storage.timeFollower
		storage.timeFollower++
	storage.timeFollower ?= 1
	warn "============================="
	debug "Day: #{storage.timeFollower}"
	debug "Start Balance: #{storage.startBalance}    Current Balance: #{currBalance}"
	debug "Start Assets: #{storage.startAssets}    Current Assets: #{currAssets}"
	debug "B&H: #{Math.round ((currPrice / storage.startPrice) - 1) * 100}%"
	debug "Bot: #{Math.round (((@portfolio.positions[ins.base()].amount + (@portfolio.positions[ins.asset()].amount * currPrice)) / storage.startBalance) - 1) * 100}%"
	warn "============================="
	
	#This function will print an output of bot stats to the console, generalized enough for any bot,
	#call once at the end of handle, pass in instrument, current account balance, current price, current available assets
	#example: handleStats(primaryTradingInstrument, currentValue, currentPrice, availableAssets)
