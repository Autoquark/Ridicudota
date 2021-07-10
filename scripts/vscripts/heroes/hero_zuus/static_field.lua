zuus_static_field_custom = class ({})
LinkLuaModifier( "modifier_zuus_static_field_custom_aghs_shard", "heroes/hero_zuus/modifier_zuus_static_field_custom_aghs_shard", LUA_MODIFIER_MOTION_NONE )

function zuus_static_field_custom:OnUpgrade()
	DebugPrint("OnUpgrade")
	local caster = self:GetCaster()
	caster:FindAbilityByName("zuus_static_field"):SetLevel(self:GetLevel())
	
	-- Modifier to implement aghs shard, apply on learning the ability but it will not actually do anything unless we have shard
	if not caster:HasModifier("modifier_zuus_static_field_custom_aghs_shard") then
		caster:AddNewModifier(caster, self, "modifier_zuus_static_field_custom_aghs_shard", {})
	end
end

function zuus_static_field_custom:OnSpellStart(keys)
	local caster = self:GetCaster()
	local lightningBolt = caster:FindAbilityByName("zuus_lightning_bolt")
	local staticFieldCustom = caster:FindAbilityByName("zuus_static_field_custom")
	local cooldown = staticFieldCustom:GetCooldown( staticFieldCustom:GetLevel() )
	local target = self:GetCursorTarget()
	
	DebugPrint("Casting auto lightning bolt on " .. target:GetUnitName())
	caster:SetCursorCastTarget(target)
	lightningBolt:OnSpellStart()
end

function zuus_static_field_custom:GetCooldown(level)
	local caster = self:GetCaster()
	if caster:HasModifier("modifier_item_aghanims_shard") then
		return self:GetLevelSpecialValueFor("cooldown", (self:GetLevel() - 1))
	end
	return 0
end