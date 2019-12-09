--万圣魔女 森永Miu
function c81003002.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81003902)
	e1:SetTarget(c81003002.reptg)
	e1:SetValue(c81003002.repval)
	e1:SetOperation(c81003002.repop)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,81003002)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetTarget(c81003002.settg)
	e2:SetOperation(c81003002.setop)
	c:RegisterEffect(e2)
end
function c81003002.setfilter(c,e,tp,tid)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable(true) and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) and c:GetTurnID()==tid
end
function c81003002.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c81003002.setfilter(chkc,e,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c81003002.setfilter,tp,0,LOCATION_GRAVE,1,nil,e,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c81003002.setfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,tid)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c81003002.setop(e,tp,eg,ep,ev,re,r,rp)
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
function c81003002.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and (c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)) and not c:IsReason(REASON_REPLACE)
end
function c81003002.desfilter(c,e,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_ONFIELD) and c:IsType(TYPE_SPELL+TYPE_TRAP)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c81003002.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c81003002.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c81003002.desfilter,tp,LOCATION_ONFIELD,0,1,nil,e,tp) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c81003002.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,e,tp)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	end
	return false
end
function c81003002.repval(e,c)
	return c81003002.repfilter(c,e:GetHandlerPlayer())
end
function c81003002.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,81003002)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
