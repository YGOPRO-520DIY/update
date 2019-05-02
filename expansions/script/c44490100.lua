--好对手的羁绊
function c44490100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44490100,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44490100+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCost(c44490100.cost)
	e1:SetTarget(c44490100.target)
	e1:SetOperation(c44490100.activate)
	c:RegisterEffect(e1)
end
c44490100.card_code_list={89631139,46986414}
function c44490100.cfilter(c)
	return c:IsDiscardable()
	and (c:IsSetCard(0xdd) or c:IsSetCard(0x10a2))
end
function c44490100.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490100.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c44490100.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c44490100.filter0(c)
	return c:IsFaceup() and c:IsCanBeFusionMaterial()
end
function c44490100.filter1(c,e)
	return c:IsFaceup() and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c44490100.filter2(c,e,tp,m,f,chkf)
	return c44490100.spfilter(c) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c44490100.filter3(c,e)
	return not c:IsImmuneToEffect(e)
end
function c44490100.spfilter(c)
	return aux.IsMaterialListCode(c,89631139)
	or aux.IsMaterialListCode(c,46986414)
end
function c44490100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp)
		local mg2=Duel.GetMatchingGroup(c44490100.filter0,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,nil)
		mg1:Merge(mg2)
		local res=Duel.IsExistingMatchingCard(c44490100.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c44490100.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c44490100.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c44490100.filter3,nil,e)
	local mg2=Duel.GetMatchingGroup(c44490100.filter1,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,nil,e)
	mg1:Merge(mg2)
	local sg1=Duel.GetMatchingGroup(c44490100.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg3=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg3=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c44490100.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,chkf)
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
			Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg3,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end