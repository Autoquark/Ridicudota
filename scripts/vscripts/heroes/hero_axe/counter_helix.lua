axe_counter_helix_custom = class ({})
LinkLuaModifier( "modifier_counter_helix_passive", "heroes/hero_axe/modifier_counter_helix_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_counter_helix_active", "heroes/hero_axe/modifier_counter_helix_active", LUA_MODIFIER_MOTION_NONE )

--[[function axe_counter_helix_custom:OnUpgrade()
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_counter_helix_passive") then
		caster:AddNewModifier(caster, self, "axe_counter_helix_passive", {})
	end
end--]]

function axe_counter_helix_custom:GetIntrinsicModifierName()
	return "modifier_counter_helix_passive"
end