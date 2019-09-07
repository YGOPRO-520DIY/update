local m=13520147
local tg={13520142}
local cm=_G["c"..m]
cm.name="血狐妖伎"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.mfilter,6,2,cm.ovfilter,aux.Stringid(m,0),2,cm.xyzop)
	--Pendulum Set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(cm.pscost)
	e1:SetTarget(cm.pstg)
	e1:SetOperation(cm.psop)
	c:RegisterEffect(e1)
end
cm.card_code_list=tg
--Xyz Summon
function cm.mfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsCode(tg[1])
end
function cm.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,m)==0 end
	Duel.RegisterFlagEffect(tp,m,RESET_PHASE+PHASE_END,0,1)
end
--Pendulum Set
function cm.psfilter(c)
	return c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function cm.pscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function cm.pstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1))
		and Duel.IsExistingMatchingCard(cm.psfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,1-tp,LOCATION_GRAVE)
end
function cm.psop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,2))
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(cm.psfilter),tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
		local tc=g:GetFirst()
		if tc then Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) end
	end
end