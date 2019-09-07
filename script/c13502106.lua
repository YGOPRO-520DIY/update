local m=13502106
local tg={13502105}
local cm=_G["c"..m]
cm.name="真姬狩 演员希欧法尼阿"
function cm.initial_effect(c)
	--Pendulum Summon
	aux.EnablePendulumAttribute(c)
	--Dual
	aux.EnableDualAttribute(c)
	--PZone Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(cm.pspcon)
	e1:SetOperation(cm.pspop)
	c:RegisterEffect(e1)
	--Destroy Replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(aux.IsDualState)
	e2:SetTarget(cm.destg)
	e2:SetOperation(cm.desop)
	e2:SetValue(cm.desval)
	c:RegisterEffect(e2)
end
--PZone Special Summon
function cm.pspfilter(c)
	return c:IsCode(tg[1]) and c:IsAbleToGraveAsCost()
end
function cm.pspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetMZoneCount(tp)>0 and Duel.IsExistingMatchingCard(cm.pspfilter,tp,LOCATION_DECK,0,1,nil)
end
function cm.pspop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=Duel.GetFirstMatchingCard(cm.pspfilter,tp,LOCATION_DECK,0,nil)
	Duel.SendtoGrave(tc,REASON_COST)
end
--Summon
function cm.sumfilter(c)
	return c:IsType(TYPE_DUAL) and c:IsSummonable(true,nil)
end
function cm.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.sumfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function cm.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.sumfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
		Duel.Recover(tp,tc:GetDefense(),REASON_EFFECT)
	end
end
--Destroy Replace
function cm.desfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_BATTLE)
		and c:IsType(TYPE_NORMAL) and c:IsType(TYPE_DUAL) and c:IsSummonable(true,nil)
end
function cm.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc and cm.desfilter(tc,tp) end
	Duel.SetTargetCard(tc)
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Summon(tp,tc,true,nil)
end
function cm.desval(e,c)
	return cm.desfilter(c,e:GetHandlerPlayer())
end