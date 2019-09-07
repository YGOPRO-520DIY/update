local m=13502101
local tg={13502102}
local cm=_G["c"..m]
cm.name="真姬狩 盗贼柯莱特"
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
	--Duel Effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(aux.IsDualState)
	e2:SetOperation(cm.efop)
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
--Duel Effect
function cm.efop(e,tp,eg,ep,ev,re,r,rp)
	if not cm.effect_flag then
		cm.effect_flag=true
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_SUMMON_SUCCESS)
		e1:SetCondition(cm.limcon)
		e1:SetOperation(cm.limop)
		Duel.RegisterEffect(e1,tp)
	end
end
function cm.limcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsType(TYPE_PENDULUM) and tc:IsType(TYPE_DUAL)
end
function cm.limop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(cm.chlimit)
end
function cm.chlimit(re,rp,tp)
	return tp==rp
end