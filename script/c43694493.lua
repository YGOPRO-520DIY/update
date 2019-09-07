--雪暴猎鹰-飘零
function c43694493.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c43694493.sfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--code
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(43694481)
	c:RegisterEffect(e1)
	 --self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c43694493.sdcon)
	c:RegisterEffect(e2)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_RELEASE)
	e3:SetTarget(c43694493.tdtg)
	e3:SetOperation(c43694493.tdop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsCode,43694481))
	e4:SetCondition(c43694493.con)
	e4:SetValue(1500)
	c:RegisterEffect(e4)
end
function c43694493.sfilter(c)
	return c:IsSetCard(0x436) or c:IsCode(43694481)
end
function c43694493.sdcon(e)
	return not (e:GetHandler():IsAttribute(ATTRIBUTE_WATER) and e:GetHandler():IsRace(RACE_WINDBEAST))
end
function c43694493.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c43694493.tdop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end
function c43694493.con(e)
	local c=e:GetHandler()
	return c:GetAttack()>c:GetBaseAttack()
end