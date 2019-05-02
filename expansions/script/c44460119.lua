--自成仙体-初音·月下姮娥
function c44460119.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460119.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460119,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460119.xycost)
	e1:SetTarget(c44460119.xytg)
	e1:SetOperation(c44460119.xyop)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460119,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460119)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c44460119.condition)
    e2:SetTarget(c44460119.target)
	e2:SetOperation(c44460119.top)
	c:RegisterEffect(e2)
end
function c44460119.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44460019)
end
--xy
function c44460119.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c44460119.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460019) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460119.climit)
end
function c44460119.xyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
end
function c44460119.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--summon
function c44460119.cfilter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c44460119.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460119.cfilter,1,nil,1-tp)
end
function c44460119.tdfilter(c)
	return c:IsSetCard(0x677) and c:IsAbleToDeck()
end
function c44460119.thfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToHand() and c:GetLevel()==1
end
function c44460119.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460119.thfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c44460119.tdfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44460119.top(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c44460119.tdfilter,p,LOCATION_GRAVE,0,nil)
	if g:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,1,1,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		local tg=Duel.SelectMatchingCard(tp,c44460119.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	    local tc=tg:GetFirst()
	    Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
