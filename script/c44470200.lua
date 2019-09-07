--碧海龙宫
function c44470200.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--sp
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetDescription(aux.Stringid(44470200,0))
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetCountLimit(1,44470200)
	e11:SetRange(LOCATION_FZONE)
	e11:SetTarget(c44470200.tg)
	e11:SetOperation(c44470200.op)
	c:RegisterEffect(e11)
	--lv change
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_IGNITION)
	e21:SetDescription(aux.Stringid(44470200,1))
	e21:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e21:SetRange(LOCATION_FZONE)
	e21:SetCountLimit(1,44470200)
	e21:SetTarget(c44470200.lvtg)
	e21:SetOperation(c44470200.lvop)
	c:RegisterEffect(e21)
end
--sp
function c44470200.spfilter(c,e,sp)
	return c:IsType(TYPE_CONTINUOUS) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c44470200.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c44470200.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc~=c and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(c44470200.thfilter,tp,LOCATION_SZONE,0,1,c) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44470200.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c44470200.thfilter,tp,LOCATION_SZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c44470200.op(e,tp,eg,ep,ev,re,r,rp)
	local sc=Duel.GetFirstTarget()
	if sc and sc:IsRelateToEffect(e) then
	Duel.SendtoHand(sc,nil,REASON_EFFECT)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44470200.spfilter),tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
	    e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	    local e2=e1:Clone()
	    e2:SetCode(EFFECT_CHANGE_LEVEL)
	    e2:SetValue(4)
	    tc:RegisterEffect(e2)
	    local e4=e1:Clone()
	    e4:SetCode(EFFECT_CHANGE_RACE)
	    e4:SetValue(RACE_AQUA)
	    tc:RegisterEffect(e4)
	    local e5=e1:Clone()
	    e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	    e5:SetValue(ATTRIBUTE_WATER)
	    tc:RegisterEffect(e5)
		local e6=e1:Clone()
	    e6:SetCode(EFFECT_SET_BASE_ATTACK)
	    e6:SetValue(500)
	    tc:RegisterEffect(e6)
		local e7=e1:Clone()
	    e7:SetCode(EFFECT_SET_BASE_DEFENSE)
	    e7:SetValue(2000)
	    tc:RegisterEffect(e7)
		end
	end
	Duel.SpecialSummonComplete()
	end
end
--lv change
function c44470200.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:GetLevel()>0 
end
function c44470200.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44470200.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44470200.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c44470200.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local lv=g:GetFirst():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	e:SetLabel(Duel.AnnounceLevel(tp,1,12,lv))
end
function c44470200.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end


