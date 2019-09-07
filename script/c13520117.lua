local m=13520117
local cm=_G["c"..m]
cm.name="怨冥修罗·狂"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Cannot Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--Special Summon Rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(cm.sprcon)
	e2:SetOperation(cm.sprop)
	c:RegisterEffect(e2)
	--Atk Up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(cm.atkop)
	c:RegisterEffect(e3)
	--Reflect Battle Damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
--Special Summon Rule
function cm.sprfilter(c,tp)
	return c:IsSummonType(SUMMON_TYPE_ADVANCE) and Duel.GetMZoneCount(tp,c)>0
end
function cm.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroup(tp,cm.sprfilter,1,nil,tp)
end
function cm.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,cm.sprfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
--Atk Up
function cm.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK))
	e1:SetValue(300)
	Duel.RegisterEffect(e1,tp)
end