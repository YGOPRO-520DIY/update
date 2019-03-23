--雪尘蜥龙
function c65080005.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),8,2,c65080005.ovfilter,aux.Stringid(65080005,0),2,c65080005.xyzop)
	c:EnableReviveLimit()
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c65080005.ctcon)
	e1:SetCost(c65080005.ctcost)
	e1:SetTarget(c65080005.cttg)
	e1:SetOperation(c65080005.ctop)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c65080005.tg)
	e2:SetValue(c65080005.val)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c65080005.tg)
	c:RegisterEffect(e3)
end
function c65080005.ovfilter(c)
	return c:IsFaceup() and c:IsRankAbove(4) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c65080005.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,65080005)==0 and Duel.GetCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015)>0 end
	Duel.RemoveCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015,1,REASON_COST)
	Duel.RegisterFlagEffect(tp,65080005,RESET_PHASE+PHASE_END,0,1)
end
function c65080005.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp 
end

function c65080005.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end

function c65080005.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
end

function c65080005.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1015,1)
	end
end

function c65080005.tg(e,c)
	return c:GetCounter(0x1015)>0 and not c:IsAttribute(ATTRIBUTE_WATER)
end
function c65080005.val(e,c)
	return Duel.GetCounter(0,1,1,0x1015)*-200
end
