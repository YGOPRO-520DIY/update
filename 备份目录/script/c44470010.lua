--真红眼黑龙·终焉
function c44470010.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,c44470010.ovfilter,aux.Stringid(44470010,0))
	c:EnableReviveLimit()
	--To Grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470010,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c44470010.tgcon)
	e1:SetCost(c44470010.tgcost)
	e1:SetTarget(c44470010.tgtg)
	e1:SetOperation(c44470010.tgop)
	c:RegisterEffect(e1)
	--indes
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(c44470010.indcon)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	--atk change
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_SET_ATTACK_FINAL)
	e12:SetRange(LOCATION_MZONE)
	e12:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e12:SetCondition(c44470010.atkcon)
	e12:SetTarget(c44470010.atktg)
	e12:SetValue(c44470010.atkval)
	c:RegisterEffect(e12)
end
function c44470010.ovfilter(c)
	return c:IsFaceup() and c:IsCode(74677422)
end
--To Grave
function c44470010.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsSetCard,1,nil,0x3b)
end
function c44470010.sfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c44470010.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() and
	Duel.IsExistingMatchingCard(c44470010.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470010.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)

	local tc=g:GetFirst()
	if Duel.Remove(tc,tc:GetPosition(),REASON_COST+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetOperation(c44470010.retop)
		Duel.RegisterEffect(e1,tp)
	    if Duel.Remove(c,POS_FACEUP,REASON_COST+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(c)
		e1:SetCountLimit(1)
		e1:SetOperation(c44470010.rettop)
		Duel.RegisterEffect(e1,tp)
		end
	end
end
function c44470010.rettop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
function c44470010.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end

function c44470010.tgfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function c44470010.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470010.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
end
function c44470010.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44470010.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--indes
function c44470010.indcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
--atk change
function c44470010.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget() and e:GetHandler():IsRelateToBattle()
end
function c44470010.atktg(e,c)
	return c:IsRelateToBattle() and c~=e:GetHandler()
end
function c44470010.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if c:GetFlagEffect(44470010)~=0 then return 0 end
	if c:GetAttack()<d:GetAttack() then
		c:RegisterFlagEffect(44470010,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
		return 0
	else return 0 end
end