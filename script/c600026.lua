--升阶魔法-光波冲击
function c600026.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600026,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetCondition(c600026.condition)
	e1:SetTarget(c600026.target)
	e1:SetOperation(c600026.activate)
	c:RegisterEffect(e1)
end
function c600026.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c600026.condition(e,tp,eg,ep,ev,re,r,rp)
	return  not Duel.IsExistingMatchingCard(c600026.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c600026.filter1(c,e,tp)
	return c:IsSetCard(0xe5) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsExistingMatchingCard(c600026.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetRank()+1)
end
function c600026.filter2(c,e,tp,mc,rk)
	return c:GetRank()==rk and c:IsSetCard(0xe5) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c600026.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c600026.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c600026.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c600026.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,tp,LOCATION_EXTRA)
end
function c600026.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600026.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1)
	local sc=g:GetFirst()
	if sc then
		Duel.BreakEffect()
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
		if c:IsRelateToEffect(e) then
			c:CancelToGrave()
			Duel.Overlay(sc,Group.FromCards(c))
		end
	end
end