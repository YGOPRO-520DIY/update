local m=15000059
local cm=_G["c"..m]
cm.name="色带神·犹格索托斯"
function cm.initial_effect(c)
	--synchro summon  
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x1f33),1)  
	c:EnableReviveLimit()
	--pendulum summon  
	aux.EnablePendulumAttribute(c,false)
	--change Pscale
	local e1=Effect.CreateEffect(c) 
	e1:SetType(EFFECT_TYPE_SINGLE)  
	e1:SetCode(EFFECT_CHANGE_LSCALE)  
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE) 
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c15000059.cpcon)
	e1:SetValue(c15000059.p1val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()  
	e2:SetCode(EFFECT_CHANGE_RSCALE)
	e2:SetValue(c15000059.p2val)
	c:RegisterEffect(e2)
	--when Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15000059,0)) 
	e3:SetCategory(CATEGORY_DISABLE)  
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)  
	e3:SetCode(EVENT_DESTROYED)  
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)  
	e3:SetRange(LOCATION_PZONE)
	e3:SetCondition(c15000059.spcon)
	e3:SetOperation(c15000059.spop)  
	c:RegisterEffect(e3)
	--Destroy 
	local e4=Effect.CreateEffect(c)  
	e4:SetDescription(aux.Stringid(15000059,1))  
	e4:SetCategory(CATEGORY_DESTROY)  
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)  
	e4:SetProperty(EFFECT_FLAG_DELAY)  
	e4:SetCountLimit(1,15000059)  
	e4:SetTarget(c15000059.srtg)  
	e4:SetOperation(c15000059.srop)  
	c:RegisterEffect(e4)
	-- Battle Damage
	local e5=Effect.CreateEffect(c)  
	e5:SetType(EFFECT_TYPE_SINGLE)  
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)  
	e5:SetValue(1)  
	c:RegisterEffect(e5)
	--Destroyed 
	local e6=Effect.CreateEffect(c)  
	e6:SetDescription(aux.Stringid(15000059,2))  
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)  
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)  
	e6:SetCode(EVENT_DESTROYED)  
	e6:SetCountLimit(1,15010059)  
	e6:SetCondition(c15000059.scon)  
	e6:SetOperation(c15000059.sop)  
	c:RegisterEffect(e6)
end
function c15000059.cpcon(e)  
	return Duel.IsExistingMatchingCard(nil,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,e:GetHandler())
end
function c15000059.p1val(e,tp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_PZONE,0,e:GetHandler())
	if g:GetCount()==0 then return 4 end
	local tc=g:GetFirst()
	if not tc:GetType(TYPE_PENDULUM) then return 4 end
	return tc:GetLeftScale()
end
function c15000059.p2val(e,tp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_PZONE,0,e:GetHandler())
	if g:GetCount()==0 then return 4 end
	local tc=g:GetFirst()
	if not tc:GetType(TYPE_PENDULUM) then return 4 end
	return tc:GetRightScale()
end
function c15000059.cfilter(c,tp)  
	return c:IsReason(REASON_EFFECT+REASON_BATTLE) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp  
end
function c15000059.spcon(e,tp,eg,ep,ev,re,r,rp)  
	return eg:IsExists(c15000059.cfilter,1,nil,tp)
end
function c15000059.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,aux.disfilter1,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()~=0 then 
		local tc=g:GetFirst()
		if c:IsFaceup() and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then 
			local e1=Effect.CreateEffect(e:GetHandler())  
			e1:SetType(EFFECT_TYPE_SINGLE)  
			e1:SetCode(EFFECT_DISABLE) 
			e1:SetCondition(c15000059.rcon) 
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)  
			tc:RegisterEffect(e1)  
			local e2=Effect.CreateEffect(e:GetHandler())  
			e2:SetType(EFFECT_TYPE_SINGLE)  
			e2:SetCode(EFFECT_DISABLE_EFFECT) 
			e2:SetCondition(c15000059.rcon) 
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)  
			tc:RegisterEffect(e2)
		end  
	end
end  
function c15000059.rcon(e)  
	return e:GetHandler():IsOnField() and e:GetHandler():IsFaceup()
end
function c15000059.srfilter(c)  
	return c:IsDestructable() 
end
function c15000059.srtg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.IsExistingMatchingCard(c15000059.srfilter,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c15000059.srfilter,tp,0,LOCATION_ONFIELD,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,2,0,LOCATION_ONFIELD)  
end
function c15000059.srop(e,tp,eg,ep,ev,re,r,rp)  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)  
	local g=Duel.SelectMatchingCard(tp,c15000059.srfilter,tp,LOCATION_ONFIELD,0,1,1,nil) 
	local ag=Duel.SelectMatchingCard(tp,c15000059.srfilter,tp,0,LOCATION_ONFIELD,1,1,nil) 
	if g:GetCount()>0 and ag:GetCount()>0 then  
		Group.Merge(g,ag)
		Duel.Destroy(g,REASON_EFFECT)  
	end  
end
function c15000059.scon(e,tp,eg,ep,ev,re,r,rp)  
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)  
end  
function c15000059.sfilter(c)  
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0xf33) and not c:IsCode(15000059) and (c:IsLocation(LOCATION_DECK) or c:IsLocation(LOCATION_HAND) or (c:IsLocation(LOCATION_EXTRA) and c:IsFaceup()))
end   
function c15000059.sop(e,tp,eg,ep,ev,re,r,rp) 
	local tp=e:GetHandlerPlayer() 
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_PZONE,LOCATION_PZONE,nil)
	if g:GetCount()~=0 then Duel.Destroy(g,REASON_EFFECT) end
	local ag=Duel.SelectMatchingCard(tp,c15000059.sfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_EXTRA,0,1,1,nil)
	if ag:GetCount()~=0 and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1)) then
		local tc=ag:GetFirst() 
		Duel.BreakEffect()  
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end  
end