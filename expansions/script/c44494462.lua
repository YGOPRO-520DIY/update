--白狮黑雪
function c44494462.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44494462.matfilter,1)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c44494462.matcheck)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44494462,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,44494462+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c44494462.spcon)
	e2:SetCost(c44494462.spcost)
	e2:SetTarget(c44494462.sptg2)
	e2:SetOperation(c44494462.spop2)
	c:RegisterEffect(e2)
end
function c44494462.matfilter(c)
	return c:GetDefense()>=2500
end


function c44494462.matcheck(e,c)
	local g=c:GetMaterial():Filter(c44494462.matfilter,nil)
	local atk=g:GetSum(Card.GetBaseAttack)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk/2)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
--special summon
function c44494462.cfilter1(c,tc)
	return c:GetAttack()>=2500 and c:GetDefense()>=2500
	and c:IsAbleToRemoveAsCost()
	--and not c:IsRace(tc:GetRace())
	and c:IsType(TYPE_MONSTER)
end
function c44494462.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44494462.cfilter1,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44494462.cfilter1,tp,LOCATION_GRAVE,0,1,1,nil)

	local ac=g:GetFirst():GetRace()
	e:SetLabel(ac)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end

function c44494462.cfilter(c,tp)
	return c:IsFaceup() and c:GetSummonPlayer()==tp and c:IsCode(44494461)
end
function c44494462.sfilter(c)
	return c:IsFaceup() and c:IsCode(44494461,44494462)
end
function c44494462.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44494462.cfilter,1,nil,tp)
end
function c44494462.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44494462.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local g=Duel.GetMatchingGroup(c44494462.sfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end