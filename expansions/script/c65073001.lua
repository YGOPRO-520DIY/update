--起源龙 始混沌龙
function c65073001.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,65073001)
	e1:SetTarget(c65073001.tg)
	e1:SetOperation(c65073001.op)
	c:RegisterEffect(e1)
end
function c65073001.filter1(c,e)
	return c:IsLocation(LOCATION_MZONE) and not c:IsImmuneToEffect(e)
end
function c65073001.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf) and c:IsRace(RACE_DRAGON) and c:IsLevel(9)
end
function c65073001.synablefil(c)
	return c:IsRace(RACE_DRAGON) and c:IsLevel(9) and c:IsSynchroSummonable(nil)
end
function c65073001.xyzfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsRank(9) and c:IsXyzSummonable(nil)
end
function c65073001.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsLink(4) and c:IsLinkSummonable(nil) 
end
function c65073001.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	 local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(Card.IsLocation,nil,LOCATION_MZONE)
		local res=Duel.IsExistingMatchingCard(c65073001.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c65073001.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
	local b1=res
	local b2=Duel.IsExistingMatchingCard(c65073001.synablefil,tp,LOCATION_EXTRA,0,1,nil)
	local b3=Duel.IsExistingMatchingCard(c65073001.xyzfilter,tp,LOCATION_EXTRA,0,1,nil)
	local b4=Duel.IsExistingMatchingCard(c65073001.filter,tp,LOCATION_EXTRA,0,1,nil)
	if chk==0 then return b1 or b2 or b3 or b4 end
	local op=99
	if b1 and b2 and b3 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,1),aux.Stringid(65073001,2),aux.Stringid(65073001,3))
	elseif b1 and b2 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,1),aux.Stringid(65073001,2))
	elseif b1 and b2 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,1),aux.Stringid(65073001,3))
		if op==2 then op=3 end
	elseif b1 and b3 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,2),aux.Stringid(65073001,3))
		if op>=1 then op=op+1 end
	 elseif b2 and b3 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,1),aux.Stringid(65073001,2),aux.Stringid(65073001,3))+1
	elseif b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,1))
	elseif b1 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,2))
		if op==1 then op=2 end
	elseif b1 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0),aux.Stringid(65073001,3))
		if op==1 then op=3 end
	elseif b2 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,1),aux.Stringid(65073001,2))+1
	elseif b2 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,1),aux.Stringid(65073001,3))+1
		if op==2 then op=3 end
	elseif b3 and b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,2),aux.Stringid(65073001,3))+2
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,0))
	elseif b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,1))+1
	elseif b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,2))+2
	elseif b4 then
		op=Duel.SelectOption(tp,aux.Stringid(65073001,3))+3
	end
	e:SetLabel(op)
	if b1 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c65073001.op(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==0 then
		local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c65073001.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c65073001.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c65073001.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
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
	elseif op==1 then
		 local g=Duel.GetMatchingGroup(c65073001.synablefil,tp,LOCATION_EXTRA,0,nil,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil)
	end
	elseif op==2 then
		local g=Duel.GetMatchingGroup(c65073001.xyzfilter,tp,LOCATION_EXTRA,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=g:Select(tp,1,1,nil)
		Duel.XyzSummon(tp,tg:GetFirst(),nil)
	end
	elseif op==3 then
		 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65073001.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.LinkSummon(tp,tc,nil)
	end
	end
end