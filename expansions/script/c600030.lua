--黑幻想之魔导龙
function c600030.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,nil,c600030.lcheck)
	c:EnableReviveLimit()   
	--Race
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_RACE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(RACE_SPELLCASTER)
	c:RegisterEffect(e1)
	--activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600030,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,600030)
	e2:SetCondition(c600030.spcon)
	e2:SetTarget(c600030.sptg)
	e2:SetOperation(c600030.spop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600030,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_RELEASE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e3:SetCountLimit(1,6000030)
	e3:SetCondition(c600030.spcon2)
	e3:SetTarget(c600030.sptg2)
	e3:SetOperation(c600030.spop2)
	c:RegisterEffect(e3)
end
function c600030.lcheck(g,lc)
	return g:IsExists(Card.IsCode,1,nil,46986414)
end
function c600030.spcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c600030.filter2(c,e,tp,m,f,chkf)
	 local tc=m:GetFirst()
local m1=m:Clone()
local pd=false
  while tc do
	tc:AssumeProperty(ASSUME_ATTRIBUTE,0x20)
	  tc=m:GetNext()
end
 local tc2=m1:GetFirst()
while tc2 do
	 m1:RemoveCard(tc2)
	local tm=m1:GetFirst()
		 while tm do
		  local gnew=Group.FromCards(tc2,tm)
		   if c:CheckFusionMaterial(gnew,nil,chkf) then
				pd=true  end
			   tm=m1:GetNext()
		  end
	  tc2=m1:GetFirst()
end
	return c:IsType(TYPE_FUSION) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_DRAGON) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and pd
end
function c600030.spfilter1(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c600030.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(0x10) and c600030.spfilter1(chkc,e,tp) end
	if chk==0 then 
		local chkf=Duel.GetLocationCount(tp,0x4)>1 and PLAYER_NONE or tp
		local tg=Duel.GetMatchingGroup(c600030.spfilter1,tp,0x10,0,nil,e,tp)
		local res=Duel.IsExistingMatchingCard(c600030.filter2,tp,0x40,0,1,nil,e,tp,tg,nil,chkf)
		return Duel.GetLocationCount(tp,0x4)>1 and res 
	end
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c600030.spfilter1,tp,0x10,0,nil,e,tp)
		local  mmg=Duel.GetMatchingGroup(c600030.filter2,tp,0x40,0,nil,e,tp,mg1,nil,chkf)
		local ggg=c600030.checkm(mg1,mmg,chkf)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local mtc1=ggg:Select(tp,1,1,nil):GetFirst()
		mg1:RemoveCard(mtc1)
	local ggg1=c600030.checkm1(mtc1,mg1,mmg,chkf)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local mtc2=ggg1:Select(tp,1,1,nil)  
	mtc2:AddCard(mtc1)
	Duel.SetTargetCard(mtc2) 
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,mtc2,2,0,0)
end
function c600030.checkm1(mtc1,mg1,mmg,chkf)
	 local mgc=mg1:Clone()
	 local tc=mg1:GetFirst()
	 local fhg=Group.CreateGroup()
	  while tc do
	  local pd=false
	  local gnew=Group.FromCards(mtc1,tc)
	  local mmgc=mmg:GetFirst()
	   while mmgc do 
	   if  mmgc:CheckFusionMaterial(gnew,nil,chkf) then
		pd=true end
	   mmgc=mmg:GetNext()
   end   
   if  pd then fhg:AddCard(tc) end
   tc=mg1:GetNext()
end
	return fhg
end
function c600030.checkm(mg1,mmg,chkf)
	local mgc=mg1:Clone()
	local tc=mg1:GetFirst()
	local fhg=Group.CreateGroup()
	 while tc do
	 local pd=false
	 local tcc=mgc:GetFirst()
	   while tcc do
		local gnew=Group.FromCards(tcc,tc)
		local mmgc=mmg:GetFirst()
		  while mmgc do 
		  if mmgc:CheckFusionMaterial(gnew,nil,chkf) then pd=true end
		  mmgc=mmg:GetNext()
	  end   
	  tcc=mgc:GetNext()
   end
   if pd then fhg:AddCard(tc) end
   tc=mg1:GetNext()
end
	return fhg
end
function c600030.spop(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,0x4)>1 and PLAYER_NONE or tp
	local mg1=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e) 
		local sg1=Duel.GetMatchingGroup(c600030.filter2,tp,0x40,0,nil,e,tp,mg1,nil,chkf)
		if sg1:GetCount()>0 then
		local bc=mg1:GetFirst()
		while bc do
		Duel.SpecialSummonStep(bc, 0, tp, tp, false, false, POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(ATTRIBUTE_DARK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		bc:RegisterEffect(e1)
		bc=mg1:GetNext()
	end
		Duel.SpecialSummonComplete()
		local tc=sg1:Select(tp,1,1,nil):GetFirst()
		local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
		tc:SetMaterial(mat1)
		Duel.SendtoGrave(mat1,0x40048)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	 end
end
function c600030.spcfilter(c,tp)
	return c:GetPreviousControler()==tp and c:GetPreviousCodeOnField()==46986414
end
function c600030.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c600030.spcfilter,1,nil,tp)
end
function c600030.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c600030.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end