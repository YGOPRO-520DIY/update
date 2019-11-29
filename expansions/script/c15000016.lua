local m=15000016
local cm=_G["c"..m]
cm.name="到来的异兽"
function cm.initial_effect(c)
	--Activate  
	local e1=Effect.CreateEffect(c)  
	e1:SetType(EFFECT_TYPE_ACTIVATE)  
	e1:SetCode(EVENT_FREE_CHAIN)  
	c:RegisterEffect(e1) 
	--cannot disable summon  
	local e2=Effect.CreateEffect(c)  
	e2:SetType(EFFECT_TYPE_FIELD)  
	e2:SetCode(EFFECT_CANNOT_DISABLE_FLIP_SUMMON+EFFECT_CANNOT_DISABLE_SPSUMMON)  
	e2:SetRange(LOCATION_SZONE)  
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)  
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xf30))  
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)  
	e3:SetCategory(CATEGORY_NEGATE)  
	e3:SetType(EFFECT_TYPE_QUICK_O)  
	e3:SetCode(EVENT_BECOME_TARGET)  
	e3:SetRange(LOCATION_SZONE)  
	e3:SetCondition(c15000016.descon1)  
	e3:SetTarget(c15000016.destg)  
	e3:SetOperation(c15000016.desop)  
	c:RegisterEffect(e3)  
	--to grave
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(15000016,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCountLimit(1,15010016)
	e4:SetOperation(c15000016.tgop)
	c:RegisterEffect(e4)
end


function c15000016.sfilter(c,e,tp)
	return c:IsSetCard(0xf31) and not c:IsCode(15000016)
end
function c15000016.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c15000016.sfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local c=e:GetHandler()
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ConfirmCards(1-tp,c)
		Duel.SendtoDeck(c,nil,3,REASON_EFFECT)
	end
end