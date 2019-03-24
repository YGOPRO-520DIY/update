--辉夜白龙
function c44470099.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,2)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c44470099.imcon)
	e1:SetValue(c44470099.efilter)
	c:RegisterEffect(e1)
	--attribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCode(EFFECT_ADD_ATTRIBUTE)
	e2:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e2)
	--attack cost
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	--e11:SetCode(EFFECT_ATTACK_COST)
	--e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EVENT_BATTLED)
	--e11:SetCondition(c44470099.imcon)
	--e11:SetCost(c44470099.atkcost)
	e11:SetCondition(c44470099.bcon)
	e11:SetOperation(c44470099.rmop)
	c:RegisterEffect(e11)
	--to deck
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44470099,3))
	e12:SetCategory(CATEGORY_TODECK)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e12:SetCode(EVENT_TO_GRAVE)
	e12:SetTarget(c44470099.target1)
	e12:SetOperation(c44470099.operation1)
	c:RegisterEffect(e12)
	--cannot attack
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetCode(EFFECT_CANNOT_ATTACK)
	e22:SetCondition(c44470099.atcon)
	c:RegisterEffect(e22)
end
function c44470099.imcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c44470099.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c44470099.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
--attack cost
function c44470099.bcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker()
end
function c44470099.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetOverlayCount()>0 then
		c:RemoveOverlayCard(tp,1,1,REASON_COST)
	end
end
--to deck
function c44470099.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c44470099.operation1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	end
end
--cannot attack
function c44470099.atcon(e)
	return e:GetHandler():GetOverlayCount()==0
end
