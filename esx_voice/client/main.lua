--[[
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
]]
local voice = {default = 10.0, shout = 70.0, whisper = 5.0, current = 0, level = nil} -- this is what youl want change the rest is for the hud

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
		
		--[[SendNUIMessage({
     		heal = 66
     	});
		]]
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
		
		--[[SendNUIMessage({
     		heal = 100
     	});
		]]
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
		
		--[[SendNUIMessage({
     		heal = 33
     	});
		]]
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if GetLastInputMethod(2) then
			if IsControlPressed(2, 21) and IsControlJustPressed(2, 74) then
				voice.current = (voice.current + 1) % 3
				if voice.current == 0 then
					NetworkSetTalkerProximity(voice.default)
					
					--[[SendNUIMessage({
						heal = 66
					});]]
					
				elseif voice.current == 1 then
					NetworkSetTalkerProximity(voice.shout)
					
					--[[SendNUIMessage({
						heal = 100
					});]]
					
				elseif voice.current == 2 then
					NetworkSetTalkerProximity(voice.whisper)
					
					--[[SendNUIMessage({
						heal = 33
					});]]
					
				end
			end
		end
		
		--[[
		if voice.current == 0 then
									SendNUIMessage({
     		heal = 66
     	});
		elseif voice.current == 1 then
					SendNUIMessage({
     		heal = 100
     	});
		elseif voice.current == 2 then
									SendNUIMessage({
     		heal = 33
     	});
		end
		
		
		if NetworkIsPlayerTalking(PlayerId()) then
			SendNUIMessage({talking = true})

		elseif not NetworkIsPlayerTalking(PlayerId()) then
			SendNUIMessage({talking = false})
		end
		
		]]
	end
end)
