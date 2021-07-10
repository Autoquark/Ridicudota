if modifier_counter_helix_active == nil then
    modifier_counter_helix_active = class({})
end

local THINK_INTERVAL = 0.1
local DECAY_FACTOR_PER_SECOND = 0.75
local DURATION_FROM_SINGLE_PROC = 1
local STACKS_PER_PROC = 100
local MIN_STACKS = STACKS_PER_PROC * DECAY_FACTOR_PER_SECOND ^ DURATION_FROM_SINGLE_PROC

function modifier_counter_helix_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE
	}
end

function modifier_counter_helix_active:OnCreated(keys)
	print("Helix created")
	self:StartIntervalThink(THINK_INTERVAL)
	self:SetStackCount(STACKS_PER_PROC)
	self.timeToNextDamageInstance = 0
end

function modifier_counter_helix_active:OnRefreshed()
	print("Helix refreshed")
	self:SetStackCount(self:GetStackCount() + STACKS_PER_PROC)
end

function modifier_counter_helix_active:OnIntervalThink()
	-- Apply exponential decay to stacks
	local stackCount = self:GetStackCount();
	self:SetStackCount(stackCount * DECAY_FACTOR_PER_SECOND ^ THINK_INTERVAL)
	
	if self:GetStackCount() <= MIN_STACKS then
		self:Destroy()
	end
	
	-- Check if it's time to deal damage
	
end

function modifier_counter_helix_active:GetOverrideAnimationRate()
	return self:GetStackCount() / MIN_STACKS
end