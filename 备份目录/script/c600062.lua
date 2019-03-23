--圣诞信使 礼物魔女
function c600062.initial_effect(c)
	aux.AddLinkProcedure(c,c600062.lfilter,1,1) 
	c:EnableReviveLimit()  
	--activate field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600062,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,600062)
	e1:SetCondition(c600062.actcon)
	e1:SetTarget(c600062.acttg)
	e1:SetOperation(c600062.actop)
	c:RegisterEffect(e1)
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600062,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,6000062)
	e2:SetCondition(c600062.poscon)
	e2:SetCost(c600062.poscost)
	e2:SetTarget(c600062.postg)
	e2:SetOperation(c600062.posop)
	c:RegisterEffect(e2) 
end
function c600062.lfilter(c)
	return c:IsSetCard(0x600)
end
function c600062.actcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end 
function c600062.filter(c,tp)
	return c:IsCode(600064) and c:GetActivateEffect():IsActivatable(tp)
end
function c600062.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600062.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp) 
	end
end
function c600062.actop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600062,2))
	local tc=Duel.SelectMatchingCard(tp,c600062.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
		Duel.BreakEffect()
	end
end
function c600062.poscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c600062.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c600062.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,tp,0)
end
function c600062.posop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_FACEDOWN)
	local g=Duel.SelectMatchingCard(1-tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
	   Duel.HintSelection(g)
	   Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end