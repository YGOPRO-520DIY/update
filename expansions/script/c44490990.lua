--青眼白皇龙
function c44490990.initial_effect(c)
    c:SetUniqueOnField(1,0,44490990)
	--fusion material
	aux.AddFusionProcFun2(c,89631139,c44490990.mfilter2,true)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44490990,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,44490990)
	e1:SetCondition(c44490990.thcon)
	e1:SetTarget(c44490990.thtg)
	e1:SetOperation(c44490990.thop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c44490990.imcon)
	e2:SetTarget(c44490990.disable)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--immune
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(c44490990.imcon)
	e11:SetValue(c44490990.efilter)
	c:RegisterEffect(e11)

end
c44490990.material_setcode=89631139
function c44490990.mfilter1(c)
	return c:IsCode(89631139)
end
function c44490990.mfilter2(c)
	return c:GetAttack()<=3000 and c:IsType(TYPE_MONSTER)
end
--search
function c44490990.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c44490990.thfilter(c)
	return ((aux.IsCodeListed(c,89631139) or aux.IsCodeListed(c,23995346))
	and c:IsType(TYPE_SPELL+TYPE_TRAP))
	and c:IsAbleToHand()
end
function c44490990.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490990.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44490990.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44490990.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--immune
function c44490990.imcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end
function c44490990.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
--disable
function c44490990.disable(e,c)
	return not c:IsAttribute(ATTRIBUTE_LIGHT)
end
