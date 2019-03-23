--十二宫·天秤座
function c44470457.initial_effect(c)
	--tuner
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470457,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44470457)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c44470457.condition)
    e1:SetCost(c44470457.lvcost)
	e1:SetTarget(c44470457.tg)
	e1:SetOperation(c44470457.op)
	c:RegisterEffect(e1)
	--damage conversion
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetCountLimit(1,44471455)
	e11:SetCondition(c44470457.condition)
	e11:SetOperation(c44470457.operation)
	c:RegisterEffect(e11)
end
--tuner
function c44470457.cfilter(c)
	return c:IsCode(44470457)
end
function c44470457.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470457.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470457.rfilter(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsAbleToRemoveAsCost() and c:IsSetCard(0x140)
		--and Duel.IsExistingMatchingCard(c44470457.tfilter,tp,LOCATION_MZONE,0,1,nil,lv)
end
function c44470457.tfilter(c,clv)
	local lv=c:GetLevel()
	return lv>0 and lv~=clv and c:IsFaceup()
end
function c44470457.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c44470457.rfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp)
	and e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470457.rfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,tp)

	--g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.Remove(c,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c44470457.filter(c)
	return c:IsFaceup()
	--and c:IsType(TYPE_MONSTER)
	and c:IsType(TYPE_NORMAL)
	and c:IsLevelAbove(1)
end
function c44470457.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470457.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c44470457.op(e,tp,eg,ep,ev,re,r,rp)
    --local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(c44470457.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
	    local tc=g:GetFirst()
		--local lv=tc:GetLevel()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
			e1:SetValue(e:GetLabel())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
--damage conversion
function c44470457.operation(e,tp,eg,ep,ev,re,r,rp)
    --damage conversion
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetTargetRange(1,1)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end