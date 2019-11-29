--朱星曜兽-井木犴
function c21520122.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21520122.spcon)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c21520122.thcon)
	e2:SetTarget(c21520122.thtg)
	e2:SetOperation(c21520122.thop)
	c:RegisterEffect(e2)
end
function c21520122.spfilter(c)
	return c:IsSetCard(0x491) and c:IsFaceup()
end
function c21520122.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c21520122.spfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local ct=g:GetCount()
	return ct>=2
end
function c21520122.thfilter(c)
	return c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c21520122.effectfilter(c)
	return c:IsCode(21520133) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21520122.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21520122.effectfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c21520122.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520122.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c21520122.thop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c21520122.thfilter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then 
		Duel.Hint(HINT_MESSAGE,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
