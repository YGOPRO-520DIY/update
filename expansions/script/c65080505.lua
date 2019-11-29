--花札卫-赤青短-
function c65080505.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_WARRIOR),2,99,c65080505.lcheck)
	c:EnableReviveLimit()
	--specialformdeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65080505,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c65080505.cost1)
	e1:SetTarget(c65080505.tar1)
	e1:SetOperation(c65080505.ope1)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65080505,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c65080505.sptg)
	e2:SetOperation(c65080505.spop)
	c:RegisterEffect(e2)
end
function c65080505.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0xe6)
end

function c65080505.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65080505.filter1,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c65080505.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	Duel.Release(tc,REASON_EFFECT)
	if tc:IsLevelAbove(1) then
		e:SetLabel(tc:GetLevel())
	end
end
function c65080505.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0xe6) and c:IsReleasable()
end
function c65080505.tar1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,tp,1)
end
function c65080505.spfil1(c,e,tp,lv)
	return c:IsSetCard(0xe6) and c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c65080505.ope1(e,tp,eg,ep,ev,re,r,rp)
	 local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		local g=Duel.GetOperatedGroup()
		local tc=g:GetFirst()
		Duel.ConfirmCards(1-tp,tc)
		Duel.BreakEffect()
		if tc:IsType(TYPE_MONSTER) and tc:IsSetCard(0xe6) then
			local lv=e:GetLabel()
			if Duel.IsExistingMatchingCard(c65080505.spfil1,tp,LOCATION_DECK,0,1,nil,e,tp,lv) and Duel.GetMZoneCount(tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(65080505,2)) then
				local g=Duel.SelectMatchingCard(tp,c65080505.spfil1,tp,LOCATION_DECK,0,1,1,nil,e,tp,lv)
				Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
			end
		else
			local mg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
			Duel.SendtoGrave(mg,REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
	 local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c65080505.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
end

function c65080505.spfil2(c,e,tp)
	return c:IsSetCard(0xe6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelAbove(7)
end
function c65080505.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65080505.spfil2,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c65080505.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	local g=Duel.SelectMatchingCard(tp,c65080505.spfil2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c65080505.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
end

function c65080505.splimit(e,c)
	return not c:IsSetCard(0xe6)
end
