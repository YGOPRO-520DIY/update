--微妙世界
function c81040047.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcGreater2(c,c81040047.ritual_filter,LOCATION_HAND+LOCATION_DECK,nil,c81040047.mfilter)
	e1:SetCountLimit(1,81040047+EFFECT_COUNT_CODE_OATH)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c81040047.reptg)
	e1:SetValue(c81040047.repval)
	e1:SetOperation(c81040047.repop)
	c:RegisterEffect(e1)
end
function c81040047.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x81c)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c81040047.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c81040047.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c81040047.repval(e,c)
	return c81040047.repfilter(c,e:GetHandlerPlayer())
end
function c81040047.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
function c81040047.ritual_filter(c)
	return c:IsSetCard(0x81c) and c:IsRace(RACE_CYBERSE)
end
function c81040047.mfilter(c)
	return c:IsType(TYPE_RITUAL)
end
