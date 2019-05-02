--浮妖百态·式神 书翁
local m=77295141
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetCountLimit(1,m)
	e1:SetCost(cm.thcost)
	e1:SetTarget(cm.thtg)
	e1:SetOperation(cm.thop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,77295142)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.activate)
	c:RegisterEffect(e2)
end
	--negate
function cm.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function cm.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
		and Duel.GetDecktopGroup(tp,3):FilterCount(Card.IsAbleToHand,nil)>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function cm.thfilter(c)
	return c:IsSetCard(0xee7) and c:IsAbleToHand()
end
function cm.thop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.ConfirmDecktop(p,3)
	local g=Duel.GetDecktopGroup(p,3)
	if g:GetCount()>0 and g:IsExists(cm.thfilter,1,nil) and Duel.SelectYesNo(p,aux.Stringid(m,3)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(p,cm.thfilter,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-p,sg)
		Duel.ShuffleHand(p)
	end
	Duel.ShuffleDeck(p)
end
   --spsummon
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>1 and Duel.CheckChainUniqueness()
end
function cm.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xee7)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function cm.ctfilter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsType(TYPE_MONSTER) and c:IsSetCard(0xee7)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	local tg=Duel.GetMatchingGroup(cm.atkfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(cm.ctfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,nil)
	if tg:GetCount()>0 and g:GetCount()>0 then
		local d=g:GetClassCount(Card.GetCode)*100
		local sc=tg:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(d)
			sc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			sc:RegisterEffect(e2)
			sc=tg:GetNext()
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetReset(RESET_EVENT+RESETS_REDIRECT)
			e3:SetValue(LOCATION_DECKSHF)
			c:RegisterEffect(e3,true)
			end
		end
	end
end