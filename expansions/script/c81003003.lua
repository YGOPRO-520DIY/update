--约会 森永Miu
function c81003003.initial_effect(c)
	--fusion material
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsRace,RACE_CYBERSE),3,true)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c81003003.atkval)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,81003003)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(c81003003.setcost)
	e2:SetTarget(c81003003.settg)
	e2:SetOperation(c81003003.setop)
	c:RegisterEffect(e2)
end
function c81003003.atkfilter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c81003003.atkval(e,c)
	return Duel.GetMatchingGroupCount(c81003003.atkfilter1,c:GetControler(),0,LOCATION_GRAVE+LOCATION_REMOVED,nil)*200
end
function c81003003.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsReleasable()
end
function c81003003.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81003003.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c81003003.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c81003003.setfilter(c,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable(true) and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
end
function c81003003.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_REMOVED) and c81003003.setfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c81003003.setfilter,tp,0,LOCATION_REMOVED,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c81003003.setfilter,tp,0,LOCATION_REMOVED,1,1,nil,tp)
end
function c81003003.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
		local e0=Effect.CreateEffect(e:GetHandler())
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e0:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e0:SetValue(LOCATION_REMOVED)
		tc:RegisterEffect(e0,true)
		if tc:IsType(TYPE_QUICKPLAY) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e1:SetCode(EFFECT_QP_ACT_IN_SET_TURN)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
		if tc:IsType(TYPE_TRAP) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
		end
	end
end
