--星曜齐出
function c21520138.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520138,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,21520138+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c21520138.target)
	e1:SetOperation(c21520138.activate)
	c:RegisterEffect(e1)
end
function c21520138.filter(c)
	return (c:IsSetCard(0x491) and not c:IsSetCard(0x5491) and not c:IsSetCard(0xa491)) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c21520138.thfilter(c)
	return c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c21520138.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520138.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetTargetPlayer(tp)
end
function c21520138.activate(e,tp,eg,ep,ev,re,r,rp)
	local player=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c21520138.filter,player,LOCATION_DECK,0,nil)
	if g:GetCount()<=0 then return end
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_TOGRAVE)
	local g1=g:Select(player,1,7,nil)
	local ct=g1:GetCount()
	Duel.Damage(player,1000*ct,REASON_RULE)
	ct=Duel.SendtoGrave(g1,REASON_EFFECT)
	Duel.ShuffleDeck(player)
	while ct>0 and Duel.GetFieldGroupCount(player,LOCATION_DECK,0)>0 do
		local hg=Duel.GetDecktopGroup(player,1)
		Duel.ConfirmDecktop(player,1)
		local tc=hg:GetFirst()
		if c21520138.thfilter(tc) then
			Duel.DisableShuffleCheck()
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			ct=ct-1
		else
			ct=0
		end
	end
	Duel.ShuffleDeck(player)
	Duel.ShuffleHand(player)
end
function c21520138.group_unique_code(g)
	local check={}
	local tg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		for i,code in ipairs({tc:GetCode()}) do
			if not check[code] then
				check[code]=true
				tg:AddCard(tc)
			end
		end
		tc=g:GetNext()
	end
	return tg
end
