--缚灵的街道
function c65020043.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c65020043.hsptg)
	e1:SetOperation(c65020043.hspop)
	c:RegisterEffect(e1)
	--sp dot
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c65020043.spdcon)
	e2:SetTarget(c65020043.spdtg)
	e2:SetOperation(c65020043.spdop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c65020043.indtg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c65020043.indtg(e,c)
	return c:IsSetCard(0x3da4) and c:IsType(TYPE_SYNCHRO) and c:IsFaceup()
end

function c65020043.hsptgfil(c)
	return c:GetOriginalRace()==RACE_ZOMBIE and c:IsType(TYPE_SYNCHRO) and c:IsPreviousLocation(LOCATION_ONFIELD)
end

function c65020043.hspfilter(c,e,tp)
	return c:IsType(TYPE_TUNER) and c:IsLevelAbove(5) and c:IsRace(RACE_ZOMBIE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c65020043.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c65020043.hsptgfil,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65020043.hspfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c65020043.hspop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65020043.hspfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	if tc then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) end
end

function c65020043.spdcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local tp=e:GetHandler():GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end

function c65020043.spdfil(c,e,tp)
	return c:IsCode(65020027) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c65020043.spdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c65020043.spdfil,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK)
end

function c65020043.spdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65020043.spdfil,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end