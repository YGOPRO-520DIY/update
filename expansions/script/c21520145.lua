--折光的星曜
function c21520145.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520145,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c21520145.condition)
	e1:SetTarget(c21520145.target)
	e1:SetOperation(c21520145.activate)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520145,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c21520145.spcost)
	e2:SetTarget(c21520145.sptg)
	e2:SetOperation(c21520145.spop)
	c:RegisterEffect(e2)
end
function c21520145.filter(c)
	return c:IsFaceup() and c:IsCode(21520133)
end
function c21520145.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c21520145.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c21520145.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetAttacker()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c21520145.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not Duel.NegateAttack() then return end
	if tc:IsRelateToEffect(e) then
		Duel.NegateAttack()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then 
			Duel.BreakEffect()
			local ct=math.floor(tc:GetAttack()/1000)
			Duel.Draw(tp,ct,REASON_EFFECT)
		end
	end
end
function c21520145.spfilter(c,e,tp)
	return c:IsAbleToHand() and c:IsSetCard(0x491) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21520145.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c21520145.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21520145.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c21520145.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520145.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
