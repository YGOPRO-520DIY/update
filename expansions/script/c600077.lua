--圣骑士 混沌战士
function c600077.initial_effect(c)
	--summon with s & t
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600077,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c600077.otcon)
	e1:SetOperation(c600077.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)	
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCountLimit(1,600077)
	e2:SetCost(c600077.cost)
	e2:SetTarget(c600077.thtg)
	e2:SetOperation(c600077.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--become material
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c600077.mtcon)
	e4:SetOperation(c600077.mtop)
	c:RegisterEffect(e4)
end
function c600077.otfilter(c)
	return c:IsSetCard(0xbd) and c:IsType(TYPE_MONSTER) and c:IsReleasable()
end
function c600077.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c600077.otfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg:GetCount()>=2)
		or (Duel.CheckTribute(c,1) and mg:GetCount()>=1)
end
function c600077.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c600077.otfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil)
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
		and (g:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(600077,1))) then
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
function c600077.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c600077.filter(c)
	return (c:IsType(TYPE_RITUAL) and c:IsType(TYPE_SPELL)) or (c:IsType(TYPE_RITUAL) and c:IsSetCard(0x10cf)) and c:IsAbleToHand()
end
function c600077.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600077.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	if Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_ONFIELD,0,nil,40089744)>=1 then
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DRAW)
	end
end
function c600077.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c600077.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		if Duel.IsPlayerCanDraw(tp,1)
			and Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_ONFIELD,0,nil,40089744)>=1
			and Duel.SelectYesNo(tp,aux.Stringid(600077,3)) then
			Duel.BreakEffect()
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
function c600077.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RITUAL
end
function c600077.mtop(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	while rc do
		if rc:GetFlagEffect(600077)==0 then
			--untargetable
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(600077,2))
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
			e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
			e2:SetValue(aux.tgoval)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e2,true)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e3:SetRange(LOCATION_MZONE)
			e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e3:SetValue(c600077.indval)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			rc:RegisterEffect(e3,true)
			rc:RegisterFlagEffect(600077,RESET_EVENT+0x1fe0000,0,1)
		end
		rc=eg:GetNext()
	end
end
function c600077.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end