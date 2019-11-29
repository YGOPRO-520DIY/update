local m=15000005
local cm=_G["c"..m]
cm.name="人间异物漆黑·奈克洛兹玛"
function cm.initial_effect(c)
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000005,0))  
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_DELAY) 
	e1:SetRange(LOCATION_MZONE)  
	e1:SetCountLimit(1,15000005)  
	e1:SetTarget(c15000005.target)  
	e1:SetOperation(c15000005.operation)  
	c:RegisterEffect(e1)
	--special summon  
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(15000005,1))  
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)  
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)  
	e2:SetRange(LOCATION_GRAVE)  
	e2:SetCode(EVENT_DESTROYED)  
	e2:SetCondition(c15000005.spcon)  
	e2:SetCountLimit(1,15010005) 
	e2:SetTarget(c15000005.sptg)  
	e2:SetOperation(c15000005.spop)  
	c:RegisterEffect(e2)
end
function c15000005.filter0(c)  
	return c:IsFaceup() and c:IsCanBeFusionMaterial()  
end  
function c15000005.filter1(c,e)  
	return c:IsFaceup() and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)  
end  
function c15000005.filter2(c,e,tp,m,f,chkf)  
	return c:IsType(TYPE_FUSION) and (not f or f(c)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf) and c:IsSetCard(0xf30)
end  
function c15000005.filter3(c,e)  
	return c:IsOnField() and not c:IsImmuneToEffect(e)  
end  
function c15000005.target(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then  
		local chkf=tp  
		local mg1=Duel.GetFusionMaterial(tp):Filter(Card.IsOnField,nil)  
		local mg2=Duel.GetMatchingGroup(c15000005.filter0,tp,0,LOCATION_MZONE,nil)  
		mg1:Merge(mg2)  
		local res=Duel.IsExistingMatchingCard(c15000005.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)  
		if not res then  
			local ce=Duel.GetChainMaterial(tp)  
			if ce~=nil then  
				local fgroup=ce:GetTarget()  
				local mg3=fgroup(ce,e,tp)  
				local mf=ce:GetValue()  
				res=Duel.IsExistingMatchingCard(c15000005.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,chkf)  
			end  
		end  
		return res  
	end  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)   
end  
function c15000005.operation(e,tp,eg,ep,ev,re,r,rp)  
	local chkf=tp  
	local mg1=Duel.GetFusionMaterial(tp):Filter(c15000005.filter3,nil,e)  
	local mg2=Duel.GetMatchingGroup(c15000005.filter1,tp,0,LOCATION_MZONE,nil,e)  
	mg1:Merge(mg2)  
	local sg1=Duel.GetMatchingGroup(c15000005.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)  
	local mg3=nil  
	local sg2=nil  
	local ce=Duel.GetChainMaterial(tp)  
	if ce~=nil then  
		local fgroup=ce:GetTarget()  
		mg3=fgroup(ce,e,tp)  
		local mf=ce:GetValue()  
		sg2=Duel.GetMatchingGroup(c15000005.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,chkf)  
		local tc=sg2:GetFirst()
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
			local spos=0  
			if tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) then spos=spos+POS_FACEUP_ATTACK end  
			if tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE) then spos=spos+POS_FACEDOWN_DEFENSE end  
			if spos~=0 and Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,spos)~=0 then  
				if tc:IsFacedown() then  
					Duel.ConfirmCards(1-tp,tc)  
				end  
			end
			tc:CompleteProcedure()
		end
	end
end

function c15000005.cfilter(c,tp)  
	return c:IsSetCard(0xf30) and c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE) and c:IsType(TYPE_FUSION) 
end  
function c15000005.spcon(e,tp,eg,ep,ev,re,r,rp)  
	return eg:IsExists(c15000005.cfilter,1,e:GetHandler(),tp) and not eg:IsContains(e:GetHandler())  
end  
function c15000005.sptg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0  
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)  
end  
function c15000005.spop(e,tp,eg,ep,ev,re,r,rp)  
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
	local c=e:GetHandler()  
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)~=0 then  
		local e3=Effect.CreateEffect(c)  
		e3:SetType(EFFECT_TYPE_SINGLE)  
		e3:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)  
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)  
		e3:SetReset(RESET_EVENT+RESETS_REDIRECT)  
		e3:SetValue(LOCATION_REMOVED)  
		c:RegisterEffect(e3,true)  
	end  
end 