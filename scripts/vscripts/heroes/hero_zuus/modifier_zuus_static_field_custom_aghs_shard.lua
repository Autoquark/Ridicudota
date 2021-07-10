if modifier_zuus_static_field_custom_aghs_shard == nil then
    modifier_zuus_static_field_custom_aghs_shard = class({})
end

function OnCreated(keys)
	if IsServer() then
		DebugPrint("Started thinking")
		self:StartIntervalThink( 0.1 )
	end
end

function modifier_zuus_static_field_custom_aghs_shard:OnCreated(keys)
	if IsServer() then
		DebugPrint("Started thinking")
		self:StartIntervalThink( 0.1 )
	end
end

function modifier_zuus_static_field_custom_aghs_shard:OnIntervalThink()
	local caster = self:GetParent()
	local lightningBolt = caster:FindAbilityByName("zuus_lightning_bolt")
	
	-- Check if we can use the ability
	if lightningBolt:GetLevel() == 0 
		or caster:IsSilenced() 
		or caster:PassivesDisabled() 
		or not caster:HasModifier("modifier_item_aghanims_shard") then
		return
	end
	
	-- Look for a target
	local enemyTeam = GetOppositeTeam(caster:GetTeamNumber()) 
	local validTargets = {}
	for i=1,PlayerResource:GetPlayerCountForTeam(enemyTeam) do
		local playerId = PlayerResource:GetNthPlayerIDOnTeam(enemyTeam, i)
		local hero = PlayerResource:GetSelectedHeroEntity(playerId)
		if hero and hero:IsAlive() and not hero:IsMagicImmune() then
			table.insert(validTargets, hero)
		end
	end

	if table.getn(validTargets) == 0 then
		return
	end
	
	local targetIndex = RandomInt(1, table.getn(validTargets))
	local target = validTargets[targetIndex]
	
	local staticFieldCustom = caster:FindAbilityByName("zuus_static_field_custom")
	if staticFieldCustom:IsFullyCastable() then
		DebugPrint("Casting static field custom")
		
		caster:SetCursorCastTarget(target)
		staticFieldCustom:OnSpellStart()
		
		local level = staticFieldCustom:GetLevel()
		staticFieldCustom:StartCooldown(staticFieldCustom:GetEffectiveCooldown(level))
	end
end

function modifier_zuus_static_field_custom_aghs_shard:GetAttributes()
	-- Is is really plus?
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end