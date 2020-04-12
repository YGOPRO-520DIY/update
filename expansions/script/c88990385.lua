--荣冠之圣刻印
function c88990385.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88990385,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,88990385)
	e1:SetTarget(c88990385.target)
	e1:SetOperation(c88990385.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c88990385.thcon)
	e2:SetTarget(c88990385.thtg)
	e2:SetOperation(c88990385.thop)
	c:RegisterEffect(e2)
end
function c88990385.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c88990385.thfilter,1,nil)
end
function c88990385.thfilter(c)
	return c:IsSetCard(0x69)
end
function c88990385.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c88990385.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,tp,REASON_EFFECT)
	end
end
function c88990385.filter1(c,e,tp)
	local b=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=3
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
		and ((c:IsType(TYPE_XYZ) and Duel.IsExistingMatchingCard(c88990385.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetRank())) 
		or (b and c:IsSetCard(0x69) and c:IsLevelAbove(4) and Duel.IsExistingMatchingCard(c88990385.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetLevel())))
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c88990385.filter2(c,e,tp,mc,rk)
	return (c:IsRank(rk+1) or c:IsRank(rk+2)) and c:IsSetCard(0x69) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c88990385.lfilter1(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
		and (c:IsType(TYPE_LINK) and Duel.IsExistingMatchingCard(c88990385.lfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetLink())) 
		and c:IsReleasableByEffect()
end
function c88990385.lfilter2(c,e,tp,mc,lk)
	return c:IsLink(lk+1) and c:IsSetCard(0x69) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_LINK,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c88990385.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local b1=Duel.IsExistingTarget(c88990385.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
	local b2=Duel.IsExistingTarget(c88990385.lfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and (c88990385.filter1(chkc,e,tp) or c88990385.lfilter1(chkc,e,tp)) end
	if chk==0 then return b1 or b2 end
	local op=99
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(88990385,0),aux.Stringid(88990385,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(88990385,0))
	elseif b2 then
		op=Duel.SelectOption(tp,aux.Stringid(88990385,1))+1
	end
	if op==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c88990385.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	elseif op==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c88990385.lfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	e:SetLabel(op)
end
function c88990385.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local op=e:GetLabel()
	if op==0 then
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c88990385.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank())
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
	elseif op==1 then
		if tc:IsRelateToEffect(e) and Duel.Release(tc,REASON_EFFECT)~=0 and Duel.IsExistingMatchingCard(c88990385.lfilter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,tc,tc:GetLink()) then
			local sg=Duel.SelectMatchingCard(tp,c88990385.lfilter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetLink())
			local sgc=sg:GetFirst()
			Duel.SpecialSummon(sgc,SUMMON_TYPE_LINK,tp,tp,false,false,POS_FACEUP)
			sgc:CompleteProcedure()
			--indes
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	e2:SetValue(aux.tgoval)
	sgc:RegisterEffect(e2)
		end
	end
end