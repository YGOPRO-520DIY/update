--浮游星龙 月光咒龙
function c65073004.initial_effect(c)
	c:SetSPSummonOnce(65073004)
	 --xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedureLevelFree(c,c65073004.xyzlvf,c65073004.xyzcheck,3,99)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c65073004.remcon)
	e1:SetCost(c65073004.cost)
	e1:SetTarget(c65073004.remtg)
	e1:SetOperation(c65073004.remop)
	c:RegisterEffect(e1)
	--toextra
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c65073004.con)
	e2:SetTarget(c65073004.tg)
	e2:SetOperation(c65073004.op)
	c:RegisterEffect(e2)
	--setatkdef
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c65073004.atkcon)
	e3:SetValue(1800)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e4)
end
function c65073004.atkcon(e,c)
	return not e:GetHandler():GetOverlayGroup():IsExists(Card.IsLevelAbove,1,nil,5)
end
function c65073004.xyzlvf(c)
	return c:GetLevel()>1
end
function c65073004.xyzcheck(g)
	return g:GetClassCount(Card.GetLevel)==1
end
function c65073004.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and Duel.GetTurnPlayer()~=tp 
end
function c65073004.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local num=e:GetHandler():GetOverlayCount()
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsCanBeSpecialSummoned,tp,LOCATION_GRAVE,0,nil,e,0,tp,false,false)>=num and num>0 and Duel.GetMZoneCount(tp,e:GetHandler(),tp)>=num and e:GetHandler():GetFlagEffect(65073004)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,num,tp,LOCATION_GRAVE)
	e:GetHandler():RegisterFlagEffect(65073004,RESET_CHAIN,0,1)
end
function c65073004.op(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetHandler():GetOverlayCount()
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)~=0 and Duel.GetMatchingGroupCount(Card.IsCanBeSpecialSummoned,tp,LOCATION_GRAVE,0,nil,e,0,tp,false,false)>=num and Duel.GetMZoneCount(tp,e:GetHandler(),tp)>=num then
		local g=Duel.SelectMatchingCard(tp,Card.IsCanBeSpecialSummoned,tp,LOCATION_GRAVE,0,num,num,nil,e,0,tp,false,false)
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			if not tc:IsCode(65073001) then
				local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
				local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK)
		e3:SetValue(0)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_SET_DEFENSE)
		tc:RegisterEffect(e4)
			end
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
function c65073004.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c65073004.tgfilter(c,xyzc,num)
	return c:IsLevelBelow(num) and c:IsCanBeXyzMaterial(c,xyzc)
end
function c65073004.tgfilter0(c,xyzc,num,lv)
	return lv+c:GetLevel()<=num and c:IsCanBeXyzMaterial(c,xyzc)
end
function c65073004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c65073004.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local num=e:GetHandler():GetOverlayCount()
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c65073004.tgfilter,tp,LOCATION_DECK,0,1,nil,e:GetHandler(),num) end
	local g=Duel.GetMatchingGroup(c65073004.tgfilter,tp,LOCATION_DECK,0,nil,e:GetHandler(),num)
	local tc=g:GetFirst()
	local lev=tc:GetLevel()
	while tc do
		if lev>tc:GetLevel() then lev=tc:GetLevel() end
		tc=g:GetNext()
	end
	local nnum=e:GetHandler():RemoveOverlayCard(tp,lev,num,REASON_COST)
	e:SetLabel(nnum)
end
function c65073004.remop(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetLabel()
	local c=e:GetHandler()
	local lv=0
	local g=Duel.GetMatchingGroup(c65073004.tgfilter,tp,LOCATION_DECK,0,nil,e:GetHandler(),num,lv)
	if c:IsRelateToEffect(e) and c:IsType(TYPE_XYZ) and c:IsFaceup() then
		local mg=Group.CreateGroup()
		while lv<num and g:GetCount()>0 do
			local sg=g:FilterSelect(tp,aux.TRUE,1,1,nil)
			lv=lv+sg:GetFirst():GetLevel()
			mg:Merge(sg)
			g=Duel.GetMatchingGroup(c65073004.tgfilter,tp,LOCATION_DECK,0,mg,e:GetHandler(),num,lv)
		end
		Duel.Overlay(c,mg)
	end
end
