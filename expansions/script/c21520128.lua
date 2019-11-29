--朱星曜兽-轸水蚓
function c21520128.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520128,0))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c21520128.condition)
	e2:SetCost(c21520128.cost)
	e2:SetTarget(c21520128.target)
	e2:SetOperation(c21520128.operation)
	c:RegisterEffect(e2)
end
function c21520128.effectfilter(c)
	return c:IsCode(21520133) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21520128.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21520128.effectfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
end
function c21520128.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c21520128.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c21520128.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetDecktopGroup(p,1)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.ConfirmCards(1-p,g)
	local ct=Duel.GetLocationCount(p,LOCATION_MZONE)
	if g:GetFirst():IsSetCard(0xc491) and g:GetFirst():IsType(TYPE_MONSTER) and ct>0 
		and Duel.IsExistingMatchingCard(c21520128.spfilter,p,LOCATION_DECK,0,1,nil,e,p) and Duel.SelectYesNo(p,aux.Stringid(21520128,1)) then 
		local dg=Duel.GetMatchingGroup(c21520128.spfilter,p,LOCATION_DECK,0,nil,e,p)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=dg:Select(p,1,math.min(2,ct),nil)
		Duel.SpecialSummon(sg,0,p,p,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-p,sg)
	end
end
function c21520128.spfilter(c,e,tp)
	return c:IsCode(21520128) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
