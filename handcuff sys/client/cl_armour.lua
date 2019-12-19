ESX          = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)


RegisterNetEvent('esx_armour:handcuff')
AddEventHandler('esx_armour:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then

      if IsHandcuffed then

        RequestAnimDict('mp_arresting')

        while not HasAnimDictLoaded('mp_arresting') do
          Citizen.Wait(100)
        end

        TaskPlayAnim(GetPlayerPed(player), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        SetEnableHandcuffs(GetPlayerPed(player), true)
        SetPedCanPlayGestureAnims(GetPlayerPed(player), false)
        FreezeEntityPosition(GetPlayerPed(player),  true)
        TriggerServerEvent('esx_armour:handcuffremove')
        ESX.ShowNotification('Tu a utlisé un serflex')

      else
        ESX.ShowNotification('Cette personne a déjà un serflex')

      end
    else
      ESX.ShowNotification('Aucun joueur à proximité')
    end

  end)
end)

RegisterNetEvent('esx_armour:cutting_pliers')
AddEventHandler('esx_armour:cutting_pliers', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
      if IsHandcuffed then
          ESX.ShowNotification('Cette personne n\'a pas de serflex')
      else

        ClearPedSecondaryTask(GetPlayerPed(player))
        SetEnableHandcuffs(GetPlayerPed(player), false)
        SetPedCanPlayGestureAnims(GetPlayerPed(player),  true)
        FreezeEntityPosition(GetPlayerPed(player), false)
        ESX.ShowNotification('Tu a enlever un serflex')

      end
    else
      ESX.ShowNotification('Aucun joueur à proximité')
    end

  end)
end)

