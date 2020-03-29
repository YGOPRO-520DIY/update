local m=15000043
local cm=_G["c"..m]
cm.name="色带的仆从·拜亚基"
function cm.initial_effect(c)
	--pendulum summon  
	aux.EnablePendulumAttribute(c)
	--when spsummon  
	local e1=Effect.CreateEffect(c)  
	e1:SetCategory(CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetRange(LOCATION_PZONE)  
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)  
	e1:SetCountLimit(1,15000043)  
	e1:SetCondition(c15000043.spcon1)  
	e1:SetOperation(c15000043.spop1)  
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)  
	e2:SetType(EFFECT_TYPE_FIELD)  
	e2:SetCode(EFFECT_SPSUMMON_PROC)  
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)  
	e2:SetRange(LOCATION_HAND)  
	e2:SetCountLimit(1,15010043)  
	e2:SetCondition(c15000043.sdcon)
	c:RegisterEffect(e2)
	--destroy  
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)  
	e3:SetType(EFFECT_TYPE_IGNITION)  
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)  
	e3:SetRange(LOCATION_MZONE)  
	e3:SetCountLimit(1,15020043)  
	e3:SetTarget(c15000043.destg)  
	e3:SetOperation(c15000043.desop)  
	c:RegisterEffect(e3)
end
function c15000043.c1filter(c,tp)  
	return c:IsFaceup() and c:IsSetCard(0xf33) and c:GetSummonPlayer()==tp  
end  
function c15000043.c2filter(c)  
	return c:IsSetCard(0xf33) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(15000043)
end  
function c15000043.spcon1(e,tp,eg,ep,ev,re,r,rp)  
	return eg:IsExists(c15000043.c1filter,1,nil,tp) and Duel.IsExistingMatchingCard(c15000043.c2filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,nil)
end
function c15000043.spop1(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)  
		local g=Duel.SelectMatchingCard(tp,c15000043.c2filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,1,1,nil)  
		if g:GetCount()>0 then  
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end  
end
function c15000043.c3filter(c)  
	return c:IsType(TYPE_PENDULUM) and c:IsFaceup()
end 
function c15000043.sdcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c15000043.c3filter,e:GetHandlerPlayer(),LOCATION_PZONE,0,nil)
	if g:GetCount()~=2 then return false end
	local cc=g:GetFirst()
	local lsc=cc:GetLeftScale()
	local dc=g:GetNext()
	local l2sc=dc:GetLeftScale()
	return (lsc==l2sc or lsc==l2sc-1 or lsc==l2sc+1) and Duel.GetLocationCount(e:GetHandlerPlayer(),LOCATION_MZONE)>0 
end
function c15000043.desfilter(c,e,tp,ft)
	return c:IsFaceup() and c:IsSetCard(0xf33) and c:IsDestructable() and (ft>0 or c:GetSequence()<5)  
		and Duel.IsExistingMatchingCard(c15000043.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetCode())
end  
function c15000043.spfilter(c,e,tp,code)  
	return c:IsSetCard(0xf33) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP) and not c:IsCode(code) and c:IsFaceup() and c:IsType(TYPE_PENDULUM) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end  
function c15000043.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)  
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and chkc:IsControler(tp) and c15000043.desfilter(chkc,e,tp,ft) end  
	if chk==0 then return ft>-1 and Duel.IsExistingTarget(c15000043.desfilter,tp,LOCATION_PZONE,0,1,e:GetHandler(),e,tp,ft) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)  
	local g=Duel.SelectTarget(tp,c15000043.desfilter,tp,LOCATION_PZONE,0,1,1,e:GetHandler(),e,tp,ft)  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end  
function c15000043.desop(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then 
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true) 
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
		local sg=Duel.SelectMatchingCard(tp,c15000043.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetCode())
		if sg:GetCount()>0 then  
			Duel.BreakEffect()  
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end  
	end
end
