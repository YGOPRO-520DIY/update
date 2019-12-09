--夜光青袅
function c44422206.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c44422206.lcheck)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44422206,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,44422206)
	e1:SetCondition(c44422206.spcon)
	e1:SetCost(c44422206.spcost)
	e1:SetTarget(c44422206.sptg)
	e1:SetOperation(c44422206.spop)
	c:RegisterEffect(e1)
	--damage conversion
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44422206,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1,44422206)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c44422206.descon)
	e2:SetOperation(c44422206.operation)
	c:RegisterEffect(e2)
end
--link summon
function c44422206.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end
--special summon
function c44422206.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c44422206.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c44422206.spfilter(c,e,tp)
	return c:IsRace(RACE_DRAGON+RACE_WINDBEAST)
	and c:GetAttack()==600 and c:GetLevel()==1
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44422206.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44422206.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	if e:GetHandler():GetMutualLinkedGroupCount()>0 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
		e:SetLabel(1)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetLabel(0)
	end
end
function c44422206.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c44422206.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
	    local tc=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end


end
--damage conversion
function c44422206.descon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():GetPreviousControler()==tp
end
function c44422206.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c44422206.valcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c44422206.valcon(e,re,r,rp,rc)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		if Duel.GetFlagEffect(tp,44422206)==0 then
			Duel.RegisterFlagEffect(tp,44422206,RESET_PHASE+PHASE_END,0,1)
			return true
		end
	end
	return false
end
