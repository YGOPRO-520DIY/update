local m=82204117
local cm=_G["c"..m]
function cm.initial_effect(c)  
	--xyz summon  
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),8,2,cm.ovfilter,aux.Stringid(m,0),99,cm.xyzop)  
	c:EnableReviveLimit()
	--overlay  
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetTarget(cm.tg)  
	e1:SetOperation(cm.op)  
	c:RegisterEffect(e1)
	--remove  
	local e4=Effect.CreateEffect(c)  
	e4:SetDescription(aux.Stringid(m,2))  
	e4:SetCategory(CATEGORY_REMOVE)  
	e4:SetType(EFFECT_TYPE_QUICK_O)  
	e4:SetCode(EVENT_FREE_CHAIN)  
	e4:SetRange(LOCATION_MZONE)
	e4:SetHintTiming(0,EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)  
	e4:SetCountLimit(1)  
	e4:SetCost(cm.cost2)  
	e4:SetTarget(cm.tg2)  
	e4:SetOperation(cm.op2)  
	c:RegisterEffect(e4)  
end  
function cm.ovfilter(c) 
	local tp=c:GetControler()  
	local sum=Duel.GetMatchingGroup(cm.sumfilter,tp,LOCATION_MZONE,0,nil):GetSum(cm.lv_or_rk)  
	return c:IsFaceup() and c:IsSetCard(0xbb) and sum<9
end  
function cm.xyzop(e,tp,chk)  
	if chk==0 then return Duel.GetFlagEffect(tp,m)==0 end  
	Duel.RegisterFlagEffect(tp,m,RESET_PHASE+PHASE_END,0,1)  
end  
function cm.sumfilter(c)  
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)  
end  
function cm.lv_or_rk(c)  
	if c:IsType(TYPE_XYZ) then return c:GetRank()  
	else return c:GetLevel() end  
end  
function cm.tg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)  
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD+LOCATION_REMOVED,LOCATION_ONFIELD,1,e:GetHandler()) end  
end  
function cm.op(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)  
	local g=Duel.SelectMatchingCard(tp,cm.mtfilter,tp,LOCATION_ONFIELD+LOCATION_REMOVED,LOCATION_ONFIELD,1,1,c)  
	if g:GetCount()>0 then
		local og=g:GetFirst():GetOverlayGroup()  
		if og:GetCount()>0 then  
			Duel.SendtoGrave(og,REASON_RULE)  
		end  
		Duel.Overlay(c,g)  
	end  
end  
function cm.cost2(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end  
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)  
end  
function cm.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end  
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)  
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)  
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)  
end  
function cm.op2(e,tp,eg,ep,ev,re,r,rp)  
	local tc=Duel.GetFirstTarget()  
	if tc:IsRelateToEffect(e) then  
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)  
	end  
end  