--魔骑士 混沌战士
function c600078.initial_effect(c)
	--summon with s & t
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600078,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c600078.otcon)
	e1:SetOperation(c600078.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)	 
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600078,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCountLimit(1,600078)
	e2:SetCost(c600078.cost)
	e2:SetTarget(c600078.drtg)
	e2:SetOperation(c600078.drop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)   
	--become material
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c600078.mtcon)
	e4:SetOperation(c600078.mtop)
	c:RegisterEffect(e4)
end
function c600078.otfilter(c)
	return  c:IsSetCard(0xbd) and c:IsType(TYPE_MONSTER) and c:IsReleasable()
end
function c600078.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c600078.otfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg:GetCount()>=2)
		or (Duel.CheckTribute(c,1) and mg:GetCount()>=1)
end
function c600078.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c600078.otfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)
	local ct=2
	local g=Group.CreateGroup()
	if Duel.GetTributeCount(c)<ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=mg:Select(tp,ct-Duel.GetTributeCount(c),ct-Duel.GetTributeCount(c),nil)
		g:Merge(g2)
		mg:Sub(g2)
		ct=ct-g2:GetCount()
	end
	if ct>0 and Duel.GetTributeCount(c)>=ct and mg:GetCount()>0
		and (g:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(600078,1))) then
		local ect=ct
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then ect=ect-1 end
		ect=math.min(mg:GetCount(),ect)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g3=mg:Select(tp,1,ect,nil)
		g:Merge(g3)
		ct=ct-g3:GetCount()
	end
	if ct>0 then
		local g4=Duel.SelectTribute(tp,c,ct,ct)
		g:Merge(g4)
	end
	c:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_SUMMON+REASON_MATERIAL+REASON_RELEASE)
end
function c600078.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c600078.drfilter(c)
	return c:IsAbleToDeck()
end
function c600078.ctfilter(c)
	return c:IsFaceup() and c:IsCode(40089744)
end
function c600078.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=1
	if Duel.IsExistingMatchingCard(c600078.ctfilter,tp,LOCATION_ONFIELD,0,1,nil) then ct=2 end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c600078.drfilter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) and Duel.IsExistingTarget(c600078.drfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c600078.drfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,3,3,nil)
	e:SetLabel(ct)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c600078.drop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)==0 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,e:GetLabel(),REASON_EFFECT)
	end
end
function c600078.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c600078.mtop(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(600078)==0 then
			--untargetable
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(600078,2))
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(1500)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_IMMUNE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(c600078.efilter)
			e2:SetOwnerPlayer(tp)
			rc:RegisterEffect(e2,true)
			rc:RegisterFlagEffect(600078,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end
function c600078.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end