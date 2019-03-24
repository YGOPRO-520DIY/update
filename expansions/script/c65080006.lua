--雪暴璃羽
function c65080006.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),8,2,c65080006.ovfilter,aux.Stringid(65080006,0),2,c65080006.xyzop)
	c:EnableReviveLimit()
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c65080006.ctcon)
	e1:SetCost(c65080006.ctcost)
	e1:SetTarget(c65080006.cttg)
	e1:SetOperation(c65080006.ctop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c65080006.tg)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	c:RegisterEffect(e3)
end
function c65080006.ovfilter(c)
	return c:IsFaceup() and c:IsRankAbove(4) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c65080006.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,65080006)==0 and Duel.GetCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015)>0 end
	Duel.RemoveCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015,1,REASON_COST)
	Duel.RegisterFlagEffect(tp,65080006,RESET_PHASE+PHASE_END,0,1)
end
function c65080006.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetControler()~=tp 
end

function c65080006.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end

function c65080006.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
end

function c65080006.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1015,1)
	end
end
function c65080006.tg(e,c)
	return c:GetCounter(0x1015)>0 and not c:IsAttribute(ATTRIBUTE_WATER)
end