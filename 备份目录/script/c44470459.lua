--十二宫·射手座
function c44470459.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	--e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e2:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_QUICK_O)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44470459)
	e2:SetCondition(c44470459.condition)
	e2:SetTarget(c44470459.target)
	e2:SetOperation(c44470459.activate)
	c:RegisterEffect(e2)
	--Destroy and remove
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_REMOVE+CATEGORY_DESTROY)
	e11:SetDescription(aux.Stringid(44470459,1))
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_REMOVE)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e11:SetCountLimit(1,44471459)
	e11:SetCondition(c44470459.condition)
	e11:SetTarget(c44470459.destg)
	e11:SetOperation(c44470459.desop)
	c:RegisterEffect(e11)
end
--Activate
function c44470459.cfilter(c)
	return c:IsCode(44470459)
end
function c44470459.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c44470459.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c44470459.filter(c)
	return c:IsSetCard(0x140) and c:IsType(TYPE_MONSTER)
end
function c44470459.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470459.filter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470459.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44470459.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end
--Destroy and remove
function c44470459.defilter(c)
	return c:IsFaceup()
	and c:IsAbleToRemove() and c:IsDestructable()
end
function c44470459.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470459.defilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c44470459.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44470459.defilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
	local opt=Duel.SelectOption(tp,aux.Stringid(44470459,2),aux.Stringid(44470459,3))
	    if opt==0 then
		Duel.Destroy(g,REASON_EFFECT)
	    else
	    Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	    end
	end
end