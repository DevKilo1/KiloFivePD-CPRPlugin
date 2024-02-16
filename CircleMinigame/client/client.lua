local Result = nil
local NUI_status = false

RegisterNetEvent('CircleMinigame:client:openLockpick', function(circles,seconds,code)
    --StartLockPickCircle(circles,seconds) 
    local result = exports['CircleMinigame']:StartLockPickCircle(circles,seconds);
    TriggerEvent('CircleMinigame:client:openLockpick:Callback='..code,result)
end)

function StartLockPickCircle(circles, seconds)
    Result = nil
    NUI_status = true
    SendNUIMessage({
        action = 'start',
        value = circles,
		time = seconds,
    })
    while NUI_status do
        Wait(5)
        SetNuiFocus(NUI_status, false)
    end
    Wait(100)
    SetNuiFocus(false, false)
    return Result
end

RegisterNUICallback('fail', function()
        Result = false
        Wait(100)
        NUI_status = false
end)

RegisterNUICallback('success', function()
	Result = true
	Wait(100)
	NUI_status = false
    SetNuiFocus(false, false)
    return Result
end)
