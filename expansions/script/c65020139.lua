--少女的黑暗夜之梦
function c65020139.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_FZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5da7))
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c65020139.condition)
	e2:SetCost(c65020139.cost)
	e2:SetTarget(c65020139.target)
	e2:SetOperation(c65020139.operation)
	c:RegisterEffect(e2)
end
function c65020139.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():GetControler()~=tp and Duel.GetAttackTarget()==nil 
end
function c65020139.costfil(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x5da7) and c:IsType(TYPE_MONSTER)
end
function c65020139.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020139.costfil,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c65020139.costfil,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c65020139.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c65020139.dfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x5da7)
end
function c65020139.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local atk=e:GetLabelObject():GetAttack()
   local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetLabel(atk)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCondition(c65020139.condition2)
	e1:SetOperation(c65020139.activate)
	Duel.RegisterEffect(e1,tp)
	Duel.BreakEffect()
	local mmm=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if mmm:GetCount()>0 then
		Duel.ConfirmCards(1-tp,mmm)
		if mmm:FilterCount(c65020139.dfilter,nil)==0 then
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
end
function c65020139.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetTurnPlayer()~=tp
end
function c65020139.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local aa=a:GetAttack()
	local atk=e:GetLabel()
	local aatk=aa-atk
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e4:SetValue(aatk)
	a:RegisterEffect(e4,true)
end