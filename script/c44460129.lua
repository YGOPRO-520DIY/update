--自成仙体-初音·月下姮娥
function c44460129.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460129.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460129,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460129.xycost)
	e1:SetTarget(c44460129.xytg)
	e1:SetOperation(c44460129.xyop)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460129,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c44460129.condition)
    e2:SetTarget(c44460129.target)
	e2:SetOperation(c44460129.top)
	c:RegisterEffect(e2)
end
function c44460129.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44460019)
end
--xy
function c44460129.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460129.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460019) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460129.climit)
end
function c44460129.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460129.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--summon
function c44460129.cfilter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c44460129.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460129.cfilter,1,nil,1-tp)
end
function c44460129.tdfilter(c)
	return c:IsSetCard(0x677) and c:IsAbleToDeck()
end
function c44460129.thfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToHand() and c:GetLevel()==1
end
function c44460129.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460129.thfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c44460129.tdfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44460129.top(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c44460129.tdfilter,p,LOCATION_GRAVE,0,nil)
	if g:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,1,1,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		local tg=Duel.SelectMatchingCard(tp,c44460129.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	    local tc=tg:GetFirst()
	    Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

