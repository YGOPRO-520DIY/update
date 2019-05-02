--穗姬·白米
function c44470225.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c44470225.lcheck)
	c:EnableReviveLimit()
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetValue(44470222)
	c:RegisterEffect(e2)
	--SSet
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_SPSUMMON_SUCCESS)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1,44471225)
	e11:SetCondition(c44470225.condition)
	e11:SetTarget(c44470225.settg)
	e11:SetOperation(c44470225.setop)
	c:RegisterEffect(e11)
end
function c44470225.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end
--SSet
function c44470225.filter(c,ec)
	if not c:IsType(TYPE_NORMAL) or c:IsType(TYPE_TOKEN) then return false end
	if c:IsLocation(LOCATION_MZONE) then
		return ec:GetLinkedGroup():IsContains(c)
	else
		return bit.extract(ec:GetLinkedZone(c:GetPreviousControler()),c:GetPreviousSequence())~=0
	end
end
function c44470225.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not eg:IsContains(c) and eg:FilterCount(c44470225.filter,nil,c)>=1
end
function c44470225.setfilter(c)
	return c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and c:IsSSetable()
end
function c44470225.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44470225.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c44470225.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c44470225.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
	end
end