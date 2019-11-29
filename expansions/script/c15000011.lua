local m=15000011
local cm=_G["c"..m]
cm.name="UB粘黏·毒贝比"
function cm.initial_effect(c)
	--search  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000011,0))  
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O) 
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)  
	e1:SetCountLimit(1,15000011)  
	e1:SetTarget(c15000011.sptg)  
	e1:SetOperation(c15000011.spop)  
	c:RegisterEffect(e1)
	local e2=e1:Clone()  
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)  
	c:RegisterEffect(e2) 
end
function c15000011.spfilter1(c,e,tp)  
	return c:IsSetCard(0xf30) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE) and not c:IsCode(15000011)
end  
function c15000011.spfilter2(c)  
	return c:IsSetCard(0xf30) and c:IsType(TYPE_MONSTER) and not c:IsCode(15000011)
end  
function c15000011.sptg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then  
		local g=Duel.GetMatchingGroup(c15000011.spfilter1,tp,LOCATION_DECK,0,nil,e,tp)  
		return g:GetClassCount(Card.GetCode)>=3  
	end  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)  
end  
function c15000011.spop(e,tp,eg,ep,ev,re,r,rp)  
	local g=Duel.GetMatchingGroup(c15000011.spfilter2,tp,LOCATION_DECK,0,nil)  
	if g:GetClassCount(Card.GetCode)>=3 then  
		local cg=Group.CreateGroup()  
		for i=1,3 do  
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
			local sg=g:Select(tp,1,1,nil)  
			g:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())  
			cg:Merge(sg)  
		end  
		Duel.ConfirmCards(1-tp,cg)  
		Duel.ShuffleDeck(tp)  
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)  
		local tg=cg:Select(1-tp,1,1,nil)  
		local tc=tg:GetFirst()  
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then  
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)  
			Duel.ConfirmCards(1-tp,tc)
			cg:RemoveCard(tc)  
		end  
		Duel.SendtoGrave(cg,REASON_EFFECT)  
	end  
end 
