--神奇术士的支援石
function c65020159.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c65020159.ac)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1) 
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c65020159.con)
	e2:SetTarget(c65020159.tg)
	e2:SetOperation(c65020159.op)
	c:RegisterEffect(e2)
	--rec X
   local e3=Effect.CreateEffect(c)
   e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
   e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
  e3:SetCode(EVENT_REMOVE_COUNTER+0x1da2)
	e3:SetRange(LOCATION_SZONE)
  e3:SetOperation(c65020159.rop2)
  c:RegisterEffect(e3)
	--rec X
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65020159,2))
	e4:SetCategory(CATEGORY_SUMMON+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_CUSTOM+65020159)
	--e4:SetCode(EVENT_REMOVE_COUNTER+0x12da)
	e4:SetCountLimit(1,65020159)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY)
	e4:SetTarget(c65020159.rtg)
	e4:SetOperation(c65020159.rop)
	c:RegisterEffect(e4)
end
function c65020159.ac(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x1da2,2)
	end
end

function c65020159.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x1da2)<=0
end
function c65020159.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c65020159.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

function c65020159.rop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+65020159,e,0,tp,0,0)
end
function c65020159.rfil(c)
	return c:IsSetCard(0xada8) and c:IsSummonable(true,nil)
end
function c65020159.rf2(c)
	return c:IsSetCard(0xada8) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c65020159.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c65020159.rfil,tp,LOCATION_HAND,0,1,nil) end
end
function c65020159.rop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsExistingMatchingCard(c65020159.rf2,tp,LOCATION_GRAVE,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(65020159,0)) then
		local sg=Duel.SelectMatchingCard(tp,c65020159.rf2,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.HintSelection(sg)
		Duel.SendtoHand(sg,tp,REASON_EFFECT)
	end
	local g=Duel.SelectMatchingCard(tp,c65020159.rfil,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.Summon(tp,tc,true,nil)
	end
end

