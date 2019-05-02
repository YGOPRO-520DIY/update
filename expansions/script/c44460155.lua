--古夕幻历-为先人祈
function c44460155.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c44460155.target)
	e1:SetOperation(c44460155.activate)
	c:RegisterEffect(e1)
	--remain field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e3)
end
function c44460155.filter(c)
	return (c:IsSetCard(0x677) or c:IsSetCard(0x679) or c:IsSetCard(0x680)) and c:IsAbleToDeck()
end
function c44460155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c44460155.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	--destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c44460155.descon)
	e1:SetOperation(c44460155.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	e:GetHandler():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
	c44460155[e:GetHandler()]=e1
end
function c44460155.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c44460155.filter,p,LOCATION_GRAVE,0,nil)
	if g:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,1,3,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		Duel.Draw(p,1,REASON_EFFECT)
	end
end
function c44460155.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c44460155.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==2 then
		Duel.Destroy(c,REASON_RULE)
		c:ResetFlagEffect(1082946)
	end
end
