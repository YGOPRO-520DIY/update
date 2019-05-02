--玄化青眼龙
function c44490911.initial_effect(c)
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetValue(89631139)
	c:RegisterEffect(e2) 
	--summon
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44490911,0))
	e12:SetCountLimit(1,44490911)
	e12:SetCategory(CATEGORY_SUMMON)
	e12:SetType(EFFECT_TYPE_IGNITION)
	e12:SetRange(LOCATION_HAND)
    e12:SetCost(c44490911.cost)
	e12:SetTarget(c44490911.target)
	e12:SetOperation(c44490911.operation)
	c:RegisterEffect(e12)	
	--tohand
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44490911,1))
	e31:SetCountLimit(1,44491911)
	e31:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetCode(EVENT_REMOVE)
	e31:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e31:SetTarget(c44490911.thtg)
	e31:SetOperation(c44490911.thop)
	c:RegisterEffect(e31)
end
--速攻召唤
function c44490911.cfilter(c)
	return c:IsSetCard(0xdd) and c:IsAbleToGraveAsCost()
end
function c44490911.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490911.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44490911.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
	local rc=g:GetFirst()
	if not rc:IsType(TYPE_NORMAL) then e:SetLabel(1)
	else e:SetLabel(0)
	end
end
function c44490911.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,e:GetHandler(),1,0,0)
end
function c44490911.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--local se=e:GetLabelObject()
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44490911,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD)
	e1:SetCondition(c44490911.ntcon)
	
	c:RegisterEffect(e1)
	if c:IsSummonable(true,nil) then
	Duel.Summon(tp,c,true,nil)
    if e:GetLabel()==1 then
	Duel.Destroy(c,REASON_EFFECT)
	    end
	end
end
function c44490911.ntcon(e,c)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
--tohand
function c44490911.filter(c)
	return c:GetLevel()==8 and c:IsAttribute(ATTRIBUTE_LIGHT)
	and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44490911.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490911.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44490911.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44490911.filter,tp,LOCATION_DECK,0,1,1,nil)
	
	local tc=g:GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) and not tc:IsSetCard(0xdd) then
		Duel.ConfirmCards(1-tp,tc)
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
