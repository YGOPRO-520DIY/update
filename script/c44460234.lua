--邪仙依-莲鲤妖姬
function c44460234.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460234.matfilter,2)
    --xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460234,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460234.xycon)
	e1:SetCost(c44460234.xycost)
	e1:SetTarget(c44460234.xytg)
	e1:SetOperation(c44460234.xyop)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460234,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,44460234)
	e2:SetCondition(c44460234.scon)
	e2:SetTarget(c44460234.ktg)
	e2:SetOperation(c44460234.kop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk&def
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_UPDATE_ATTACK)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e21:SetValue(1000)
	e21:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x64a))
	c:RegisterEffect(e21)

end
function c44460234.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN) and c:IsLinkType(TYPE_NORMAL)
	--and c:IsAttribute(ATTRIBUTE_WATER)
end
--xy
function c44460234.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,500)
end
function c44460234.filter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_NORMAL)
end
function c44460234.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460234.filter,1,nil,tp)
end
function c44460234.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsAttribute(ATTRIBUTE_DARK) and tc:IsType(TYPE_NORMAL) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460234.climit)
end
function c44460234.xyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
end
function c44460234.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--tograve
function c44460234.sfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) 
end
function c44460234.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460234.sfilter,1,nil,tp)
end
function c44460234.rmfilter(c)
	return (c:IsFacedown() or c:IsSetCard(0x64b)) and c:IsAbleToGrave()
	and not c:IsCode(44460234)
end
function c44460234.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460234.rmfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44460234.rmfilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c44460234.kop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460234.rmfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoGrave(g,nil,REASON_RULE)
	end
end
