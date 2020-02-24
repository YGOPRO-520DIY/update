--春雷花海
function c26805005.initial_effect(c)
	aux.AddCodeList(c,81013000)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Code Change
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CHANGE_CODE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetRange(LOCATION_SZONE)
	e0:SetValue(81013000)
	c:RegisterEffect(e0)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26805005,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,26805905)
	e2:SetCondition(c26805005.thcon)
	e2:SetCost(c26805005.cost)
	e2:SetTarget(c26805005.thtg)
	e2:SetOperation(c26805005.thop)
	c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26805005,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,26805005)
	e3:SetCondition(c26805005.tkcon)
	e3:SetCost(c26805005.cost)
	e3:SetTarget(c26805005.tktg)
	e3:SetOperation(c26805005.tkop)
	c:RegisterEffect(e3)
	Duel.AddCustomActivityCounter(26805005,ACTIVITY_SPSUMMON,c26805005.counterfilter)
end
function c26805005.counterfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
function c26805005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(26805005,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c26805005.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c26805005.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsAttribute(ATTRIBUTE_WIND)
end
function c26805005.cfilter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c26805005.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c26805005.cfilter,1,nil,tp)
end
function c26805005.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,81013999,0,0x4011,800,800,3,RACE_ROCK,ATTRIBUTE_WIND,POS_FACEUP_DEFENSE,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c26805005.tkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,81013999,0,0x4011,800,800,3,RACE_ROCK,ATTRIBUTE_WIND,POS_FACEUP_DEFENSE,tp) then
		local token=Duel.CreateToken(tp,81013999)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c26805005.dfilter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and not c:IsCode(81013999)
end
function c26805005.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c26805005.dfilter,1,nil,tp)
end
function c26805005.thfilter(c)
	return c:IsAbleToDeck()
end
function c26805005.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c26805005.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c26805005.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=Duel.SelectTarget(tp,c26805005.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c26805005.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end
