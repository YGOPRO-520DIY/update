local m=13571208
local cm=_G["c"..m]
cm.name="歪秤 圣使灵"
function cm.initial_effect(c)
	--Pendulum
	aux.EnablePendulumAttribute(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(cm.spcon)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
end
--Special Summon
function cm.spfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsReleasable()
end
function cm.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<1 then
		return ft>-1 and Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
	else
		return Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
	end
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=nil
	if ft<1 then
		g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	else
		g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	end
	Duel.Release(g,REASON_COST)
end