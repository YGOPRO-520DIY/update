--七大爱好传送机
function c81008000.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c81008000.eqtg)
	e1:SetOperation(c81008000.eqop)
	c:RegisterEffect(e1)
	--control
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c81008000.cttg)
	e4:SetOperation(c81008000.ctop)
	c:RegisterEffect(e4)
end
function c81008000.efilter(c,tp)
	return c:IsFaceup()
		and Duel.IsExistingMatchingCard(c81008000.eqfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,c)
end
function c81008000.eqfilter(c,tc)
	return c:IsType(TYPE_EQUIP) and c:IsSetCard(0x815) and c:CheckEquipTarget(tc)
end
function c81008000.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c81008000.efilter(chkc,1-tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c81008000.efilter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c81008000.efilter,tp,0,LOCATION_MZONE,1,1,nil,tp)
end
function c81008000.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c81008000.eqfilter),tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,tc)
	local eq=g:GetFirst()
	if eq then
		Duel.Equip(tp,eq,tc,true)
	end
end
function c81008000.ctfilter(c)
	return c:GetEquipGroup():IsExists(Card.IsSetCard,1,nil,0x815) and c:IsControlerCanBeChanged()
end
function c81008000.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c81008000.ctfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81008000.ctfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c81008000.ctfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c81008000.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
