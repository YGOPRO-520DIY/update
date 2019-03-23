--圣诞老人 礼物王
function c600063.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,3,3,c600063.lcheck)
	c:EnableReviveLimit()  
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c600063.incon)
	e1:SetTarget(c600063.indtg)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c600063.incon)
	e2:SetTarget(c600063.indtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2) 
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c600063.atkval)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(600063,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,600063)
	e4:SetTarget(c600063.sptg)
	e4:SetOperation(c600063.spop)
	c:RegisterEffect(e4)
end
function c600063.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x600)
end
function c600063.infilter(c)
	return c:IsFacedown() and c:IsType(TYPE_MONSTER)
end
function c600063.incon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c600063.infilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c600063.indtg(e,c)
	return c:IsFaceup()
end
function c600063.atkval(e,c)
	return c:GetLinkedGroupCount()*1000
end
function c600063.spfilter(c,e,tp,zone)
	return c:IsSetCard(0x600) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,tp,zone)
end
function c600063.spcheck(sg,e,tp,mg)
	return sg:GetClassCount(Card.GetLocation)==#sg
end
function c600063.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local zone=e:GetHandler():GetLinkedZone(tp)&0x1f
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
		return ct>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.IsExistingMatchingCard(c600063.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,zone)
			and Duel.IsExistingMatchingCard(c600063.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone)
			and Duel.IsExistingMatchingCard(c600063.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,zone)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c600063.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local zone=c:GetLinkedZone(tp)&0x1f
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
	if ct<3 then return end
	local g1=Duel.GetMatchingGroup(c600063.spfilter,tp,LOCATION_HAND,0,nil,e,tp,zone)
	local g2=Duel.GetMatchingGroup(c600063.spfilter,tp,LOCATION_DECK,0,nil,e,tp,zone)
	local g3=Duel.GetMatchingGroup(aux.NecroValleyFilter(c600063.spfilter),tp,LOCATION_GRAVE,0,nil,e,tp,zone)
	if #g1==0 or #g2==0 or #g3==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg2=g2:Select(tp,1,1,nil)
	sg1:Merge(sg2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg3=g3:Select(tp,1,1,nil)
	sg1:Merge(sg3)
	Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE,zone)
	   local sg=Duel.GetMatchingGroup(c600063.ssfilter,tp,LOCATION_MZONE,0,nil)
	   if ct~=0 and sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(600063,1)) then
		  Duel.BreakEffect()
		  Duel.ShuffleSetCard(sg)
	   end
end
function c600063.ssfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end