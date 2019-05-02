--百鬼印画·式神 面灵气
local m=77295091
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	c:EnableCounterPermit(0x13)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xee7),7,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(cm.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(cm.sprcon)
	e2:SetOperation(cm.sprop)
	c:RegisterEffect(e2)
	--add counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SUMMON)
	e3:SetCondition(cm.ctcon)
	e3:SetOperation(cm.ctop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e4)
	--Activate(effect)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_CHAINING)
	e5:SetCondition(cm.condition)
	e5:SetOperation(cm.ctop)
	c:RegisterEffect(e5)
	--dice1
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(m,2))
	e6:SetCategory(CATEGORY_COIN)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_SUMMON)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTarget(cm.destg)
	e6:SetOperation(cm.desop)
	c:RegisterEffect(e6)
	--dice2
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(m,4))
	e7:SetCategory(CATEGORY_COIN)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_SPSUMMON)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTarget(cm.destg1)
	e7:SetOperation(cm.desop1)
	c:RegisterEffect(e7)
	--dice3
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_COIN)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EVENT_CHAINING)
	e8:SetCondition(cm.condition2)
	e8:SetTarget(cm.destg2)
	e8:SetOperation(cm.desop2)
	c:RegisterEffect(e8)
	--damage
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(m,3))
	e9:SetCategory(CATEGORY_DAMAGE)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetCost(cm.damcost)
	e9:SetTarget(cm.damtg)
	e9:SetOperation(cm.damop)
	c:RegisterEffect(e9)
	--to grave
	local e10=Effect.CreateEffect(c)
	e10:SetCategory(CATEGORY_TODECK)
	e10:SetType(EFFECT_TYPE_IGNITION)
	e10:SetRange(LOCATION_GRAVE)
	e10:SetCost(cm.tdcost)
	e10:SetTarget(cm.tdtg)
	e10:SetOperation(cm.tdop)
	c:RegisterEffect(e10)
end
	--spsummon condition
function cm.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
	--special summon rule
function cm.spfilter(c)
	return c:IsFusionSetCard(0xee7) and c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemoveAsCost()
end
function cm.fselect(c,tp,mg,sg)
	sg:AddCard(c)
	local res=false
	if sg:GetCount()<7 then
		res=mg:IsExists(cm.fselect,1,sg,tp,mg,sg)
	else
		res=Duel.GetLocationCountFromEx(tp,tp,sg)>0
	end
	sg:RemoveCard(c)
	return res
end
function cm.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(cm.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local sg=Group.CreateGroup()
	return mg:IsExists(cm.fselect,1,nil,tp,mg,sg)
end
function cm.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(cm.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local sg=Group.CreateGroup()
	while sg:GetCount()<7 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=mg:FilterSelect(tp,cm.fselect,1,1,sg,tp,mg,sg)
		sg:Merge(g)
	end
	local cg=sg:Filter(Card.IsFacedown,nil)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.Remove(sg,nil,2,REASON_COST)
end
	--add counter
function cm.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function cm.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x13,1)
end
	--Activate(effect)
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and (not re or re:GetOwner()~=c)
end
	--dice1
function cm.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		local h1=Duel.Draw(tp,1,REASON_EFFECT)
		local h2=Duel.Draw(1-tp,1,REASON_EFFECT)
		if h1>0 or h2>0 then Duel.BreakEffect() end
		if h1>0 then
			Duel.ShuffleHand(tp)
			Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
		if h2>0 then 
			Duel.ShuffleHand(1-tp)
			Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
		else
		if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g1=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,1,nil)
		if Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,nil) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g2=Duel.SelectTarget(1-tp,Card.IsAbleToDeck,1-tp,LOCATION_GRAVE,0,1,1,nil)
			g1:Merge(g2)
		end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	end
end
	--dice2
function cm.destg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function cm.desop1(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		local h1=Duel.Draw(tp,1,REASON_EFFECT)
		local h2=Duel.Draw(1-tp,1,REASON_EFFECT)
		if h1>0 or h2>0 then Duel.BreakEffect() end
		if h1>0 then
			Duel.ShuffleHand(tp)
			Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
		if h2>0 then 
			Duel.ShuffleHand(1-tp)
			Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
		else
		if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g1=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,1,nil)
		if Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,nil) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g2=Duel.SelectTarget(1-tp,Card.IsAbleToDeck,1-tp,LOCATION_GRAVE,0,1,1,nil)
			g1:Merge(g2)
		end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	end
end
	--dice3
function cm.condition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and (not re or re:GetOwner()~=c)
end
function cm.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function cm.desop2(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		local h1=Duel.Draw(tp,1,REASON_EFFECT)
		local h2=Duel.Draw(1-tp,1,REASON_EFFECT)
		if h1>0 or h2>0 then Duel.BreakEffect() end
		if h1>0 then
			Duel.ShuffleHand(tp)
			Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
		if h2>0 then 
			Duel.ShuffleHand(1-tp)
			Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		end
		else
		if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g1=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_GRAVE,0,1,1,nil)
		if Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_GRAVE,1,nil) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g2=Duel.SelectTarget(1-tp,Card.IsAbleToDeck,1-tp,LOCATION_GRAVE,0,1,1,nil)
			g1:Merge(g2)
		end
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	end
end
	--damage
function cm.damfilter(c)
	return c:GetCounter(0x13)>0
end
function cm.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCounter(tp,1,1,0x13)>0 end
	local g=Duel.GetMatchingGroup(cm.damfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	local sum=0
	while tc do
		local sct=tc:GetCounter(0x13)
		tc:RemoveCounter(tp,0x13,sct,0)
		sum=sum+sct
		tc=g:GetNext()
	end
	e:SetLabel(sum)
end
function cm.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*200)
end
function cm.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
	--to grave
function cm.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function cm.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,PLAYER_ALL,LOCATION_REMOVED)
end
function cm.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_REMOVED,LOCATION_REMOVED)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end