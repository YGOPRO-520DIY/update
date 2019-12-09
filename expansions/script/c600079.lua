--见习之暗黑骑士 盖亚
function c600079.initial_effect(c)
	--fusion summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600079,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,600079)
	e1:SetCondition(c600079.fucon)
	e1:SetTarget(c600079.futg)
	e1:SetOperation(c600079.fuop)
	c:RegisterEffect(e1)	
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600079,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,6000079)
	e2:SetCondition(c600079.spcon)
	e2:SetTarget(c600079.sptg)
	e2:SetOperation(c600079.spop)
	c:RegisterEffect(e2)
	--Attribute Dark
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_ADD_ATTRIBUTE)
	e3:SetRange(LOCATION_DECK)
	e3:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e3)
	--Attribute light
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_ADD_ATTRIBUTE)
	e4:SetRange(LOCATION_DECK)
	e4:SetValue(ATTRIBUTE_LIGHT)
	c:RegisterEffect(e4)
end
function c600079.c1filter(c)
	return c:IsFaceup() and c:IsCode(40089744)
end
function c600079.fucon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c600079.c1filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c600079.filter1(c,e)
	return c:IsAbleToGrave() and not c:IsImmuneToEffect(e)
end
function c600079.exfilter0(c)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeFusionMaterial() and c:IsAbleToGrave()
end
function c600079.exfilter1(c,e)
	return c600079.exfilter0(c) and not c:IsImmuneToEffect(e)
end
function c600079.filter2(c,e,tp,mg1,f,chkf,exg,ischeck)
	return c:IsType(TYPE_FUSION) and (c:IsCode(600081) or c:IsCode(2519690) or c:IsCode(62873545) or c:IsCode(66889139)) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and ((c:CheckFusionMaterial(mg1,nil,chkf) and ischeck==2) or (exg:IsExists(c600079.checkfilter,1,c,mg1,c,chkf) and ischeck~=0 and Duel.GetFlagEffect(tp,600079)<=0))
end
function c600079.checkfilter(c,mg1,fc,chkf)
	local mg2=mg1:Filter(Card.IsLocation,nil,LOCATION_MZONE)
	mg2:AddCard(c)
	return fc:CheckFusionMaterial(mg2,c,chkf)
end
function c600079.futg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(Card.IsAbleToGrave,nil)
		local exg=Duel.GetMatchingGroup(c600079.exfilter0,tp,LOCATION_EXTRA,0,nil)
		local res=Duel.IsExistingMatchingCard(c600079.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf,exg,2)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c600079.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf,exg,0)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c600079.fuop(e,tp,eg,ep,ev,re,r,rp)
	local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c600079.filter1,nil,e)
	local exg=Duel.GetMatchingGroup(c600079.exfilter1,tp,LOCATION_EXTRA,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c600079.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf,exg,2)
	local sgex=Duel.GetMatchingGroup(c600079.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf,exg,1)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c600079.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf,exg,0)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		local fmc=nil
		mg1:RemoveCard(tc)
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			if sgex:GetCount()>0 and sgex:IsContains(tc) and Duel.SelectYesNo(tp,aux.Stringid(600079,2)) then
			   Duel.RegisterFlagEffect(tp,600079,RESET_PHASE+PHASE_END,0,1)
			   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			   fmc=exg:FilterSelect(tp,c600079.checkfilter,1,1,nil,mg1,tc,chkf):GetFirst()
			   mg1=mg1:Filter(Card.IsLocation,nil,LOCATION_MZONE)
			end
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,fmc,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
function c600079.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_RELEASE)
end
function c600079.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c600079.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_TUNER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		Duel.SpecialSummonComplete()
	end
end
