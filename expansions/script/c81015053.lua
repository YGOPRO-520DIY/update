--北上丽花的思虑
require("expansions/script/c81000000")
function c81015053.initial_effect(c)
	--act in hand
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e0:SetCondition(Tenka.ReikaCon)
	c:RegisterEffect(e0)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,81015053+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c81015053.condition)
	e1:SetOperation(c81015053.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c81015053.reptg)
	e2:SetValue(c81015053.repval)
	e2:SetOperation(c81015053.repop)
	c:RegisterEffect(e2)
end
function c81015053.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and ((a:IsControler(tp) and a:IsSetCard(0x81a))
		or (at:IsControler(tp) and at:IsFaceup() and at:IsSetCard(0x81a)))
end
function c81015053.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a,at=at,a end
	if not a:IsRelateToBattle() or a:IsFacedown() or not at:IsRelateToBattle() or at:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
	e1:SetValue(at:GetAttack())
	a:RegisterEffect(e1)
end
function c81015053.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x81a)
		and c:IsOnField() and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c81015053.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and Tenka.ReikaCon(e) and eg:IsExists(c81015053.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c81015053.repval(e,c)
	return c81015053.repfilter(c,e:GetHandlerPlayer())
end
function c81015053.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
