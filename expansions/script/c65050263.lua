--步向彩恋的虹行道
function c65050263.initial_effect(c)
	--act
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--flover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE+CATEGORY_SEARCH+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,65050263)
	e2:SetCost(c65050263.flvcost)
	e2:SetTarget(c65050263.flvtg)
	e2:SetOperation(c65050263.flvop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c65050263.coincon)
	e3:SetOperation(c65050263.regop)
	c:RegisterEffect(e3)
end
function c65050263.flvcostfil(c)
	return c:IsSetCard(0x9da9) and c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c65050263.flvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050263.flvcostfil,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c65050263.flvcostfil,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
end
function c65050263.flvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>=5 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetChainLimit(aux.FALSE)
end
function c65050263.flvfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and (c:IsAbleToHand() or c:IsAbleToGrave() or c:IsAbleToExtra() or c:IsAbleToRemove() or c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp))
end
function c65050263.flvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local res=Duel.TossCoin(tp,1)
	if res==1 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>=5 then
	   local g=Duel.GetMatchingGroup(c65050263.flvfilter,1-tp,LOCATION_DECK,0,nil,e,tp)
		if g:GetClassCount(Card.GetCode)>=5 then
			local sg=g:SelectSubGroup(1-tp,aux.dncheck,false,5,5)
			if #sg>0 then
				Duel.ConfirmCards(tp,sg)
				local tc=sg:Select(tp,1,1,nil):GetFirst()
				
local b1=tc:IsAbleToHand()
local b2=tc:IsAbleToGrave()
local b3=tc:IsAbleToExtra()
local b4=tc:IsAbleToRemove()
local b5=tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
local off=1
local ops,opval={},{}
if b1 then
		ops[off]=aux.Stringid(65050263,1)
		opval[off]=0
		off=off+1
	end
	if b2 then
		ops[off]=aux.Stringid(65050263,2)
		opval[off]=1
		off=off+1
	end
	if b3 then
		ops[off]=aux.Stringid(65050263,3)
		opval[off]=2
		off=off+1
	end
	if b4 then
		ops[off]=aux.Stringid(65050263,4)
		opval[off]=3
		off=off+1
	end
	if b5 then
		ops[off]=aux.Stringid(65050263,5)
		opval[off]=4
		off=off+1
	end
	local op=Duel.SelectOption(tp,table.unpack(ops))+1
	local sel=opval[op]

			if op==0 then
				Duel.SendtoHand(tc,1-tp,REASON_EFFECT)
			elseif op==1 then
				Duel.SendtoGrave(tc,REASON_EFFECT)
			elseif op==2 then
				Duel.SendtoExtraP(tc,1-tp,REASON_EFFECT)
			elseif op==3 then
				Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
			elseif op==4 then
				Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)
			end

			end
			Duel.ShuffleDeck(1-tp)
		end
	end
end
function c65050263.coincon(e,tp,eg,ep,ev,re,r,rp)
	local ex,eg,et,cp,ct=Duel.GetOperationInfo(ev,CATEGORY_COIN)
	if ex and re:GetHandler():IsSetCard(0x9da9) and re:IsActiveType(TYPE_MONSTER) then
		e:SetLabelObject(re)
		return true
	else return false end
end
function c65050263.regop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 and Duel.SelectYesNo(tp,aux.Stringid(65050263,0)) then
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoHand(g,1-tp,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TOSS_COIN_NEGATE)
	e1:SetCountLimit(1)
	e1:SetCondition(c65050263.coincon2)
	e1:SetOperation(c65050263.coinop2)
	e1:SetLabelObject(e:GetLabelObject())
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	end
end
function c65050263.coincon2(e,tp,eg,ep,ev,re,r,rp)
	return re==e:GetLabelObject()
end
function c65050263.coinop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,65050263)
	local res={Duel.GetCoinResult()}
	local ct=ev
	for i=1,ct do
		res[i]=1
	end
	Duel.SetCoinResult(table.unpack(res))
end