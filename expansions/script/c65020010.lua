--幻念的苍青天
function c65020010.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--cost
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCondition(c65020010.mtcon)
	e1:SetTarget(c65020010.mttg)
	e1:SetOperation(c65020010.mtop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_HAND_LIMIT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(99)
	c:RegisterEffect(e2)
	 --change effect type
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(65020010)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(1,0)
	c:RegisterEffect(e3)
end
function c65020010.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c65020010.remtgfil(c)
	return c:IsSetCard(0x9da1) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c65020010.remtgfil2(c)
	return c:IsSetCard(0x9da1) and c:IsType(TYPE_MONSTER) 
end
function c65020010.thtgfil(c)
	return c:IsSetCard(0x9da1) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c65020010.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c65020010.remtgfil,tp,LOCATION_GRAVE,0,nil)>0 and Duel.GetMatchingGroupCount(c65020010.remtgfil,tp,LOCATION_GRAVE,0,nil)==Duel.GetMatchingGroupCount(c65020010.remtgfil2,tp,LOCATION_GRAVE,0,nil) and Duel.IsExistingMatchingCard(c65020010.thtgfil,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(c65020010.remtgfil,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function c65020010.mtop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c65020010.remtgfil2,tp,LOCATION_GRAVE,0,nil)
	local count=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if count>0 and count==g:GetCount() then
		local thg=Duel.SelectMatchingCard(tp,c65020010.thtgfil,tp,LOCATION_DECK,0,1,count,nil)
		if thg:GetCount()>0 then
			if Duel.SendtoHand(thg,tp,REASON_EFFECT)~=0 then
				Duel.ConfirmCards(1-tp,thg)
				Duel.BreakEffect()
				Duel.Destroy(e:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c65020010.indcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_STANDBY 
end