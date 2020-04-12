--浮游星龙 邪法老光谱龙
function c65073005.initial_effect(c)
	c:SetSPSummonOnce(65073005)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFunRep(c,65073001,Card.IsOnField,1,63,true,true)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c65073005.remcon)
	e1:SetTarget(c65073005.remtg)
	e1:SetOperation(c65073005.remop)
	c:RegisterEffect(e1)
	--toextra
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c65073005.con)
	e2:SetTarget(c65073005.tg)
	e2:SetOperation(c65073005.op)
	c:RegisterEffect(e2)
end
function c65073005.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and Duel.GetTurnPlayer()~=tp and e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c65073005.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local num=e:GetHandler():GetMaterialCount()
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsCanBeSpecialSummoned,tp,LOCATION_GRAVE,0,nil,e,0,tp,false,false)>=num and num>0 and Duel.GetMZoneCount(tp,e:GetHandler(),tp)>=num and e:GetHandler():GetFlagEffect(65073005)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,num,tp,LOCATION_GRAVE)
	e:GetHandler():RegisterFlagEffect(65073005,RESET_CHAIN,0,1)
end
function c65073005.op(e,tp,eg,ep,ev,re,r,rp)
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
function c65073005.lcheck(g)
	return g:IsExists(Card.IsLinkRace,1,nil,RACE_DRAGON)
end
function c65073005.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c65073005.spfilter(c,e,tp,num)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(num)
end
function c65073005.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local num=e:GetHandler():GetMaterialCount()
	e:SetLabel(num)
	if Duel.GetMatchingGroupCount(c65073005.spfilter,tp,LOCATION_HAND,0,nil,e,tp,num)<=num/2 or Duel.GetMZoneCount(tp)<=num then
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,0,LOCATION_ONFIELD)
	end
end
function c65073005.spfilter0(c,e,tp,att)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and bit.band(c:GetAttribute(),att)==0
end
function c65073005.conchanfil(c,att)
	return c:IsControlerCanBeChanged() and bit.band(c:GetAttribute(),att)==0
end
function c65073005.remop(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetLabel()
	local count=0
	local lv=0
	local att=0
	while count<num do
		local b1=Duel.GetMatchingGroupCount(c65073005.spfilter0,tp,LOCATION_HAND,0,nil,e,tp,att)>0 and Duel.GetMZoneCount(tp)>0
		local b2=Duel.IsExistingMatchingCard(c65073005.conchanfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,att)
		local op=99
		if b1 and b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65073005,0),aux.Stringid(65073005,1))
		elseif b1 then
			op=Duel.SelectOption(tp,aux.Stringid(65073005,0))
		elseif b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65073005,1))+1
		else return end
		if op==0 then
			local g=Duel.SelectMatchingCard(tp,c65073005.spfilter0,tp,LOCATION_HAND,0,1,1,nil,e,tp,att)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			att=att+g:GetFirst():GetAttribute()
		elseif op==1 then
			local g=Duel.SelectMatchingCard(tp,c65073005.conchanfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,att)
			Duel.HintSelection(g)
			Duel.GetControl(g,1-g:GetFirst():GetControler())
			att=att+g:GetFirst():GetAttribute()
		end
		count=count+1
	end
end
