local plr = game.Players.LocalPlayer
local rootPart = plr.Character.HumanoidRootPart
local ws = game:GetService("Workspace")
local rStorage = game:GetService("ReplicatedStorage")
local remote = rStorage.Network.Instancing_FireCustomFromClient
local fishingGame = plr.PlayerGui._INSTANCES.FishingGame
local fishBar = fishingGame.GameBar.FishingBar
local fishingRod = ws[tostring(plr)].Model.Rod
local args = {
    [1] = "AdvancedFishing",
    [2] = "RequestCast",
    [3] = Vector3.new(1458.83544921875, 61.624916076660156, -4459.80908203125)
}
spawn(function()
    while wait() do
        if not autoFish then break end
        if not fishingRod:FindFirstChild("FishingLine") then
            remote:FireServer(unpack(args))
            wait(0.5)
        end
        if fishingRod:FindFirstChild("FishingLine") then
            while fishingRod:FindFirstChild("FishingLine") do
                if not autoFish then break end
                local attachment1 = fishingRod:FindFirstChild("FishingLine").Attachment1
                local bobber = attachment1.Parent
                local height = tonumber(bobber.CFrame.Position.Y)
                if height > 61.624916076660156 then
                    wait(0.1)
                elseif height == 61.624916076660156 then
                    wait(0.1)
                elseif height < 61.5 then
                    wait(0.1)
                    remote:FireServer("AdvancedFishing", "RequestReel")
                    for i = 1,10 do
                        remote:FireServer("AdvancedFishing", "Clicked")
                        task.wait(.1)
                    end
                end
                wait(0.1)
            end
        end
        wait(0.1)
    end
end)
