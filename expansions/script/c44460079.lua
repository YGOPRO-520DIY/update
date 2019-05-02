--古夕幻历-乐正府邸
function c44460079.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460079,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44460079)
	e1:SetTarget(c44460079.target)
	e1:SetOperation(c44460079.activate)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460079,1))
	e2:SetCountLimit(1,44461079)
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c44460079.cost)
	e2:SetTarget(c44460079.tg)
	e2:SetOperation(c44460079.op)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--summon2
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44460079,2))
	e22:SetCountLimit(1,44461079)
	e22:SetCategory(CATEGORY_SUMMON)
	e22:SetType(EFFECT_TYPE_QUICK_O)
	e22:SetCode(EVENT_FREE_CHAIN)
	e22:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e22:SetRange(LOCATION_SZONE)
	e22:SetCost(c44460079.cost)
	e22:SetTarget(c44460079.tg2)
	e22:SetOperation(c44460079.op2)
	e22:SetLabelObject(e1)
	c:RegisterEffect(e22)
end
function c44460079.filter(c)
	return c:IsSetCard(0x699) and not c:IsForbidden() and c:IsType(TYPE_MONSTER)
end
function c44460079.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460079.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44460079.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460079.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(44460079,0)) then
	local tc=g:GetFirst()
	    if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	    end
	end
end
--summon
function c44460079.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c44460079.sfilter(c)
	return bit.band(c:GetOriginalType(),TYPE_MONSTER)~=0 and c:IsSummonable(true,e)
end
function c44460079.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460079.sfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44460079.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44460079.sfilter,tp,LOCATION_SZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end
--summon2
function c44460079.sfilter2(c)
	return c:GetLevel()==1 and c:IsSummonable(true,e) and c:IsType(TYPE_NORMAL)
end
function c44460079.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460079.sfilter2,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44460079.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44460079.sfilter2,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end