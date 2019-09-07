--雪暴猎鹰的劫难
function c43694488.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c43694488.chantg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--defchange
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENSE)
	e3:SetValue(0)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_TO_HAND)
	e4:SetCondition(c43694488.con)
	e4:SetTarget(c43694488.tg)
	e4:SetOperation(c43694488.op)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e5)
	--blackhole
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c43694488.decon)
	e6:SetTarget(c43694488.detg)
	e6:SetOperation(c43694488.deop)
	c:RegisterEffect(e6)
end
function c43694488.chantg(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsRace(RACE_WINDBEAST)
end
function c43694488.fil(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsControler(tp) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousAttributeOnField()==ATTRIBUTE_WATER and c:GetPreviousRaceOnField()==RACE_WINDBEAST 
end
function c43694488.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c43694488.fil,1,nil,tp)
end
function c43694488.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local egg=eg:Filter(c43694488.fil,nil,tp)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,egg,egg:GetCount(),0,0)
end
function c43694488.op(e,tp,eg,ep,ev,re,r,rp)
	local egg=eg:Filter(c43694488.fil,nil,tp)
	local ft=Duel.GetMZoneCount(tp)
	local spg=egg:FilterSelect(tp,Card.IsCanBeSpecialSummoned,ft,ft,nil,e,0,tp,false,false)
	if spg:GetCount()>0 and Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if spg:GetCount()>0 then
		Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c43694488.defil(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsRace(RACE_WINDBEAST) and c:IsFaceup()
end
function c43694488.decon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c43694488.defil,tp,LOCATION_MZONE,0,1,nil) 
end
function c43694488.dedefil(c,e)
	return c:IsImmuneToEffect(e) or not c:IsDestructable(e)
end
function c43694488.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	local km=Duel.GetMatchingGroup(c43694488.dedefil,tp,LOCATION_MZONE,0,nil,e)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c43694488.deop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if Duel.Destroy(sg,REASON_EFFECT)~=0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,43694494,0,0x4011,1000,1000,4,RACE_WINDBEAST,ATTRIBUTE_WATER) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,43694494)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(43694481)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end