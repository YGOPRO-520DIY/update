--灰篮小龙
function c65080516.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,65080516)
	e1:SetTarget(c65080516.target)
	e1:SetOperation(c65080516.activate)
	c:RegisterEffect(e1)
	 --synchro effect
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
	e2:SetCondition(c65080516.sccon)
	e2:SetTarget(c65080516.sctg)
	e2:SetOperation(c65080516.scop)
	c:RegisterEffect(e2)
end
function c65080516.sccon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp then return false end
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2
end
function c65080516.mfilter(c,mg)
	return c:IsSetCard(0xd1) and c:IsSynchroSummonable(nil,mg)
end
function c65080516.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(c65080516.mfilter,tp,LOCATION_EXTRA,0,1,nil,mg) and e:GetHandler():GetFlagEffect(65080516)==0
	end
	e:GetHandler():RegisterFlagEffect(65080516,RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c65080516.scop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c65080516.mfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
	end
end

function c65080516.spfilter(c,e,tp)
	return c:IsSetCard(0xd1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsType(TYPE_SYNCHRO)
end
function c65080516.filter(c,e,tp)
	local sg=Duel.GetMatchingGroup(c65080516.spfilter,tp,LOCATION_GRAVE,0,c,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	return (sg:IsExists(c65080516.rfilter,1,nil,c) or sg:CheckWithSumEqual(Card.GetLevel,c:GetLevel(),1,ft)) and c:IsSetCard(0xd1) and c:IsFaceup() and Duel.GetMZoneCount(tp,c,tp)>2
end
function c65080516.rfilter(c,mc)
	local mlv=mc:GetRitualLevel(c)
	if mlv==mc:GetLevel() then return false end
	local lv=c:GetLevel()
	return lv==bit.band(mlv,0xffff) or lv==bit.rshift(mlv,16)
end
function c65080516.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c65080516.filter(chkc,e,tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then
		return Duel.IsExistingTarget(c65080516.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	local g=Duel.SelectTarget(tp,c65080516.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c65080516.activate(e,tp,eg,ep,ev,re,r,rp)
	local mc=Duel.GetFirstTarget()
	if mc:IsRelateToEffect(e) and Duel.Destroy(mc,REASON_EFFECT)~=0 then
	if e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.BreakEffect()
		local sg=Duel.GetMatchingGroup(c65080516.spfilter,tp,LOCATION_GRAVE,0,mc,e,tp)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<0 then return end
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		local b1=sg:IsExists(c65080516.rfilter,1,nil,mc)
		local b2=sg:CheckWithSumEqual(Card.GetLevel,mc:GetLevel(),1,ft)
		if b1 and (not b2 or Duel.SelectYesNo(tp,aux.Stringid(65080516,0))) then
			local tg=sg:FilterSelect(tp,c65080516.rfilter,1,1,nil,mc)
			local tc=tg:GetFirst()
			Duel.SpecialSummon(tc,0,tp,tp,false,true,POS_FACEUP)
		else
			local tg=sg:SelectWithSumEqual(tp,Card.GetLevel,mc:GetLevel(),1,ft)
			local tc=tg:GetFirst()
			while tc do
				Duel.SpecialSummonStep(tc,0,tp,tp,false,true,POS_FACEUP)
				tc=tg:GetNext()
			end
			Duel.SpecialSummonComplete()
		end
	end
	end
end