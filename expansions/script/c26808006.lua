--回归之风·白鹭千圣
function c26808006.initial_effect(c)
	--material
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e0:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	e0:SetCountLimit(1,26808006)
	e0:SetCondition(c26808006.matcon)
	e0:SetTarget(c26808006.mattg)
	e0:SetOperation(c26808006.matop)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_XMATERIAL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c26808006.condition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
end
function c26808006.cfilter1(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsControler(tp) and c:IsCanBeEffectTarget(e)
end
function c26808006.matcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c26808006.cfilter1,1,nil,e,tp)
end
function c26808006.tgfilter(c,tp,eg)
	return eg:IsContains(c) and c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsControler(tp)
end
function c26808006.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c26808006.tgfilter(chkc,tp,eg) end
	if chk==0 then return Duel.IsExistingTarget(c26808006.tgfilter,tp,LOCATION_MZONE,0,1,nil,tp,eg) end
	if eg:GetCount()==1 then
		Duel.SetTargetCard(eg)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c26808006.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp,eg)
	end
end
function c26808006.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
function c26808006.condition(e)
	return e:GetHandler():GetOriginalRank()==9
end
