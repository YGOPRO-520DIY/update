local m=13520149
local tg={13520144}
local cm=_G["c"..m]
cm.name="血狐妖巫"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.mfilter,6,2,cm.ovfilter,aux.Stringid(m,0),2,cm.xyzop)
	--Control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(cm.ntrcost)
	e1:SetTarget(cm.ntrtg)
	e1:SetOperation(cm.ntrop)
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
--Control
function cm.ntrfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(6) and c:IsControlerCanBeChanged()
end
function cm.ntrcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function cm.ntrtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.ntrfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function cm.ntrop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,cm.ntrfilter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.GetControl(g,tp)
	end
end