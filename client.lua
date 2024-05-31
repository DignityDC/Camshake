local me = PlayerPedId()
local lastPos
local shakeGameplayCam = false

Citizen.CreateThread(function()
	local shake_counter1 = 0
	local shake_counter2 = 0
    
	while true do
		Citizen.Wait(100)
        if IsPlayerFreeAiming(PlayerId()) then   
            if IsPedAimingFromCover(me) then
                    Citizen.Wait(100)
                    shake_counter1 = shake_counter1 + 1
                    shake_counter2 = 0
                    if (shake_counter1 == 5) then 
                        ShakeGameplayCam('HAND_SHAKE', Config.shakecover)
                        shakeGameplayCam = true
                    end
                    if Config.debug then   
                        print("shakecover")
                    end  
            else
                if checkPlayerMovement() then
                    Citizen.Wait(10)
                    shake_counter2 = shake_counter2 + 1
                    shake_counter1 = 0
                    if (shake_counter2 == 5) then 
                        ShakeGameplayCam('HAND_SHAKE', Config.shakemovement)
                        shakeGameplayCam = true 
                    end
                    if Config.debug then   
                        print("shakemovement")
                    end  
                else
                    Citizen.Wait(100)
                    shake_counter1 = shake_counter1 + 1
                    shake_counter2 = 0
                    if (shake_counter1 == 5) then 
                        ShakeGameplayCam('HAND_SHAKE', Config.shakestill)
                        shakeGameplayCam = true  
                    end
                    if Config.debug then   
                        print("shakestill")
                    end 
                end
            end    
        else
            if shakeGameplayCam then 
                shake_counter1 = 0
                shake_counter2 = 0
                StopGameplayCamShaking(true) 
            end    
        end     
	end
end)

function checkPlayerMovement()
    local isMoving
    local currentPos = GetEntityCoords(me)
    if lastPos ~= nil then
        isMoving = (currentPos ~= lastPos)
    end
    --Citizen.Wait(100)
    lastPos = currentPos

    if isMoving then
        return true 
    else
        return false
    end
end
