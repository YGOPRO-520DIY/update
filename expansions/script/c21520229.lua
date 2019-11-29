--星曜圣装-毕月乌
function c21520229.initial_effect(c)
	c:SetSPSummonOnce(21520229)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520229,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520229.sprcon)
	e0:SetOperation(c21520229.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520229.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520229,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520229.igtg)
	e2:SetOperation(c21520229.igop)
	c:RegisterEffect(e2)
end
c21520229.card_code_list={21520119}
function c21520229.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520229.spfilter(c)
	return c:IsCode(21520119) and c:IsAbleToRemoveAsCost()
end
function c21520229.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520229.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520229.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520229.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520229.igfilter(c)
	return c:IsAbleToDeck()
end
function c21520229.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520229.igfilter,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,Duel.GetMatchingGroupCount(c21520229.igfilter,tp,0,LOCATION_HAND,nil),1-tp,LOCATION_HAND)
end
function c21520229.igop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520229.igfilter,tp,0,LOCATION_HAND,nil)
	if g:GetCount()>0 then 
		local ct=Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
		if ct>0 then 
			Duel.ShuffleDeck(1-tp)
			if ct>1 then 
				Duel.BreakEffect()
				Duel.Draw(1-tp,ct-1,REASON_EFFECT)
			end
		end
	end
end
