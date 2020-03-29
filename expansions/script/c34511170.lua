--乾 纱凪
function c34511170.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--fusion (p)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,34511170)
	e1:SetTarget(c34511170.pentg)
	e1:SetOperation(c34511170.penop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34511170,3))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c34511170.spcon)
	e2:SetTarget(c34511170.sptg)
	e2:SetOperation(c34511170.spop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,34511171)
	e3:SetTarget(c34511170.mftg)
	e3:SetOperation(c34511170.mfop)
	c:RegisterEffect(e3)
end
function c34511170.penfilter(c)
	return c:IsSetCard(0xac5) and c:IsType(TYPE_PENDULUM) and not c:IsCode(34511170) and not c:IsForbidden()
end
function c34511170.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable()
		and Duel.IsExistingMatchingCard(c34511170.penfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c34511170.penop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,c34511170.penfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end
function c34511170.spcfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c34511170.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c34511170.spcfilter,1,nil,tp)
end
function c34511170.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c34511170.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 then
		return
	end
	local ec=eg:GetFirst()
	while ec do
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:GetOriginalType(TYPE_PENDULUM)) and (not ec:GetOriginalType(TYPE_LINK)) and (not ec:GetOriginalType(TYPE_TOKEN)) and ec:IsPreviousPosition(POS_FACEDOWN) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then 
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEDOWN_DEFENSE)
	end
-------------------------------
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:GetOriginalType(TYPE_PENDULUM)) and (not ec:GetOriginalType(TYPE_TOKEN)) and ec:IsPreviousPosition(POS_FACEUP_ATTACK) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1))  then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	end
-------------------------------
	if ec:IsPreviousLocation(LOCATION_SZONE) and (not ec:IsForbidden()) and ec:IsPreviousPosition(POS_FACEDOWN) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,4)) then
		Duel.MoveToField(ec,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
	end
------------------------------
	if ec:IsPreviousLocation(LOCATION_SZONE) and ec:IsPreviousPosition(POS_FACEUP) and (not ec:IsForbidden()) and (not ec:GetOriginalType(TYPE_PENDULUM)) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,4)) then
		Duel.MoveToField(ec,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
------------------------------
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:GetOriginalType(TYPE_PENDULUM)) and (not ec:GetOriginalType(TYPE_TOKEN)) and ec:IsPreviousPosition(POS_FACEUP_DEFENSE) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then 
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
------------------------
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:IsLocation(LOCATION_EXTRA)) and ec:GetOriginalType(TYPE_PENDULUM) and ec:IsPreviousPosition(POS_FACEDOWN) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEDOWN_DEFENSE)
	end
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:IsLocation(LOCATION_EXTRA)) and ec:GetOriginalType(TYPE_PENDULUM) and ec:IsPreviousPosition(POS_FACEUP_ATTACK) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1))  then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	end
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:IsLocation(LOCATION_EXTRA)) and ec:GetOriginalType(TYPE_PENDULUM) and ec:IsPreviousPosition(POS_FACEUP_DEFENSE) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then 
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
----------------------------
	if ec:IsPreviousLocation(LOCATION_SZONE) and ec:IsPreviousPosition(POS_FACEUP) and (not ec:IsForbidden()) and ec:GetOriginalType(TYPE_PENDULUM) and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1)) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,4)) then
		Duel.MoveToField(ec,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
------------------------
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and ec:IsLocation(LOCATION_EXTRA) and ec:GetOriginalType(TYPE_PENDULUM) and ec:IsPreviousPosition(POS_FACEDOWN) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEDOWN_DEFENSE)
	end
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and ec:IsLocation(LOCATION_EXTRA) and ec:GetOriginalType(TYPE_PENDULUM) and ec:IsPreviousPosition(POS_FACEUP_ATTACK) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1))  then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	end
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and ec:IsLocation(LOCATION_EXTRA) and ec:GetOriginalType(TYPE_PENDULUM) and ec:IsPreviousPosition(POS_FACEUP_DEFENSE) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then 
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
----------------------------
	if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and (not ec:IsLocation(LOCATION_EXTRA)) and ec:GetOriginalType(TYPE_LINK) and ec:IsPreviousPosition(POS_FACEUP_ATTACK) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1))  then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	end
----------------------------
  if ec:IsPreviousLocation(LOCATION_MZONE) and (not Duel.IsPlayerAffectedByEffect(tp,59822133)) and ec:IsLocation(LOCATION_EXTRA) and ec:GetOriginalType(TYPE_LINK) and ec:IsPreviousPosition(POS_FACEUP_ATTACK) and ec:IsCanBeSpecialSummoned(e,0,tp,true,false) and ec:GetPreviousControler()==tp and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and Duel.SelectYesNo(tp,aux.Stringid(34511170,1)) then
		Duel.SpecialSummon(ec,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	end
-----------------------------
		ec=eg:GetNext()
  end
end
function c34511170.mffilter0(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c34511170.mffilter1(c,e)
	return c:IsOnField() and not c:IsImmuneToEffect(e)
end
function c34511170.mffilter2(c,e,tp,m,f,gc,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,gc,chkf)
end
function c34511170.mftg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(Card.IsOnField,nil)
		mg1:Merge(Duel.GetMatchingGroup(c34511170.mffilter0,tp,LOCATION_PZONE,0,nil,e))
		local res=Duel.IsExistingMatchingCard(c34511170.mffilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,c,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c34511170.mffilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,c,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c34511170.mfop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local chkf=tp
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) then return end
	local mg1=Duel.GetFusionMaterial(tp):Filter(c34511170.mffilter1,nil,e)
	mg1:Merge(Duel.GetMatchingGroup(c34511170.mffilter0,tp,LOCATION_PZONE,0,nil,e))
	local sg1=Duel.GetMatchingGroup(c34511170.mffilter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,c,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c34511170.mffilter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,c,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,c,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat5=Duel.SelectFusionMaterial(tp,tc,mg5,c,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat5)
		end
		tc:CompleteProcedure()
	end
end