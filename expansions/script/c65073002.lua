--浮游星龙 木之星龙
function c65073002.initial_effect(c)
	 c:SetSPSummonOnce(65073002)
	 --synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c65073002.remcon)
	e1:SetTarget(c65073002.remtg)
	e1:SetOperation(c65073002.remop)
	c:RegisterEffect(e1)
	--toextra
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c65073002.con)
	e2:SetTarget(c65073002.tg)
	e2:SetOperation(c65073002.op)
	c:RegisterEffect(e2)
end
function c65073002.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and Duel.GetTurnPlayer()~=tp and e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c65073002.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local num=e:GetHandler():GetMaterialCount()
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsCanBeSpecialSummoned,tp,LOCATION_GRAVE,0,nil,e,0,tp,false,false)>=num and num>0 and Duel.GetMZoneCount(tp,e:GetHandler(),tp)>=num and e:GetHandler():GetFlagEffect(65073002)==0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,num,tp,LOCATION_GRAVE)
	e:GetHandler():RegisterFlagEffect(65073002,RESET_CHAIN,0,1)
end
function c65073002.op(e,tp,eg,ep,ev,re,r,rp)
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
function c65073002.remcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c65073002.tgfilter(c,e,tp,num)
	return Duel.IsExistingMatchingCard(c65073002.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,num,c:GetAttribute(),c:GetRace()) and c:IsFaceup()
end
function c65073002.spfilter(c,e,tp,num,att,rac)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(num) and (c:IsAttribute(att) or c:IsRace(rac))
end
function c65073002.spfilter1(c,e,tp,num,att,lv)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and lv+c:GetLevel()<=num and c:IsAttribute(att)
end
function c65073002.spfilter2(c,e,tp,num,rac,lv)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and lv+c:GetLevel()<=num and c:IsRace(rac)
end
function c65073002.remtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local num=e:GetHandler():GetMaterialCount()
	if chkc then return c65073002.tgfilter(chkc,e,tp,num) and chkc:IsLocation(LOCATION_MZONE) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c65073002.tgfilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),e,tp,num) and Duel.GetMZoneCount(tp)>0 end
	e:SetLabel(num)
	Duel.SelectTarget(tp,c65073002.tgfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),e,tp,num)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c65073002.remop(e,tp,eg,ep,ev,re,r,rp)
	local num=e:GetLabel()
	local ft=Duel.GetMZoneCount(tp)
	local tc=Duel.GetFirstTarget()
	local count=0
	local lv=0
	if ft>0 and tc:IsRelateToEffect(e) and Duel.GetMZoneCount(tp)>0 then
		local op=99
		local b1=Duel.IsExistingMatchingCard(c65073002.spfilter1,tp,LOCATION_DECK,0,1,nil,e,tp,num,tc:GetAttribute(),lv)
		local b2=Duel.IsExistingMatchingCard(c65073002.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp,num,tc:GetRace(),lv)
		if b1 and b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65073002,0),aux.Stringid(65073002,1))
		elseif b1 then
			op=Duel.SelectOption(tp,aux.Stringid(65073002,0))
		elseif b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65073002,1))+1
		end
		local sg=Group.CreateGroup()
		local g1=Duel.GetMatchingGroup(c65073002.spfilter1,tp,LOCATION_DECK,0,nil,e,tp,num,tc:GetAttribute(),lv)
		local g2=Duel.GetMatchingGroup(c65073002.spfilter2,tp,LOCATION_DECK,0,nil,e,tp,num,tc:GetRace(),lv)
		while lv<num and count<ft and ((op==0 and g1:GetCount()>0) or (op==1 and g2:GetCount())>0) do
			if op==0 then
				local g=g1:FilterSelect(tp,aux.TRUE,1,1,nil)
				lv=lv+g:GetFirst():GetLevel()
				sg:Merge(g)
				g1=Duel.GetMatchingGroup(c65073002.spfilter1,tp,LOCATION_DECK,0,sg,e,tp,num,tc:GetAttribute(),lv)
			elseif op==1 then
				if g2:GetCount()==0 then break end
				local g=g2:FilterSelect(tp,aux.TRUE,1,1,nil)
				lv=lv+g:GetFirst():GetLevel()
				sg:Merge(g)
				g2=Duel.GetMatchingGroup(c65073002.spfilter2,tp,LOCATION_DECK,0,sg,e,tp,num,tc:GetRace(),lv)
			else return end
			count=count+1
		end
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end