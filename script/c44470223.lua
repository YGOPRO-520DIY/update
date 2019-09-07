--穗姬·白米·原型
function c44470223.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470223,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,44470223)
	e1:SetCondition(c44470223.sprcon)
	e1:SetOperation(c44470223.sprop)
	c:RegisterEffect(e1)
	--code
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetCode(EFFECT_CHANGE_CODE)
	e11:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e11:SetValue(44470222)
	c:RegisterEffect(e11)
	--Tuner
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_ADD_TYPE)
	e12:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e12:SetValue(TYPE_TUNER)
	e12:SetCondition(c44470223.descon)
	c:RegisterEffect(e12)
	--Attribute
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e15:SetCode(EFFECT_ADD_ATTRIBUTE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetValue(ATTRIBUTE_WATER)
	e15:SetCondition(c44470223.descon)
	c:RegisterEffect(e15)
		
end
function c44470223.sprfilter(c)
	return c:IsReleasable() and c:IsCode(44470222)
end
function c44470223.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(c44470223.sprfilter,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c44470223.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp,tp,c)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c44470223.sprfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
--Tuner
function c44470223.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
