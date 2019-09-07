--雪暴猎鹰-神鸟
function c43694483.initial_effect(c)
	--code
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(43694481)
	c:RegisterEffect(e1)
	--mat check
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_MATERIAL_CHECK)
	e0:SetValue(c43694483.valcheck)
	c:RegisterEffect(e0)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c43694483.regcon)
	e2:SetOperation(c43694483.regop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e0)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e3:SetCountLimit(1,43694483)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c43694483.damcon)
	e3:SetTarget(c43694483.damtg)
	e3:SetOperation(c43694483.damop)
	c:RegisterEffect(e3)
end
function c43694483.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	local tc=g:GetFirst()
	while tc do
		if tc:IsCode(43694481) then flag=bit.bor(flag,0x1) end
		tc=g:GetNext()
	end
	e:SetLabel(flag)
end
function c43694483.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c43694483.regop(e,tp,eg,ep,ev,re,r,rp)
	local flag=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if bit.band(flag,0x1)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end

function c43694483.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttack()>e:GetHandler():GetBaseAttack()
end
function c43694483.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1800)
end
function c43694483.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end