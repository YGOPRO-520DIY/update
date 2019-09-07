--自成仙体-天依·惊蛰
function c44460112.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44460112.matfilter,1,1)
	--xy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460112,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460112.xycost)
	e1:SetTarget(c44460112.xytg)
	e1:SetOperation(c44460112.xyop)
	c:RegisterEffect(e1)
	--draw and summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460112,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCountLimit(1,44460112)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c44460112.drtg)
	e2:SetOperation(c44460112.drop)
	c:RegisterEffect(e2)

end
function c44460112.matfilter(c,lc,sumtype,tp)
	return c:IsLinkCode(44460014)
end
--xy
function c44460112.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460112.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460014) and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	tc:CreateEffectRelation(e)
	Duel.SetChainLimit(c44460112.climit)
end
function c44460112.xyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
end
function c44460112.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--draw and summon
function c44460112.filter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44460112.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2
		and Duel.IsExistingMatchingCard(c44460112.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,LOCATION_DECK)
end
function c44460112.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3):Filter(c44460112.filter,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if g:GetCount()>0 then
		if ft<=0 then
			Duel.SendtoGrave(g,REASON_EFFECT)
		elseif ft>=g:GetCount() then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,ft,ft,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			g:Sub(sg)
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
	end
	Duel.ShuffleDeck(tp)
end