--缚灵溯 时旅
function c65020040.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c65020040.sprcon)
	e0:SetOperation(c65020040.sprop)
	c:RegisterEffect(e0)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c65020040.etg)
	e1:SetValue(c65020040.efilter)
	c:RegisterEffect(e1) 
	--back
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c65020040.thcost)
	e2:SetTarget(c65020040.thtg)
	e2:SetOperation(c65020040.thop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCountLimit(1,65020040)
	e3:SetTarget(c65020040.sptg)
	e3:SetOperation(c65020040.spop)
	c:RegisterEffect(e3)
end
function c65020040.sprfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c65020040.sprfilter1(c,tp,g,sc)
	local lv=c:GetLevel()
	return c:IsType(TYPE_TUNER) and c:IsRace(RACE_ZOMBIE) and g:IsExists(c65020040.sprfilter2,1,c,tp,c,sc,lv)
end
function c65020040.sprfilter2(c,tp,mc,sc,lv)
	local sg=Group.FromCards(c,mc)
	return c:GetLevel()==lv-4 and c:GetOriginalLevel()>0 and not c:IsType(TYPE_TUNER)
		and Duel.GetLocationCountFromEx(tp,tp,sg,sc)>0
end
function c65020040.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c65020040.sprfilter,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c65020040.sprfilter1,1,nil,tp,g,c)
end
function c65020040.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c65020040.sprfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=g:FilterSelect(tp,c65020040.sprfilter1,1,1,nil,tp,g,c)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=g:FilterSelect(tp,c65020040.sprfilter2,1,1,mc,tp,mc,c,mc:GetLevel())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c65020040.cfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c65020040.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020040.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c65020040.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c65020040.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c65020040.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

function c65020040.etg(e,c)
	return c:IsSetCard(0x3da4)
end
function c65020040.efilter(e,re,rp)
	return (re:GetActivateLocation()==LOCATION_GRAVE or re:GetActivateLocation()==LOCATION_HAND) and rp~=e:GetHandlerPlayer()
end
function c65020040.spfilter(c,e,tp)
	return c:IsCode(65020027) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65020040.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65020040.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end

function c65020040.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65020040.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end