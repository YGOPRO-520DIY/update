--古夕幻历-洛水沉鱼
function c44460156.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c44460156.condition)
	e1:SetTarget(c44460156.target)
	e1:SetOperation(c44460156.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
end
function c44460156.sfilter(c)
	return c:IsSetCard(0x64a) and c:IsSummonable(true,e) and c:IsType(TYPE_MONSTER)
end
function c44460156.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44460156.filter,tp,LOCATION_HAND,0,1,nil)
		and Duel.GetCurrentChain()==0
end
function c44460156.target(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chk==0 then return Duel.IsExistingMatchingCard(c44460156.sfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44460156.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	Duel.BreakEffect()	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44460156.sfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end
