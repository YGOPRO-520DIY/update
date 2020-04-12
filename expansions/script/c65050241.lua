--闪耀侍者 耀彩恋之茶晶
function c65050241.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,true)
	--peffect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,65050241)
	e1:SetTarget(c65050241.ptg)
	e1:SetOperation(c65050241.pop)
	c:RegisterEffect(e1)
	--flover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COIN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050242)
	e2:SetCost(c65050241.flvcost)
	e2:SetTarget(c65050241.flvtg)
	e2:SetOperation(c65050241.flvop)
	c:RegisterEffect(e2)
	--wudixiaoguo
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCountLimit(1,65050243)
	e3:SetCondition(c65050241.con)
	e3:SetTarget(c65050241.tg)
	e3:SetOperation(c65050241.op)
	c:RegisterEffect(e3)
end
c65050241.toss_coin=true
function c65050241.ptgfilter(c)
	return (c:IsSetCard(0x5da8) or c:IsSetCard(0x9da9)) and c:IsAbleToGrave()
end
function c65050241.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050241.ptgfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler()) and Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_ONFIELD)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,tp,2)
end
function c65050241.pop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c65050241.ptgfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,e:GetHandler())
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		Duel.Draw(tp,2,REASON_EFFECT)
		Duel.BreakEffect()
		 local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(6)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		c:RegisterEffect(e2)
	end
end

function c65050241.flvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoHand(g,1-tp,REASON_COST)
end
function c65050241.flvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>=3 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetChainLimit(aux.FALSE)
end
function c65050241.flvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=Duel.TossCoin(tp,1)
	if res==1 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>=3 then
	   local g=Duel.GetMatchingGroup(Card.IsCanBeSpecialSummoned,1-tp,LOCATION_DECK,0,nil,e,0,tp,false,false,POS_FACEUP,tp)
		if g:GetClassCount(Card.GetCode)>=3 then
			local sg=g:SelectSubGroup(1-tp,aux.dncheck,false,3,3)
			if #sg>0 then
				Duel.ConfirmCards(tp,sg)
				local tc=sg:Select(tp,1,1,nil):GetFirst()
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
			Duel.ShuffleDeck(1-tp)
		end
	end
end

function c65050241.con(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_HAND+LOCATION_ONFIELD) and c:IsReason(REASON_EFFECT)
end
function c65050241.filter(c,e,tp)
	return (c:IsSetCard(0x5da8) or c:IsSetCard(0x9da9)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c65050241.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050241.filter,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c65050241.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<=0 then return end
	local g=Duel.SelectMatchingCard(tp,c65050241.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
