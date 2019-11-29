--朱星曜兽-柳土獐
function c21520124.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520124,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c21520124.spcon)
	e1:SetTarget(c21520124.sptg)
	e1:SetOperation(c21520124.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--to hand or set
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(21520124,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c21520124.condition)
	e4:SetTarget(c21520124.target)
	e4:SetOperation(c21520124.operation)
	c:RegisterEffect(e4)
end
function c21520124.filter(c,e,tp)
	return c:IsSetCard(0x491) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(4)
end
function c21520124.effectfilter(c)
	return c:IsCode(21520133) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21520124.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21520124.effectfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
end
function c21520124.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c21520124.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c21520124.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c21520124.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,LOCATION_GRAVE)
end
function c21520124.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c21520124.thfilter(c)
	return (c:IsAbleToHand() or c:IsSSetable()) and c:IsSetCard(0x491) and c:IsType(TYPE_TRAP)
end
function c21520124.condition(e,tp,eg,ep,ev,re,r,rp)
	return r&REASON_BATTLE==REASON_BATTLE or r&REASON_EFFECT==REASON_EFFECT
end
function c21520124.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520124.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,0,0)
end
function c21520124.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520124.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
	if g:GetCount()>0  then
		local b1=Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		local b2=g:FilterCount(Card.IsSSetable,nil)>0
		local b3=g:FilterCount(Card.IsAbleToHand,nil)>0
		local ops=2
		if (b1 and b2) and b3 then 
			ops=Duel.SelectOption(tp,aux.Stringid(21520124,2),aux.Stringid(21520124,3))
		elseif (b1 and b2) and not b3 then 
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(21520124,3))
			ops=1
		elseif not (b1 and b2) and b3 then 
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(21520124,2))
			ops=0
		end
		if ops==0 then 
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		elseif ops==1 then 
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:FilterSelect(tp,Card.IsSSetable,1,1,nil)
			Duel.SSet(tp,sg)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
