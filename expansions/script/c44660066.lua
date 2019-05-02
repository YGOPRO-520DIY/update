--白芯♪晶渊神鸟
function c44660066.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c44660066.ffilter1,c44660066.ffilter2,true)
	--spsummon condition
	--local e0=Effect.CreateEffect(c)
	--e0:SetType(EFFECT_TYPE_SINGLE)
	--e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	--e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	--e0:SetValue(c44660066.splimit)
	--c:RegisterEffect(e0)
	--sset
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44660066,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,44660066)
	e1:SetTarget(c44660066.target)
	e1:SetOperation(c44660066.operation)
	c:RegisterEffect(e1)
	--sset2
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44660066,2))
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e11:SetCountLimit(1,44661066)
	e11:SetTarget(c44660066.target2)
	e11:SetOperation(c44660066.operation2)
	c:RegisterEffect(e11)
	--special summon rule
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_SPSUMMON_PROC)
	e21:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e21:SetRange(LOCATION_EXTRA)
	e21:SetCondition(c44660066.spcon)
	e21:SetOperation(c44660066.spop)
	e21:SetValue(1)
	c:RegisterEffect(e21)
end
--spsummon condition
function c44660066.ffilter(c,fc,sub,mg,sg)
	return c:IsControler(fc:GetControler())
	and c:IsFusionType(TYPE_NORMAL)
	and c:IsFusionAttribute(ATTRIBUTE_WATER)
	and not c:IsFusionType(TYPE_TOKEN)
end
function c44660066.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
		or st&SUMMON_TYPE_FUSION==SUMMON_TYPE_FUSION
end
--sset
function c44660066.filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsSSetable() 
	and not c:IsType(TYPE_MONSTER)
end
function c44660066.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44660066.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c44660066.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c44660066.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
	end
end
--sset2
function c44660066.filter2(c)
	return c:IsSetCard(0x46) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c44660066.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44660066.filter2,tp,LOCATION_DECK,0,1,nil) end
end
function c44660066.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c44660066.filter2,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
	end
end
--special summon rule
function c44660066.ffilter1(c)
	return c:IsFusionType(TYPE_NORMAL)
	and c:IsFusionAttribute(ATTRIBUTE_WATER)
	and not c:IsFusionType(TYPE_TOKEN)
end
function c44660066.ffilter2(c)
	return c:IsFusionType(TYPE_NORMAL)
	and c:IsFusionAttribute(ATTRIBUTE_WATER)
	and not c:IsFusionType(TYPE_TOKEN)
end
function c44660066.rfilter(c,fc)
	return (c44660066.ffilter1(c) or c44660066.ffilter2(c))
		and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c44660066.spfilter1(c,tp,g)
	return g:IsExists(c44660066.spfilter2,1,c,tp,c)
end
function c44660066.spfilter2(c,tp,mc)
	return (c44660066.ffilter1(c) and c44660066.ffilter2(mc)
		or c44660066.ffilter1(mc) and c44660066.ffilter2(c))
		and Duel.GetLocationCountFromEx(tp,tp,Group.FromCards(c,mc))>0
end
function c44660066.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(c44660066.rfilter,tp,LOCATION_MZONE,0,nil,c)
	return rg:IsExists(c44660066.spfilter1,1,nil,tp,rg)
end
function c44660066.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetMatchingGroup(c44660066.rfilter,tp,LOCATION_MZONE,0,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=rg:FilterSelect(tp,c44660066.spfilter1,1,1,nil,tp,rg)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=rg:FilterSelect(tp,c44660066.spfilter2,1,1,mc,tp,mc)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Remove(g1,POS_FACEUP,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end
