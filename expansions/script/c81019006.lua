--tricoro·市原仁奈
function c81019006.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c81019006.tgtg)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
	c:RegisterEffect(e2)
	--force mzone
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_USE_MZONE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_EXTRA,LOCATION_EXTRA)
	e3:SetCondition(c81019006.frccon)
	e3:SetValue(c81019006.frcval)
	c:RegisterEffect(e3)
end
function c81019006.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
function c81019006.frccon(e)
	return e:GetHandler():GetSequence()>4
end
function c81019006.frcval(e,c,fp,rp,r)
	return e:GetHandler():GetLinkedZone()
end