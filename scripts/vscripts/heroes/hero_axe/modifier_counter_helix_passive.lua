if modifier_counter_helix_passive == nil then
    modifier_counter_helix_passive = class({})
end

function modifier_counter_helix_passive:OnCreate()
	print("Passive Created")
end

function modifier_counter_helix_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACKED
	}
end

function modifier_counter_helix_passive:OnAttacked()
	print("OnAttacked")
	local parent = self:GetParent()
	local counter_helix = parent:FindAbilityByName("axe_counter_helix_custom")
	local trigger_chance = counter_helix:GetLevelSpecialValueFor("trigger_chance", (counter_helix:GetLevel() - 1))
	-- Randomly chosen id as I *think* this and the unit are what identifies an event for the pseudorandom system
	if not RollPseudoRandomPercentage(trigger_chance, 53591, parent) then
		return
	end
	
	print("Proc!")
	
	-- TODO stacks per prock to ability special
	--local active_modifier = parent:FindModifierByName("modifier_counter_helix_active")
	--if ~active_modifier then
	active_modifier = parent:AddNewModifier(parent, counter_helix, "modifier_counter_helix_active", {})
		--active_modifier:SetStackCount(100)
	--end
	--active_modifier:SetStackCount(active_modifier:GetStackCount() + 100)
end