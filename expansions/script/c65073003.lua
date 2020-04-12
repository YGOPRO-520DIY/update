--浮游星龙 不死鸟焰龙
function c65073003.initial_effect(c)
	c:SetSPSummonOnce(65073003)
	--link summon
	aux.AddLinkProcedure(c,nil,3,99,c65073003.lcheck)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c65073003.remcon)
	e1:SetTarget(c65073003.remtg)
	e1:SetOperation(c65073003.remop)
	c:RegisterEffect(e1)
	--toextra
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c65073003.con)
	e2:SetTarget(c65073003.tg)
	e2:SetOperation(c65073003.op)
	c:RegisterEffect(e2)
end
function c65073003.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and Duel.GetTurnPlayer()~=tp and e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c65073003.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local num=e:GetHandler():GetMaterialCount()
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsCanBeSpecialSummoned,tp,LOCATION_GRAVE,0,nil,e,0,tp,false,false)>=num and num>0 and Duel.GetMZoneCount(tp,e:GetHandler(),tp)>=num and e:GetHandler():GetFlagEffect(65073003)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,num,tp,LOCATION_GRAVE)
	e:GetHandler():RegisterFlagEffect(65073003,RESET_CHAIN,0,1)
end
function c65073003.op(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetHandler():GetMaterialCount()
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
function c65073003.lcheck(g)
	return g:IsExists(Card.IsLinkRace,1,nil,RACE_DRAGON)
end
function c65073003.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c65073003.spfilter(c,e,tp,num)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(num)
end
function c65073003.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local num=e:GetHandler():GetMaterialCount()
	e:SetLabel(num)
	if Duel.GetMatchingGroupCount(c65073003.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp,num)<=num/2 or Duel.GetMZoneCount(tp)<=num then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,LOCATION_ONFIELD)
	end
end
function c65073003.spfilter0(c,e,tp,num,lv)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and lv+c:GetLevel()<=num and c:GetLevel()>0
end
function c65073003.remop(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetLabel()
	local count=0
	local lv=0
	while count<num do
		local b1=Duel.GetMatchingGroupCount(c65073003.spfilter0,tp,LOCATION_GRAVE,0,nil,e,tp,num,lv)>0 and Duel.GetMZoneCount(tp)>0
		local b2=Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		local op=99
		if b1 and b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65073003,0),aux.Stringid(65073003,1))
		elseif b1 then
			op=Duel.SelectOption(tp,aux.Stringid(65073003,0))
		elseif b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65073003,1))+1
		else return end
		if op==0 then
			local g=Duel.SelectMatchingCard(tp,c65073003.spfilter0,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,num,lv)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			lv=lv+g:GetFirst():GetLevel()
		elseif op==1 then
			local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
		count=count+1
	end
end