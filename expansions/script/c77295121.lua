--百绘罗衣·式神 追月神
local m=77295121
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Effect Draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,m)
	e1:SetTargetRange(1,0)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCountLimit(1,77295122)
	e2:SetCost(cm.spcost)
	e2:SetTarget(cm.sptg)
	e2:SetOperation(cm.spop)
	c:RegisterEffect(e2)
   --spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,77295123)
	e3:SetCondition(cm.condition)
	e3:SetTarget(cm.target)
	e3:SetOperation(cm.activate)
	c:RegisterEffect(e3)
end
	--draw
function cm.drfilter(c)
	return c:IsSetCard(0xee7) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function cm.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(cm.drfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function cm.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,cm.drfilter,p,LOCATION_HAND,0,1,63,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-p,g)
		local ct=Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		Duel.Draw(p,ct,REASON_EFFECT)
	end
end
	--special summon
function cm.cffilter(c)
	return c:IsSetCard(0xee7) and not c:IsPublic()
end
function cm.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() and Duel.IsExistingMatchingCard(cm.cffilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,cm.cffilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function cm.spfilter(c,e,tp)
	return c:IsSetCard(0xee7) and c:GetCode()~=m and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

   --spsummon
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>1 and Duel.CheckChainUniqueness()
end
function cm.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xee7) and c:IsAbleToHand()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end