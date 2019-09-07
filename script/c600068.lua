--灵魂鸟神-桥喜鹊
function c600068.initial_effect(c)
   --link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2)
	--ritual
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600068,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMING_MAIN_END+TIMING_END_PHASE)
	e1:SetCountLimit(1,600068)
	e1:SetCost(c600068.cost)
	e1:SetTarget(c600068.target)
	e1:SetOperation(c600068.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c600068.desreptg)
	e2:SetValue(c600068.desrepval)
	e2:SetOperation(c600068.desrepop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c600068.desreptg2)
	e3:SetOperation(c600068.desrepop2)
	c:RegisterEffect(e3)

end
function c600068.filter(c)
	return c:GetType()==TYPE_SPELL+TYPE_RITUAL and c:IsCode(73055622) and c:IsAbleToRemoveAsCost() and c:CheckActivateEffect(true,true,false)~=nil
end
function c600068.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c600068.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
	end
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c600068.filter,tp,LOCATION_GRAVE,0,1,nil)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c600068.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local te=g:GetFirst():CheckActivateEffect(true,true,false)
	e:SetLabelObject(te)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT,REASON_COST)
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c600068.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
function c600068.repfilter(c,g)
	return (c:IsCode(52900000) or c:IsCode(25415052)) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)  and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c600068.desrepfilter),tp,LOCATION_REMOVED,0,1,nil) and g:IsContains(c)
end
function c600068.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=c:GetLinkedGroup()
	if chk==0 then return eg:IsExists(c600068.repfilter,1,nil,g) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		return true
	else return false end
end
function c600068.desrepval(e,c)
	return c600068.repfilter(c,e:GetHandler():GetLinkedGroup())
end
function c600068.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c600068.desrepfilter),tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_REPLACE)
end
function c600068.desrepfilter(c)
	return c:IsType(TYPE_SPIRIT) and c:IsAbleToDeck()
end
function c600068.desreptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c600068.desrepfilter),tp,LOCATION_REMOVED,0,1,nil) end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c600068.desrepop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c600068.desrepfilter),tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_REPLACE)
end