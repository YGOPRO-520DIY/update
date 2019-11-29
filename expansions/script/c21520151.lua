--星曜成像-宇宙巨眼
function c21520151.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
--	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21520151.spcon)
	c:RegisterEffect(e1)
	--cannot special summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c21520151.splimit)
	c:RegisterEffect(e2)
	--atk & def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c21520151.aval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_SET_BASE_DEFENSE)
	e4:SetValue(c21520151.dval)
	c:RegisterEffect(e4)
	--self tograve
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_SELF_TOGRAVE)
	e5:SetCondition(c21520151.sdcon)
	c:RegisterEffect(e5)
	--add name
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_ADD_CODE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_ONFIELD+LOCATION_GRAVE)
	e6:SetValue(21520133)
	c:RegisterEffect(e6)
	--destroy replace
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_DESTROY_REPLACE)
	e7:SetTarget(c21520151.reptg)
	e7:SetOperation(c21520151.repop)
	c:RegisterEffect(e7)
end
function c21520151.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0x5491)
end
function c21520151.spfilter(c)
	return c:IsSetCard(0x491) and (not c:IsOnField() or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
end
function c21520151.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(e:GetHandlerPlayer(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(c21520151.spfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>15
end
--[[nction c21520151.spfilter1(c)
	return (c:IsSetCard(0x491) and not c:IsSetCard(0x5491) and not c:IsSetCard(0xa491)) and (not c:IsOnField() or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
end
function c21520151.spfilter2(c)
	return c:IsSetCard(0x5491) and (not c:IsOnField() or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
end
function c21520151.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(e:GetHandlerPlayer(),LOCATION_MZONE)<=0 then return false end
	local g1=Duel.GetMatchingGroup(c21520151.spfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local g2=Duel.GetMatchingGroup(c21520151.spfilter2,e:GetHandlerPlayer(),LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	local ct1=g1:GetClassCount(Card.GetCode)
	local ct2=g2:GetClassCount(Card.GetCode)
	return ct1>6 and ct2>0
end--]]
function c21520151.aval(e,c)
	local g=Duel.GetMatchingGroup(c21520151.spfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	local tc=g:GetFirst()
	local sum=0
	while tc do
		sum=sum+tc:GetAttack()
		tc=g:GetNext()
	end
	return sum
end
function c21520151.dval(e,c)
	local g=Duel.GetMatchingGroup(c21520151.spfilter1,e:GetHandlerPlayer(),LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	local tc=g:GetFirst()
	local sum=0
	while tc do
		sum=sum+tc:GetDefense()
		tc=g:GetNext()
	end
	return sum
end
function c21520151.sdfilter(c)
	return (not c:IsSetCard(0x491) or c:IsFacedown()) and c:IsType(TYPE_MONSTER)
end
function c21520151.sdcon(e)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(c21520151.sdfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	return g:GetCount()>0
end
function c21520151.sdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoGrave(c,REASON_RULE)
end
function c21520151.repfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c21520151.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup() and c:GetReasonPlayer()~=tp
		and Duel.IsExistingMatchingCard(c21520151.repfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,3,c) end
	if Duel.SelectYesNo(tp,aux.Stringid(21520151,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c21520151.repfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,3,3,c)
		Duel.SetTargetCard(g)
		return true
	else return false end
end
function c21520151.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
end
