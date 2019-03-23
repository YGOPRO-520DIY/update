--升阶魔法-光波追击
function c600025.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600025,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c600025.condition)
	e1:SetTarget(c600025.target)
	e1:SetOperation(c600025.operation)
	c:RegisterEffect(e1)
	 local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(600025,1))
	e2:SetTarget(c600025.target2)
	e2:SetOperation(c600025.operation2)
	c:RegisterEffect(e2)
end
function c600025.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)>Duel.GetLP(1-tp) then
		return Duel.GetLP(tp)-Duel.GetLP(1-tp)>=2000
	else
		return Duel.GetLP(1-tp)-Duel.GetLP(tp)>=2000
	end
end
function c600025.filter1(c,e,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsSetCard(0xe5) and c:IsType(TYPE_XYZ) and c:GetOverlayCount()==2
	and Duel.IsExistingMatchingCard(c600025.filter2,tp,LOCATION_EXTRA,0,1,nil,rk,e,tp,c)
end
function c600025.filter2(c,rk,e,tp,tc)
	return c:GetRank()==(rk+1) and c:IsSetCard(0xe5)
	  and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) 
end
function c600025.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c600025.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingTarget(c600025.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c600025.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c600025.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end	
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:GetOverlayCount()~=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600025.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank(),e,tp,tc)
	local sc=g:GetFirst()
	if sc then
	Duel.SpecialSummonStep(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		--Duel.SpecialSummonComplete()
		--Duel.BreakEffect()
			local g1=tc:GetOverlayGroup()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600025,0))
			local mg2=g1:Select(tp,1,1,nil)
			local oc=mg2:GetFirst()
			  sc:SetMaterial(mg2)
			Duel.Overlay(sc,mg2)
			Duel.RaiseSingleEvent(tc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
				  Duel.SpecialSummonComplete()
				  sc:CompleteProcedure()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c600025.filter2,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetRank(),e,tp,tc)
	local sc2=g2:GetFirst()
	if sc2 then
				Duel.SpecialSummonStep(sc2,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			  --Duel.SpecialSummonComplete()
			--Duel.BreakEffect()
			local g1=tc:GetOverlayGroup()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600025,0))
			local mg2=g1:Select(tp,1,1,nil)
			local oc=mg2:GetFirst()
			  sc2:SetMaterial(mg2)
			Duel.Overlay(sc2,mg2)
			Duel.RaiseSingleEvent(tc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
				  Duel.SpecialSummonComplete()
				  sc:CompleteProcedure()
	 end
end
function c600025.chkfilter(c,tp,code)
	return c:IsCode(code) and c:GetOwner()==tp
end 
function c600025.overfilter(c,tp,code)
	return (c:GetOverlayGroup():FilterCount(c600025.chkfilter,nil,tp,code)>0) or (c:IsCode(code) and c:GetOwner()==tp)
end 

function c600025.filter12(c,e,tp)
	local rk=c:GetRank()
	  local b0=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,12632096) then b0=1 end
	  local b1=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,2530830) then b1=1 end
	  local b2=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,18963306) then b2=1 end
	  local b3=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,326) or Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,56832966) then b3=1 end
	  local b4=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,21521304) then b4=1 end
	return c:IsFaceup() and c:IsSetCard(0xe5) and rk>2 and rk<5 and c:IsCanBeXyzMaterial(nil) 
	  and ((rk==4 and b1+b2+b3+b4<4) or (rk==3 and b1+b2+b3+b0<4)) and c:GetOverlayCount()==2
end
function c600025.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c600025.filter12(chkc,e,tp) end
	if chk==0 then return Duel.GetFlagEffect(tp,91999980)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c600025.filter12,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c600025.filter12,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c600025.operation2(e,tp,eg,ep,ev,re,r,rp)
	  local b0=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,12632096) then b0=1 end
	  local b1=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,2530830) then b1=1 end
	  local b2=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,18963306) then b2=1 end
	  local b3=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,326) or Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,56832966) then b3=1 end
	  local b4=0 if Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,21521304) then b4=1 end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	  if tc==nil then return end
	local rk=tc:GetRank()
	if tc:IsFacedown() or not tc:IsCode(84013237) or (tc:GetRank()~=3 and tc:GetRank()~=4) or not tc:IsRelateToEffect(e) or tc:GetOverlayCount()~=2 then return end 
	  if rk==3 and b0+b1+b2+b3>3 then return end
	  if rk==4 and b4+b1+b2+b3>3 then return end	
	  local sc   
	  local off=1
	local ops={}
	  local opval={}
	  if b0==0 and rk==3 then
			ops[off]=aux.Stringid(600025,6)
			opval[off-1]=1
			off=off+1
	  end
	  if b1==0 and (rk==3 or rk==4) then
			ops[off]=aux.Stringid(600025,7)
			opval[off-1]=2
			off=off+1
	  end
	  if b2==0 and (rk==3 or rk==4) then
			ops[off]=aux.Stringid(600025,8)
			opval[off-1]=3
			off=off+1
	  end
	  if b3==0 and (rk==3 or rk==4) then
			ops[off]=aux.Stringid(600025,11)
			opval[off-1]=4
			off=off+1
	  end
	  if b4==0 and rk==4 then
			ops[off]=aux.Stringid(600025,12)
			opval[off-1]=5
			off=off+1
	  end
	  local op=Duel.SelectOption(tp,table.unpack(ops))  
	  if opval[op]==1 then   
	  sc=Duel.CreateToken(tp,61,nil,nil,nil,nil,nil,nil) end 
	  if opval[op]==2 then   
	  sc=Duel.CreateToken(tp,62,nil,nil,nil,nil,nil,nil) end
	  if opval[op]==3 then   
	  sc=Duel.CreateToken(tp,63,nil,nil,nil,nil,nil,nil) end
	  if opval[op]==4 then   
	  sc=Duel.CreateToken(tp,326,nil,nil,nil,nil,nil,nil) end
	  if opval[op]==5 then   
	  sc=Duel.CreateToken(tp,13719,nil,nil,nil,nil,nil,nil) end
	  if sc==nil then return end
	  Duel.Remove(sc,POS_FACEUP,REASON_RULE)
	if sc then
				Duel.SpecialSummonStep(sc,SUMMON_TYPE_XYZ,tp,tp,true,true,POS_FACEUP)
			local g1=tc:GetOverlayGroup()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600025,0))
			local mg2=g1:Select(tp,1,1,nil)
			local oc=mg2:GetFirst()
			  sc:SetMaterial(mg2)
			Duel.Overlay(sc,mg2)
			Duel.RaiseSingleEvent(tc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
				  Duel.SpecialSummonComplete()
				  sc:CompleteProcedure()
				  sc:RegisterFlagEffect(157,0,0,1)
	end
	local sc2   
	  local off2=1
	local ops2={}
	  local opval2={}
	  if rk==3 and not Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,12632096) then
			ops2[off2]=aux.Stringid(600025,7)
			opval2[off2-1]=1
			off2=off2+1
	  end
	  if (rk==3 or rk==4) and not Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,2530830) then
			ops2[off2]=aux.Stringid(600025,7)
			opval2[off2-1]=2
			off2=off2+1
	  end
	  if (rk==3 or rk==4) and not Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,18963306) then
			ops2[off2]=aux.Stringid(600025,8)
			opval2[off2-1]=3
			off2=off2+1
	  end
	  if (rk==3 or rk==4) and not Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,326) and not Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,56832966) then
			ops2[off2]=aux.Stringid(600025,11)
			opval2[off2-1]=4
			off2=off2+1
	  end
	  if rk==4 and not Duel.IsExistingMatchingCard(c600025.overfilter,tp,LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED,LOCATION_ONFIELD,1,nil,tp,21521304) then
			ops2[off2]=aux.Stringid(600025,12)
			opval2[off2-1]=5
			off2=off2+1
	  end
	  local op2=Duel.SelectOption(tp,table.unpack(ops2))  
	  if opval2[op2]==1 then	 
	  sc2=Duel.CreateToken(tp,61,nil,nil,nil,nil,nil,nil) end
	  if opval2[op2]==2 then	 
	  sc2=Duel.CreateToken(tp,62,nil,nil,nil,nil,nil,nil) end
	  if opval2[op2]==3 then	 
	  sc2=Duel.CreateToken(tp,63,nil,nil,nil,nil,nil,nil) end
	  if opval2[op2]==4 then	 
	  sc2=Duel.CreateToken(tp,326,nil,nil,nil,nil,nil,nil) end
	  if opval2[op2]==5 then	 
	  sc2=Duel.CreateToken(tp,13719,nil,nil,nil,nil,nil,nil) end	
	  if sc2==nil then return end
	  Duel.Remove(sc2,POS_FACEUP,REASON_RULE)
	if sc2 then
	Duel.SpecialSummonStep(sc2,SUMMON_TYPE_XYZ,tp,tp,true,true,POS_FACEUP)
			local g1=tc:GetOverlayGroup()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(600025,0))
			local mg2=g1:Select(tp,1,1,nil)
			local oc=mg2:GetFirst()
			  sc2:SetMaterial(mg2)
			Duel.Overlay(sc2,mg2)
			Duel.RaiseSingleEvent(tc,EVENT_DETACH_MATERIAL,e,0,0,0,0)
				  Duel.SpecialSummonComplete()
				  sc2:CompleteProcedure()
				  sc2:RegisterFlagEffect(157,0,0,1)
	  end
end
