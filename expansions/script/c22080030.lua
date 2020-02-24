--宝具 遥远的理想乡
function c22080030.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_SZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c22080030.atkcon)
	e1:SetTarget(c22080030.tgtg)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c22080030.atkcon)
	e2:SetTarget(c22080030.tgtg)
	e2:SetValue(c22080030.indval)
	c:RegisterEffect(e2)
end
function c22080030.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xff9)
end
function c22080030.atkcon(e)
	return Duel.GetMatchingGroupCount(c22080030.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)>=1
end
function c22080030.tgtg(e,c)
	return c:IsSetCard(0xfff)
end
function c22080030.indval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
