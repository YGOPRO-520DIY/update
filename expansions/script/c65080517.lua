--淘气仙星·奥莉德
function c65080517.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xfb),2,99)
	c:EnableReviveLimit()
	 --destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c65080517.destg)
	e2:SetValue(c65080517.value)
	e2:SetOperation(c65080517.desop)
	c:RegisterEffect(e2)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65080517,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DAMAGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c65080517.spcon)
	e4:SetCost(c65080517.spcost)
	e4:SetTarget(c65080517.sptg)
	e4:SetOperation(c65080517.spop)
	c:RegisterEffect(e4)
	Duel.AddCustomActivityCounter(65080517,ACTIVITY_SPSUMMON,c65080517.counterfilter)
end
function c65080517.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r&REASON_EFFECT==REASON_EFFECT and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0xfb)
end
function c65080517.counterfilter(c)
	return c:IsSetCard(0xfb)
end
function c65080517.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(65080517,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c65080517.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c65080517.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0xfb)
end
function c65080517.spfilter2(c,e,tp)
	return c:IsSetCard(0xfb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65080517.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65080517.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) and e:GetHandler():GetFlagEffect(65080517)==0 end
	e:GetHandler():RegisterFlagEffect(65080517,RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c65080517.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65080517.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end


function c65080517.dfilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0xfb) and c:IsLocation(LOCATION_MZONE) and (c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)) and not c:IsReason(REASON_REPLACE)
end
function c65080517.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c65080517.dfilter,1,nil,tp)
		end
	return true
end
function c65080517.value(e,c)
	return c65080517.dfilter(c,e:GetHandlerPlayer())
end
function c65080517.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,65080517)
	Duel.Damage(tp,200,REASON_EFFECT)
	Duel.Damage(1-tp,200,REASON_EFFECT)
end