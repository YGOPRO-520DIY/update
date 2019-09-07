--十二宫·室女座
function c44470456.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate remove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_QUICK_O)
	--e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470456)
	e2:SetCondition(c44470456.condition)
	e2:SetTarget(c44470456.target)
	e2:SetOperation(c44470456.activate)
	c:RegisterEffect(e2)
	--Control
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_CONTROL)
	e11:SetDescription(aux.Stringid(44470456,1))
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCountLimit(1,44471456)
	e11:SetRange(LOCATION_GRAVE)
	e11:SetCondition(c44470456.condition)
	e11:SetCost(c44470456.discost)
	e11:SetTarget(c44470456.tg)
	e11:SetOperation(c44470456.operation)
	c:RegisterEffect(e11)
end
--remove
function c44470456.cfilter(c)
	return c:IsCode(44470456)
end
function c44470456.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470456.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470456.rmfilter(c)
	return c:IsAbleToRemove() and c:IsSetCard(0x64f)
	 --and not c:IsAttribute(ATTRIBUTE_DARK)
end
function c44470456.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470456.rmfilter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44470456.rmfilter,tp,LOCATION_DECK,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c44470456.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470456.rmfilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
--Control
function c44470456.costfilter(c)
	return c:IsSetCard(0x64f) and c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c44470456.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() and 
		Duel.IsExistingMatchingCard(c44470456.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470456.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c44470456.ccfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsControlerCanBeChanged() and c:IsFaceup()
end
function c44470456.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()~=tp and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(c44470456.ccfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c44470456.ccfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c44470456.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end