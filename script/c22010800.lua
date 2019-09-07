--从者Ruler 始皇帝
function c22010800.initial_effect(c)
	c:EnableReviveLimit()
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22010800,0))
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c22010800.condition)
	e1:SetCost(c22010800.cost)
	e1:SetTarget(c22010800.target)
	e1:SetOperation(c22010800.operation)
	c:RegisterEffect(e1)
	--card set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22010800,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,22010800)
	e2:SetCondition(c22010800.spcon)
	e2:SetTarget(c22010800.pentg)
	e2:SetOperation(c22010800.penop)
	c:RegisterEffect(e2)
end
function c22010800.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function c22010800.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
	Duel.PayLPCost(tp,2500)
end
function c22010800.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c22010800.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c22010800.spcon(e,tp,eg,ep,ev,re,r,rp)
	return c:GetSummonPlayer()~=tp and bit.band(c:GetSummonLocation(),LOCATION_HAND+LOCATION_GRAVE)~=0
		and c:IsAbleToDeck() and c:IsLocation(LOCATION_MZONE)
end
function c22010800.penfilter(c)
	return c:IsType(TYPE_CONTINUOUS) and not c:IsForbidden()
end
function c22010800.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22010800.penfilter,tp,LOCATION_DECK,0,1,nil)
		and (Duel.CheckLocation(tp,LOCATION_SZONE,0) or Duel.CheckLocation(tp,LOCATION_SZONE,1)) end
end
function c22010800.penop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c22010800.penfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end