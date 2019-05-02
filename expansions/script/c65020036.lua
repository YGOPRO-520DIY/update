--缚灵梦 星鹿
function c65020036.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c65020036.sprcon)
	e0:SetOperation(c65020036.sprop)
	c:RegisterEffect(e0)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c65020036.etg)
	e1:SetValue(c65020036.efilter)
	c:RegisterEffect(e1)  
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65020037)
	e2:SetCondition(c65020036.thcon)
	e2:SetTarget(c65020036.thtg)
	e2:SetOperation(c65020036.thop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCountLimit(1,65020036)
	e3:SetTarget(c65020036.sptg)
	e3:SetOperation(c65020036.spop)
	c:RegisterEffect(e3)
end
function c65020036.sprfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c65020036.sprfilter1(c,tp,g,sc)
	local lv=c:GetLevel()
	return c:IsType(TYPE_TUNER) and c:IsRace(RACE_ZOMBIE) and g:IsExists(c65020036.sprfilter2,1,c,tp,c,sc,lv)
end
function c65020036.sprfilter2(c,tp,mc,sc,lv)
	local sg=Group.FromCards(c,mc)
	return c:GetLevel()==lv-5 and c:GetOriginalLevel()>0 and not c:IsType(TYPE_TUNER)
		and Duel.GetLocationCountFromEx(tp,tp,sg,sc)>0
end
function c65020036.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c65020036.sprfilter,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c65020036.sprfilter1,1,nil,tp,g,c)
end
function c65020036.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c65020036.sprfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=g:FilterSelect(tp,c65020036.sprfilter1,1,1,nil,tp,g,c)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=g:FilterSelect(tp,c65020036.sprfilter2,1,1,mc,tp,mc,c,mc:GetLevel())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c65020036.etg(e,c)
	return c:IsSetCard(0x3da4)
end
function c65020036.efilter(e,re,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=e:GetHandlerPlayer()
end

function c65020036.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c65020036.filter(c)
	return c:IsSetCard(0x3da4) and c:IsAbleToHand()
end
function c65020036.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020036.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65020036.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65020036.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c65020036.spfilter(c,e,tp)
	return c:IsCode(65020027) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c65020036.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65020036.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function c65020036.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65020036.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end