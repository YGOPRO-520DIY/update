--圣刻龙-穆特龙
function c88990321.initial_effect(c)
	c:SetSPSummonOnce(88990321)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFunRep(c,c88990321.mfilter1,c88990321.matfilter,1,1,true)
	aux.AddContactFusionProcedure(c,c88990321.cfilter,LOCATION_MZONE,LOCATION_MZONE,c88990321.sprop(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c88990321.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88990321,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_RELEASE)
	e2:SetTarget(c88990321.sptg)
	e2:SetOperation(c88990321.spop)
	c:RegisterEffect(e2)


end
c88990321.material_setcode=0x69
function c88990321.mfilter1(c)
	return c:IsFusionSetCard(0x69) and c:IsLevelAbove(5)
end
function c88990321.matfilter(c)
	--return c:GetSequence()>4 and 
	return c:GetSummonLocation()==LOCATION_EXTRA
end
function c88990321.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c88990321.cfilter(c,fc)
	return c:IsControler(fc:GetControler()) or c:IsFaceup()
end
function c88990321.sprop(c)
	return	function(g)
				Duel.Release(g,REASON_COST)
				local e3=Effect.CreateEffect(c)
	            e3:SetType(EFFECT_TYPE_FIELD)
	            e3:SetCode(EFFECT_CHANGE_DAMAGE)
	            e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	            e3:SetTargetRange(0,1)
	            e3:SetValue(c88990321.val)
	            e3:SetReset(RESET_PHASE+PHASE_END)
	            Duel.RegisterEffect(e3,tp)
			end

end
function c88990321.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then
		return dam/2
	else return dam end
end
--spsummon
function c88990321.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88990321.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c88990321.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c88990321.spfilter),tp,0x13,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end