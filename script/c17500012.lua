--遗水元素法师 艾莉娅
function c17500012.initial_effect(c)
	c:EnableReviveLimit()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c17500012.target)
	e1:SetOperation(c17500012.operation)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c17500012.cost)
	e2:SetTarget(c17500012.hdtg)
	e2:SetOperation(c17500012.hdop)
	c:RegisterEffect(e2)
end
c17500012.setname="ElementalWizard"
function c17500012.matfil(c)
	return c:IsFusionAttribute(ATTRIBUTE_FIRE) and c:IsRace(RACE_SPELLCASTER)
end
function c17500012.filter(c)
	return c.setname=="ElementalSpell" and c:IsAbleToHand()
end
function c17500012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17500012.filter,tp,LOCATION_DECK,0,1,nil) and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c17500012.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17500012.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		if hg:GetCount()>0 then
			local sg=hg:RandomSelect(1-tp,1)
			Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		end
	end
end
function c17500012.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	local lp=Duel.GetLP(tp)
	local ma=math.floor(math.min(lp,8000)/2000)
	local gc=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local m=math.min(ma,gc)
	local t={}
	for i=1,m do
		t[i]=i*2000
	end
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.PayLPCost(tp,ac)
	local num=ac/2000
	e:SetLabel(num)
end
function c17500012.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	local num=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,num)
	e:GetHandler():RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(17500012,0))
end
function c17500012.hdop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local num=e:GetLabel()
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local gc=g:GetCount()
	local cg=math.min(num,gc)
	if cg>0 then
		local sg=g:RandomSelect(p,cg)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	end
end