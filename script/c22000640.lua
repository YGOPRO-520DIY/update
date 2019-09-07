--从者Lancer 贞德·A·S·L
function c22000640.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(22000640,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,22000640)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c22000640.target)
	e1:SetOperation(c22000640.operation)
	c:RegisterEffect(e1) 
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22000640,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,22000640)
	e2:SetTarget(c22000640.sptg)
	e2:SetOperation(c22000640.spop)
	c:RegisterEffect(e2) 
end
function c22000640.filter(c,e,tp,m,ft)
	if not (c:IsCode(22000240) or c:IsCode(22000250)) or bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c:IsCode(21105106) then return c:ritual_custom_condition(mg,ft) end
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	if ft>0 then
		return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
	else
		return ft>-1 and mg:IsExists(c22000640.mfilterf,1,nil,tp,mg,c)
	end
end
function c22000640.mfilterf(c,tp,mg,rc)
	if c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5 then
		Duel.SetSelectedCard(c)
		return mg:CheckWithSumEqual(Card.GetRitualLevel,rc:GetLevel(),0,99,rc)
	else return false end
end
function c22000640.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		return Duel.IsExistingMatchingCard(c22000640.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,mg,ft)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c22000640.operation(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetRitualMaterial(tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c22000640.filter),tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,mg,ft)
	local tc=tg:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if tc:IsCode(21105106) then
			tc:ritual_custom_operation(mg)
			local mat=tc:GetMaterial()
			Duel.ReleaseRitualMaterial(mat)
		else
			if tc.mat_filter then
				mg=mg:Filter(tc.mat_filter,nil)
			end
			local mat=nil
			if ft>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
			else
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				mat=mg:FilterSelect(tp,c22000640.mfilterf,1,1,nil,tp,mg,tc)
				Duel.SetSelectedCard(mat)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				local mat2=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),0,99,tc)
				mat:Merge(mat2)
			end
			tc:SetMaterial(mat)
			Duel.ReleaseRitualMaterial(mat)
		end
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c22000640.filter1(c,e,tp,rk)
	return c:IsCode(22000190) and e:GetHandler():IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c22000640.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c22000640.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler():GetRank()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c22000640.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp,tp,c)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c22000640.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c:GetRank())
	local sc=g:GetFirst()
	if sc then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(c))
		Duel.Overlay(sc,Group.FromCards(c))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end