--星曜成像
function c21520140.initial_effect(c)
	--activity
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520140,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CUSTOM+21520140)
	e1:SetCondition(c21520140.condition)
	e1:SetTarget(c21520140.target)
	e1:SetOperation(c21520140.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetRange(0xff)
	e2:SetTargetRange(1,1)
	e2:SetOperation(c21520140.reset)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21520140,1))
	e3:SetCategory(CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c21520140.thcost)
	e3:SetTarget(c21520140.thtg)
	e3:SetOperation(c21520140.thop)
	c:RegisterEffect(e3)
	if not c21520140.global_check then
		c21520140.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c21520140.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c21520140.checkop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Group.CreateGroup()
	local tc=eg:GetFirst()
	while tc do
		if tc:IsSetCard(0x5491) and tc:IsType(TYPE_MONSTER) then
			tc:RegisterFlagEffect(21520140,RESET_PHASE+PHASE_END,0,1,tc:GetLocation())
			mg:AddCard(tc)
		end
		tc=eg:GetNext()
	end
	if mg:GetCount()>0 then Duel.RaiseEvent(mg,EVENT_CUSTOM+21520140,e,0,0,0,0) end
end
function c21520140.cfilter(c,e,tp)
	return c:IsSetCard(0x5491) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetFlagEffect(21520140)~=0
end
function c21520140.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21520140.cfilter,tp,0xff,0xff,1,nil,e,tp)
end
function c21520140.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(tp) end
	local labs={}
	local label=1
	local g=Duel.GetMatchingGroup(c21520140.cfilter,tp,0xff,0xff,nil,e,tp)
	for tc in aux.Next(g) do
		labs[label]=tc:GetFlagEffectLabel(21520140)
		label=label+1
	end
	label=0
	for k,v in ipairs(labs) do
		if v&label ~= v then label=label+labs[k] end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,label)
end
function c21520140.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.GetMatchingGroup(c21520140.cfilter,tp,0xff,0xff,nil,e,tp)
	if g:GetCount()<=0 then return end
	local sg=g:Select(tp,1,1,nil)
	local tc=sg:GetFirst()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	if not tc:IsImmuneToEffect(e) then
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
		local atk=(tc:GetBaseAttack())/2
		Duel.Damage(1-tp,atk,REASON_EFFECT)
		tc:ResetFlagEffect(21520140)
		Duel.SpecialSummonComplete()
	end
end
function c21520140.reset(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c21520140.cfilter,tp,0xff,0xff,nil,e,tp)
	local tc=sg:GetFirst()
	while tc do
		tc:ResetFlagEffect(21520140)
		tc=sg:GetNext()
	end
end
function c21520140.thfilter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x5491) and c:IsType(TYPE_MONSTER)
end
function c21520140.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c21520140.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520140.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK)
end
function c21520140.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520140.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
