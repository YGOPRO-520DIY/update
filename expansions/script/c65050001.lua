--唤灵质源 奥尔库
function c65050001.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c65050001.spcon)
	e1:SetTarget(c65050001.sptg)
	e1:SetOperation(c65050001.spop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_RELEASE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTarget(c65050001.thtg)
	e2:SetOperation(c65050001.thop)
	c:RegisterEffect(e2)
end
function c65050001.thfilter(c,mg)
	if not c:IsSetCard(0x3da1) or bit.band(c:GetType(),0x81)~=0x81
		or not c:IsAbleToHand() then return false end
	return mg:CheckWithSumGreater(Card.GetLevel,c:GetLevel(),c)
end
function c65050001.gmfil(c)
	return c:IsCode(65050012) and c:IsLevelAbove(1) and c:IsReleasable()
end
function c65050001.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(c65050001.gmfil,tp,LOCATION_MZONE,0,1,nil)
	if chk==0 then
		return Duel.IsExistingMatchingCard(c65050001.thfilter,tp,LOCATION_DECK,0,1,nil,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65050001.thop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(c65050001.gmfil,tp,LOCATION_MZONE,0,1,nil)
	local tg=Duel.SelectMatchingCard(tp,c65050001.thfilter,tp,LOCATION_DECK,0,1,1,nil,mg)
	local tc=tg:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g=mg:SelectWithSumGreater(tp,Card.GetLevel,tc:GetLevel(),tc)
		if Duel.Release(g,REASON_EFFECT)~=0 then
			Duel.SendtoHand(tc,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end


function c65050001.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65050001.spcofil,1,nil) and eg:GetCount()==1 
end
function c65050001.spcofil(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c65050001.filter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,65050012,0,0x4011,0,0,c:GetLevel(),RACE_SPELLCASTER,ATTRIBUTE_LIGHT)
end
function c65050001.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:GetFirst()
	if chkc then return Duel.IsPlayerCanSpecialSummonMonster(tp,65050012,0,0x4011,0,0,tc:GetLevel(),RACE_SPELLCASTER,ATTRIBUTE_LIGHT) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c65050001.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,65050012,0,0x4011,0,0,tc:GetLevel(),RACE_SPELLCASTER,ATTRIBUTE_LIGHT) then return end
	local token=Duel.CreateToken(tp,65050012)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(tc:GetLevel())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1)
	Duel.SpecialSummonComplete()
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c65050001.sumlimit)
	Duel.RegisterEffect(e2,tp)
end
function c65050001.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end