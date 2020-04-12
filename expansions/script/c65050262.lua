--晶莹彩恋 幸福少女
function c65050262.initial_effect(c)
	 c:SetUniqueOnField(1,0,65050262)
	 --link summon
	aux.AddLinkProcedure(c,nil,2,99,c65050262.lcheck)
	c:EnableReviveLimit()
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetCondition(c65050262.con1)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e11:SetRange(LOCATION_MZONE)
	e11:SetTargetRange(LOCATION_MZONE,0)
	e11:SetTarget(c65050262.eftg)
	e11:SetLabelObject(e1)
	c:RegisterEffect(e11)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c65050262.con2)
	e2:SetTarget(c65050262.target)
	e2:SetOperation(c65050262.activate)
	local e12=e11:Clone()
	e12:SetLabelObject(e2)
	c:RegisterEffect(e12)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c65050262.con3)
	e3:SetValue(c65050262.efilter)
	local e13=e11:Clone()
	e13:SetLabelObject(e3)
	c:RegisterEffect(e13)
end
function c65050262.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9da9)
end
function c65050262.eftg(e,c)
	local seq=c:GetSequence()
	return c:IsType(TYPE_EFFECT) and c:IsSetCard(0x9da9)
end
function c65050262.contfil(c,tp)
	return c:GetOwner()~=tp
end
function c65050262.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c65050262.contfil,tp,LOCATION_MZONE,0,nil,tp)>=1
end
function c65050262.con2(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c65050262.contfil,tp,LOCATION_MZONE,0,nil,tp)>=2
end
function c65050262.con3(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c65050262.contfil,tp,LOCATION_MZONE,0,nil,tp)>=3
end
function c65050262.efilter(e,te)
	local c=e:GetHandler()
	local ec=te:GetHandler()
	if ec:IsHasCardTarget(c) or (te:IsHasType(EFFECT_TYPE_ACTIONS) and te:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and c:IsRelateToEffect(te)) then return false
	end
	return te:GetOwnerPlayer()~=c:GetControler()
end
function c65050262.targfil(c)
	return c:IsFaceup() and c:IsSetCard(0x9da9) and c:IsAbleToHand()
end
function c65050262.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050262.targfil,tp,LOCATION_MZONE,0,1,e:GetHandler()) and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_ONFIELD)
end
function c65050262.activate(e,tp,eg,ep,ev,re,r,rp)
	 local g1=Duel.SelectMatchingCard(tp,c65050262.targfil,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.HintSelection(g1)
		Duel.HintSelection(g2)
		g1:Merge(g2)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
	end
end
