local m=13571438
local cm=_G["c"..m]
cm.name="歪秤精灵 妮妮·蝶"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Pendulum
	aux.EnablePendulumAttribute(c,false)
	--Fusion Material
	aux.AddFusionProcFunRep(c,cm.mfilter,2,true)
	--Fusion Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(cm.spcon)
	e1:SetOperation(cm.spop)
	e1:SetValue(SUMMON_TYPE_FUSION)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(cm.condition)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
	--Atk/Def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(cm.value)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e4)
	--Pendulum Set
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(m,2))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCondition(cm.pencon)
	e5:SetTarget(cm.pentg)
	e5:SetOperation(cm.penop)
	c:RegisterEffect(e5)
end
--Fusion Material
function cm.mfilter(c)
	return c:IsFusionType(TYPE_FUSION)
end
--Fusion Summon
function cm.matfilter(c,fc)
	return cm.mfilter(c) and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function cm.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(cm.matfilter,tp,LOCATION_GRAVE,0,2,nil,c)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,cm.matfilter,tp,LOCATION_GRAVE,0,2,2,nil,c)
	c:SetMaterial(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
--Special Summon
function cm.filter(c,ft,tp)
	return c:GetSummonLocation()==LOCATION_EXTRA and c:IsAbleToGraveAsCost()
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5))
end
function cm.condition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_MZONE,0,1,nil,ft,tp)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,cm.filter,tp,LOCATION_MZONE,0,1,1,nil,ft,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
--Atk/Def
function cm.valfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function cm.value(e,c)
	return Duel.GetMatchingGroupCount(cm.valfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*400
end
--Pendulum Set
function cm.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function cm.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function cm.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end