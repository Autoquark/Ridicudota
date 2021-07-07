zuus_static_field_custom = class ({})
LinkLuaModifier( "modifier_zuus_static_field_custom_aghs_shard", "heroes/hero_zuus/modifier_zuus_static_field_custom_aghs_shard", LUA_MODIFIER_MOTION_NONE )

function zuus_static_field_custom:OnUpgrade()
	DebugPrint("static_field_custom:OnUpgrade")
	local caster = self:GetCaster()
	caster:FindAbilityByName("zuus_static_field"):SetLevel(self:GetLevel())
	
	if not caster:HasModifier("modifier_zuus_static_field_custom_aghs_shard") then
		caster:AddNewModifier(caster, self, "modifier_zuus_static_field_custom_aghs_shard", {})
	end
end

function OnUpgrade(keys)
	DebugPrint("OnUpgrade")
	local caster = keys.caster
	local static_field = keys.ability
	caster:FindAbilityByName("zuus_static_field"):SetLevel(static_field:GetLevel())
	
	--if not caster:HasModifier("modifier_zuus_static_field_custom_aghs_shard") then
	--	caster:AddNewModifier(caster, self, "modifier_zuus_static_field_custom_aghs_shard", --{})
	--end
end

--function zuus_static_field_custom:GetBehavior()
--	if(not self:HasModifier("modifier_item_aghanims_shard")) then
--		return self.BaseClass:GetBehavior()
--	end
	
--	return self.BaseClass:GetBehavior() | DOTA_ABILITY_BEHAVIOR_IMMEDIATE
--end

function OnSpellStart(keys)
	local caster = keys.caster
	local lightningBolt = caster:FindAbilityByName("zuus_lightning_bolt")
	local staticFieldCustom = caster:FindAbilityByName("zuus_static_field_custom")
	local cooldown = staticFieldCustom:GetCooldown( staticFieldCustom:GetLevel() )
	local target = keys.target
	
	DebugPrint("Casting auto lightning bolt on " .. target:GetUnitName())
	--caster:CastAbilityOnTarget(target, lightningBolt, caster:GetPlayerOwnerID())
	caster:SetCursorCastTarget(target)
	lightningBolt:OnSpellStart()
end

function zuus_static_field_custom:OnSpellStart(keys)
	local caster = self:GetCaster()
	local lightningBolt = caster:FindAbilityByName("zuus_lightning_bolt")
	local staticFieldCustom = caster:FindAbilityByName("zuus_static_field_custom")
	local cooldown = staticFieldCustom:GetCooldown( staticFieldCustom:GetLevel() )
	
	if lightningBolt:IsFullyCastable() then
		DebugPrint("Casting auto lightning bolt on " .. keys.target:GetUnitName())
		caster:CastAbilityOnTarget(keys.target, lightningBolt, caster:GetPlayerOwnerID())
	end
end