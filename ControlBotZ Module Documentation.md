So you wanted to make your own bot control script huh? Well here you will learn how to make the base of your own bot control script using ControlBotZ Module.

We start with this first:
```lua
local botz = loadstring(game:HttpGet("https://raw.githubusercontent.com/sixpennyfox4/ControlBotZ/refs/heads/main/ControlBotZ%20Module.lua"))()
```

Then you will need to set things like prefix, username etc:
```lua
botz.Username = "" -- Username here
botz.Prefix = "."
botz.Bots = {"bot1", "bot2"} -- Just example, change them with the real bots display names
```

Now lets get into the functionality.
You will need to have this at the end of your code for example:
```lua
function mainFunction(player, message)
  -- blah blah
end

botz:Init(mainFunction)
```

This will basically make it so when someone chats it will connect to the given function returning 2 args: player, message

Now after you got this we need to assign index to each bot. We can do this:
```lua
local botIndex = botz:GetIndex()
```

There is also dynamicBotSystem which will update index if a bot leaves(put at after botz:Init()):
```lua
botz:dynamicBotSystem(botIndex)
```

Now lets get into the main function.
First to see if the message is specific text we can do this:
```lua
function mainFunction(player, message)
  if message == botz.Prefix .. "test" then -- So you need to type .test instead of just test
    botz:Chat("YEYYYYYYYY")
  end
end
```
Now if the message is '.test' every bot will chat 'YEYYYYYYYY'.
I recommend doing this at the start of the function:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) then
    return
  end

  if message == botz.Prefix .. "test" then
    botz:Chat("YEYYYYYYYY")
  end
end
```
This will stop the function if the player doesnt have right permission to use commands.

How to get args? Ik you wont just make simple commands that dont need args. So here is how to get args:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) then
    return
  end
  local args = botz:GetArgs(message) -- Get the args from the message 
  if args[1] == botz.Prefix .. "test" then
    botz:Chat("You said: " .. args[2])
  end
end
```

Now if you chat '.test hello' the bots will chat 'You said: hello'.
Now lets say you dont want all the bots to do something. Well i got you:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) then
    return
  end
  local args = botz:GetArgs(message) -- Get the args from the message

  if args[1] == botz.Prefix .. "test" then
    botz:firstBotDo(function()
      botz:Chat("You said: " .. args[2]) -- Only the first bot will do this
    end)
  end
end
```

Now lets say you run the script on the Controller acc too. To make it not run on account that isnt a bot we can do this:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) and not botz:IsABot() then -- So if local player isnt a bot
    return
  end
  local args = botz:GetArgs(message) -- Get the args from the message 
  if args[1] == botz.Prefix .. "test" then
    botz:firstBotDo(function()
      botz:Chat("You said: " .. args[2]) -- Only the first bot will do this
    end)
  end
end
```

Now if we run it on Controller acc it wont continue the script.
Now you would want to specify specific bots to run command when chatted. Its very simple:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) and not botz:IsABot() then -- So if local player isnt a bot
    return
  end
  local args = botz:GetArgs(message) -- Get the args from the message 
  if args[1] == botz.Prefix .. "test" then
    function codeNoShit()
      botz:Chat("You said: " .. args[2])
    end

    botz:specifyBots(args, 3, codeNoShit) -- arg table, start index to look for bots, callback
  end
end
```
If we chat '.test' all bots will chat but we can now specify bots by typing '.test 3 1'. Now only bot 3 and 1 will run the test command.

Now you would want to make some commands owner and admin only so whitelisted players wont be able to use them:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) and not botz:IsABot() then -- So if local player isnt a bot
    return
  end
  local args = botz:GetArgs(message) -- Get the args from the message 
  if args[1] == botz.Prefix .. "deletesystem32" then
    if not botz:isOwnerOrAdmin(player.Name) then -- Stop the command if player is not owner or admin so whitelisted players cant use it
      return
    end

    botz:Chat("Deleting system32!")
  end
end
```

There is also isR15 function which will return true or specific val if avatar is r15 for example:
```lua
botz:isR15(WHATTORETURNIFTRUE, WHATTORETURNIFFALSE)
```
Now if you dont specify arguaments it will just return true or false.

Now there is a thing to make your life easier. You wouldnt want to type full player name right? Thats why you can do this:
```lua
function mainFunction(player, message)
  if not botz:isWhitelisted(player.Name) and not botz:isOwnerOrAdmin(player.Name) and not botz:IsABot() then -- So if local player isnt a bot
    return
  end
  local args = botz:GetArgs(message) -- Get the args from the message 
  if args[1] == botz.Prefix .. "whatsthename" then
    local targetName = botz:getFullPlayerName(args[2])

    if targetName then
      botz:Chat("Name: " .. targetName)
    else
      botz:Chat("Target player not found!")
  end
end
```

There are these things that are self explanatory: botz:removeAdmin(PLAYERNAME) botz:addAdmin(PLAYERNAME) ; botz:removeWhitelist(PLAYERNAME), botz:addWhitelist(PLAYERNAME)

# Now you are ready to make your own bot script YEYYY.
