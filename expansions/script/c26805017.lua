--水晶长廊
function c26805017.initial_effect(c)
	aux.AddCodeList(c,81013000)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c26805017.sumsuc)
	c:RegisterEffect(e1)
	--change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_FZONE+LOCATION_GRAVE)
	e2:SetValue(81013000)
	c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26805017,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,26805017)
	e3:SetCost(c26805017.cost)
	e3:SetCondition(c26805017.spcon)
	e3:SetTarget(c26805017.sptg)
	e3:SetOperation(c26805017.spop)
	c:RegisterEffect(e3)
	--add setcode
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOKEN))
	e4:SetCode(EFFECT_ADD_CODE)
	e4:SetValue(81013999)
	c:RegisterEffect(e4)
	Duel.AddCustomActivityCounter(26805017,ACTIVITY_SPSUMMON,c26805017.counterfilter)
end
function c26805017.counterfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
function c26805017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(26805017,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c26805017.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c26805017.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsAttribute(ATTRIBUTE_WIND)
end
function c26805017.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_LINK)
end
function c26805017.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c26805017.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c26805017.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,81013999,0,0x4011,800,800,3,RACE_ROCK,ATTRIBUTE_WIND,POS_FACEUP) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c26805017.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,81013999,0,0x4011,800,800,3,RACE_ROCK,ATTRIBUTE_WIND,POS_FACEUP) then return end
	local token=Duel.CreateToken(tp,81013999)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
function c26805017.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_MUSIC,0,aux.Stringid(81013000,2))
end 
