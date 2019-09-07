local m=13520153
local cm=_G["c"..m]
cm.name="翠雾谷的毒蘑菇"
function cm.initial_effect(c)
	--Fusion
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(cm.sptg)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
	--Move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(cm.mvcon)
	e2:SetTarget(cm.mvtg)
	e2:SetOperation(cm.mvop)
	c:RegisterEffect(e2)
end
--Fusion
function cm.mfilter1(c,e)
	return c:IsOnField() and (not e or not c:IsImmuneToEffect(e))
end
function cm.mfilter2(c,e)
	return c:IsFaceup() and c:IsCanBeFusionMaterial() and (not e or not c:IsImmuneToEffect(e))
end
function cm.spfilter(c,e,tp,m,f,chkf)
	return c:IsRace(RACE_PLANT) and c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg1=Duel.GetFusionMaterial(tp):Filter(cm.mfilter1,nil)
		local mg2=Duel.GetMatchingGroup(cm.mfilter2,tp,0,LOCATION_MZONE,nil)
		mg1:Merge(mg2)
		local res=Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,tp)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,tp)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	local mg1=Duel.GetFusionMaterial(tp):Filter(cm.mfilter1,nil,e)
	local mg2=Duel.GetMatchingGroup(cm.mfilter2,tp,0,LOCATION_MZONE,nil,e)
	mg1:Merge(mg2)
	local sg1=Duel.GetMatchingGroup(cm.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,tp)
	local mg3,sg2
	local ce=Duel.GetChainMaterial(tp)
	if ce then
		local fgroup=ce:GetTarget()
		mg3=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(cm.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,tp)
	end
	if sg1:GetCount()>0 or (sg2 and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=sg:Select(tp,1,1,nil)
		local tc=g:GetFirst()
		if sg1:IsContains(tc) and (not sg2 or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,tp)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg3,nil,tp)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
--Move
function cm.mvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function cm.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0
		and Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,2))
	Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,nil)
end
function cm.mvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end