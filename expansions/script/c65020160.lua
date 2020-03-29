--神奇术士的共鸣石
function c65020160.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c65020160.ac)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1) 
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c65020160.con)
	e2:SetTarget(c65020160.tg)
	e2:SetOperation(c65020160.op)
	c:RegisterEffect(e2)
	--rec X
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_REMOVE_COUNTER+0x1da2)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c65020160.rop2)
	c:RegisterEffect(e3)
	--rec X
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65020160,2))
	e4:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_CUSTOM+65020160)
	--e4:SetCode(EVENT_REMOVE_COUNTER+0x12da)
	e4:SetCountLimit(1,65020160)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY)
	e4:SetTarget(c65020160.rtg)
	e4:SetOperation(c65020160.rop)
	c:RegisterEffect(e4)
end
function c65020160.ac(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x1da2,2)
	end
end

function c65020160.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x1da2)<=0
end
function c65020160.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c65020160.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

function c65020160.rop2(e,tp,eg,ep,ev,re,r,rp)
	 Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+65020160,e,0,tp,0,0)
end
function c65020160.rfil(c)
	return c:IsSetCard(0xada8) and c:IsAbleToHand()
end
function c65020160.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020160.rfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65020160.rop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c65020160.rfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

