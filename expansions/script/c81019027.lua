--星之世界·爱米莉
function c81019027.initial_effect(c)
	c:EnableReviveLimit()
	aux.EnablePendulumAttribute(c,false)
	c:SetSPSummonOnce(81019027)
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c81019027.sprcon)
	e0:SetOperation(c81019027.sprop)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,81019027)
	e1:SetTarget(c81019027.sptg)
	e1:SetOperation(c81019027.spop)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c81019027.rectg)
	e2:SetOperation(c81019027.recop)
	c:RegisterEffect(e2)
	--ritual level
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_RITUAL_LEVEL)
	e3:SetValue(c81019027.rlevel)
	c:RegisterEffect(e3)
	--pendulum
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(81019027,3))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCondition(c81019027.pencon)
	e6:SetTarget(c81019027.pentg)
	e6:SetOperation(c81019027.penop)
	c:RegisterEffect(e6)
end
function c81019027.sprfilter(c)
	return c:IsFaceup() and c:IsReleasable()
end
function c81019027.sprfilter1(c,tp,g,sc)
	local lv=c:GetLevel()
	return c:IsType(TYPE_TUNER) and g:IsExists(c81019027.sprfilter2,1,c,tp,c,sc,lv)
end
function c81019027.sprfilter2(c,tp,mc,sc,lv)
	local sg=Group.FromCards(c,mc)
	return c:GetLevel()==lv-4 and c:GetOriginalLevel()>0 and not c:IsType(TYPE_TUNER)
		and Duel.GetLocationCountFromEx(tp,tp,sg,sc)>0
end
function c81019027.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c81019027.sprfilter,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c81019027.sprfilter1,1,nil,tp,g,c)
end
function c81019027.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c81019027.sprfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=g:FilterSelect(tp,c81019027.sprfilter1,1,1,nil,tp,g,c)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g2=g:FilterSelect(tp,c81019027.sprfilter2,1,1,mc,tp,mc,c,mc:GetLevel())
	g1:Merge(g2)
	Duel.Release(g1,REASON_COST)
end
function c81019027.spfilter(c,e,tp)
	return c:IsRace(RACE_PYRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81019027.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c81019027.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c81019027.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c81019027.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c81019027.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c81019027.recfilter(c)
	return c:IsFaceup() and c:GetAttack()>0 and c:IsType(TYPE_RITUAL) and c:IsType(TYPE_PENDULUM)
end
function c81019027.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc~=c and chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c81019027.recfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81019027.recfilter,tp,LOCATION_MZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c81019027.recfilter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
end
function c81019027.recop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>0 then
		Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
	end
end
function c81019027.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if c:IsType(TYPE_RITUAL) and c:IsType(TYPE_PENDULUM) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
function c81019027.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c81019027.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c81019027.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
