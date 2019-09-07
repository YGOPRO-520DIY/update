--迦勒底 玛修·基列莱特
function c22000120.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xffe),aux.NonTuner(Card.IsSetCard,0xfff),1)
	c:EnableReviveLimit()
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c22000120.targeta)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c22000120.targeta)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--change battle target
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(22000120,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c22000120.cbcon)
	e3:SetTarget(c22000120.cbtg)
	e3:SetOperation(c22000120.cbop)
	c:RegisterEffect(e3)
end
function c22000120.targeta(e,c)
	return c:IsFaceup() and (c:IsSetCard(0xfff) or c:IsSetCard(0xffe))
end
function c22000120.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and c~=bt and bt:IsFaceup() and bt:GetControler()==c:GetControler()
end
function c22000120.cbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():GetAttackableTarget():IsContains(e:GetHandler()) end
end
function c22000120.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(c)
	end
end
