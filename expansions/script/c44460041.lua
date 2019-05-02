--仙依-桃花姬
function c44460041.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSynchroType,TYPE_NORMAL),1)
	c:EnableReviveLimit()
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460041,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460041.xycon)
	e1:SetCost(c44460041.xycost)
	e1:SetTarget(c44460041.xytg)
	e1:SetOperation(c44460041.xyop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460041,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1)
	--e2:SetCost(c44460041.cost)
	e2:SetTarget(c44460041.target)
	e2:SetOperation(c44460041.operation)
	c:RegisterEffect(e2)
end
--xy
function c44460041.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c44460041.filter(c,tp)
	return c:IsFaceup() and c:IsCode(44460001)
end
function c44460041.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460041.filter,1,nil,tp)
end
function c44460041.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460001) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460041.climit)
end
function c44460041.xyop(e,tp,eg,ep,ev,re,r,rp)
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
function c44460041.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--search
function c44460041.thfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToHand() 
end
function c44460041.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460041.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44460041.operation(e,tp,eg,ep,ev,re,r,rp)
	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44460041.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) and tc:GetLevel()==1
    	and tc:IsType(TYPE_NORMAL) and tc:IsSummonable(true,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(44460041,2)) then
		Duel.ConfirmCards(1-tp,tc)
		Duel.Summon(tp,tc,true,nil)
	end
end