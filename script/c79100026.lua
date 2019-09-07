--灵噬·希娜
function c79100026.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c79100026.ffilter,2,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c79100026.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c79100026.spcon)
	e2:SetOperation(c79100026.spop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e3:SetTargetRange(0xff,0xff)
	e3:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(79100026,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCountLimit(1,79100026)
	e4:SetCondition(c79100026.sp)
	e4:SetCost(c79100026.spcost)
	e4:SetTarget(c79100026.sptg)
	e4:SetOperation(c79100026.spop1)
	c:RegisterEffect(e4)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(79100026,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetCountLimit(1,79100027)
	e3:SetTarget(c79100026.drtg)
	e3:SetOperation(c79100026.drop)
	c:RegisterEffect(e3)
end
function c79100026.ffilter(c)
	return c:IsSetCard(0x791)
end
function c79100026.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c79100026.spfilter(c,fc)
	return c79100026.ffilter(c) and c:IsCanBeFusionMaterial(fc)
end
function c79100026.spfilter1(c,tp,g)
	return g:IsExists(c79100026.spfilter2,1,c,tp,c)
end
function c79100026.spfilter2(c,tp,mc)
	return Duel.GetLocationCountFromEx(tp,tp,Group.FromCards(c,mc))>0
end
function c79100026.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetReleaseGroup(tp):Filter(c79100026.spfilter,nil,c)
	return g:IsExists(c79100026.spfilter1,1,nil,tp,g)
end
function c79100026.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetReleaseGroup(tp):Filter(c79100026.spfilter,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=g:FilterSelect(tp,c79100026.spfilter1,1,1,nil,tp,g)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g2=g:FilterSelect(tp,c79100026.spfilter2,1,1,mc,tp,mc)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Release(g1,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
function c79100026.sp(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetPreviousControler()==tp
end
function c79100026.spcfilter9(c)
	return c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c79100026.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79100026.spcfilter9,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c79100026.spcfilter9,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c79100026.spfilter8(c,e,tp)
	return c:IsSetCard(0x791) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c79100026.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c79100026.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c79100026.spfilter8,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c79100026.spfilter8,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c79100026.spop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c79100026.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c79100026.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end