local m=13520520
local list={13520510,13520530,13520501,13520502}
local cm=_G["c"..m]
cm.name="血式少女 白雪公主"
function cm.initial_effect(c)
	aux.AddCodeList(c,list[3],list[4])
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.xyzmat,3,2,cm.ovfilter,aux.Stringid(m,0))
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(cm.setcost)
	e1:SetTarget(cm.settg)
	e1:SetOperation(cm.setop)
	c:RegisterEffect(e1)
end
function cm.isset(c)
	return c:GetCode()>=list[1] and c:GetCode()<=list[2]
end
--Xyz Summon
function cm.xyzmat(c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
function cm.ovfilter(c)
	return cm.isset(c) and c:IsLevel(3)
end
--Activate
function cm.setfilter(c)
	return c:IsCode(list[3],list[4]) and c:IsSSetable()
end
function cm.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function cm.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(cm.setfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function cm.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,2))
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(cm.setfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
end