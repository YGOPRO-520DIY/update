--雪暴世界
function c65080009.initial_effect(c)
	--ac
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65080009,1))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c65080009.cttg)
	e2:SetOperation(c65080009.ctop)
	c:RegisterEffect(e2)
	--race
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_HAND+LOCATION_GRAVE,0)
	e3:SetCode(EFFECT_CHANGE_RACE)
	e3:SetTarget(c65080009.rctg)
	e3:SetValue(RACE_WINDBEAST)
	c:RegisterEffect(e3)
end

function c65080009.rctg(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end

function c65080009.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c65080009.ctfil,tp,LOCATION_MZONE,0,nil)>0 end
end

function c65080009.ctfil(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup()
end
function c65080009.fil(c)
	return c:IsCode(65080010) and not c:IsForbidden()
end
function c65080009.ctop(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetMatchingGroup(c65080009.ctfil,tp,LOCATION_MZONE,0,nil)
	local ct=cg:GetCount()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()==0 then return end
	for i=1,ct do
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(65080009,2))
		local tc=g:Select(tp,1,1,nil):GetFirst()
		tc:AddCounter(0x1015,1)
	end
	if Duel.IsExistingMatchingCard(c65080009.fil,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(65080009,3)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local tc=Duel.SelectMatchingCard(tp,c65080009.fil,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil):GetFirst()
		if tc then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end
