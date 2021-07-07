function TriggerCheck(keys)
	local caster = keys.caster
	local lightningBolt = caster:FindAbilityByName("zuus_lightning_bolt")
	local aghsAbility = caster:FindAbilityByName("zuus_aghs_shard_custom")
	local cooldown = aghsAbility:GetCooldown( aghsAbility:GetLevel() )
	-- TODO: Probably not IsFullyCastable for lightningBolt, maybe not for shard either
	if aghsAbility:IsFullyCastable() and lightningBolt:IsFullyCastable() then
		
		--aghsAbility:StartCooldown( cooldown )
	end
end

function Cast(keys)
	local target = keys.target
	local lightningBolt = caster:FindAbilityByName("zuus_lightning_bolt")
	caster:CastAbilityImmediately(target, lightningBolt, caster:GetPlayerOwnerID())
end