--电子超量立场
function c600042.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1093))
	c:RegisterEffect(e2)
	--can not be targe
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600042,0))
	e3:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c600042.tgtg)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--remove overlay replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(600042,1))
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)	
	e4:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c600042.rocon)
	e4:SetOperation(c600042.roop)
	c:RegisterEffect(e4)
	--add code
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(c600042.tgtg)
	e5:SetCode(EFFECT_CHANGE_CODE)
	e5:SetValue(70095154)
	c:RegisterEffect(e5)
end
function c600042.rocon(e,tp,eg,ep,ev,re,r,rp)
if ep~=tp  then return false end
	return e:GetHandler():GetFlagEffect(600042+ep)==0
		and bit.band(r,REASON_COST)~=0 and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_XYZ)
		and re:GetHandler():IsSetCard(0x1093)
end
function c600042.roop(e,tp,eg,ep,ev,re,r,rp)
	local ct=bit.band(ev,0xffff)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	e:GetHandler():RegisterFlagEffect(600042+ep,RESET_PHASE+PHASE_END,0,1)
end
function c600042.tgtg(e,c)
	return c:IsRace(RACE_MACHINE) and c:IsType(TYPE_FUSION)
end