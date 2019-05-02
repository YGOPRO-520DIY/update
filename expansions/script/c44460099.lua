--古夕幻历-玉饰臻选
function c44460099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44460099+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c44460099.cost)
	e1:SetTarget(c44460099.target)
	e1:SetOperation(c44460099.activate)
	c:RegisterEffect(e1)
end
function c44460099.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c44460099.filter(c)
	return c:IsSetCard(0x677) and not c:IsForbidden() and c:IsType(TYPE_SPELL+TYPE_TRAP) 
	and not c:IsCode(44460099)
end
function c44460099.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460099.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>1 end
end
function c44460099.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460099.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
	    if  Duel.IsExistingMatchingCard(c44460099.filterd,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(44460099,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local sg=Duel.SelectMatchingCard(tp,c44460099.filterd,tp,LOCATION_HAND,0,1,1,nil)
			local sc=sg:GetFirst()
	        if sc then
     	    Duel.Summon(tp,sc,true,nil)
	        end
		end
	end
end
function c44460099.filterd(c)
	return c:IsLevelBelow(1) and c:IsType(TYPE_NORMAL) and c:IsSummonable(true,e)
end