--华丽剑士·砂冢明音
function c81019015.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,81011027,c81019015.ffilter,1,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_MZONE,0,aux.tdcfop(c))
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c81019015.splimit)
	c:RegisterEffect(e0)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81019015)
	e1:SetCondition(c81019015.con)
	e1:SetTarget(c81019015.tg)
	e1:SetOperation(c81019015.op)
	c:RegisterEffect(e1)
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetValue(81019009)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c81019015.thcon)
	e3:SetTarget(c81019015.thtg)
	e3:SetOperation(c81019015.thop)
	c:RegisterEffect(e3)
end
function c81019015.ffilter(c)
	return c:IsFusionType(TYPE_MONSTER) and (bit.band(c:GetOriginalType(),TYPE_SPELL)~=0 or bit.band(c:GetOriginalType(),TYPE_TRAP)~=0)
end
function c81019015.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
function c81019015.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c81019015.tfilter(c,e,tp)
	return c:IsType(TYPE_SPELL) and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),0,0x21,1550,1050,4,RACE_FAIRY,ATTRIBUTE_DARK)
end
function c81019015.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(c81019015.tfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,LOCATION_HAND)
end
function c81019015.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c81019015.tfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if sg:GetCount()<1 then return end
	local sc=sg:GetFirst()
	sc:AddMonsterAttribute(TYPE_NORMAL,ATTRIBUTE_DARK,RACE_FAIRY,4,1550,1050)
	Duel.SpecialSummonStep(sc,0,tp,tp,true,false,POS_FACEUP)
	Duel.SpecialSummonComplete()
end
function c81019015.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetPreviousLocation(),LOCATION_ONFIELD)~=0
end
function c81019015.thfilter(c)
	return bit.band(c:GetOriginalType(),TYPE_SPELL)~=0 and c:IsAbleToHand() and c:IsFaceup()
end
function c81019015.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c81019015.thfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c81019015.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c81019015.thfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
