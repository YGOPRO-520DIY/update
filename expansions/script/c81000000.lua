--Extra Data of DJ.Tenka
Tenka=Tenka or {}
--Mogami Shizuka, 81018xxx, 0x81b
function Tenka.Shizuka(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e0:SetValue(1)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(Tenka.valcon)
	c:RegisterEffect(e1)
end
function Tenka.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
--Kitakami Reika, 81015xxx(81015028~ ), 0x81a
--Reika effect condition
function Tenka.ReikaCon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandlerPlayer()
	for i=0,4 do
		if Duel.GetFieldCard(tp,LOCATION_SZONE,i) then return false end
	end
	return true
end
--koikake atk
function Tenka.KoikakeRitual(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCode(EFFECT_UPDATE_ATTACK)
	e0:SetCondition(Tenka.atkcon)
	e0:SetValue(Tenka.btkval)
	c:RegisterEffect(e0)
end
function Tenka.KoikakeLink(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_UPDATE_ATTACK)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCondition(Tenka.atkcon)
	e0:SetValue(Tenka.atkval)
	c:RegisterEffect(e0)
end
function Tenka.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function Tenka.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) and c:IsType(TYPE_PENDULUM) and c:GetLevel()>0
end
function Tenka.atkval(e,c)
	local lg=c:GetLinkedGroup():Filter(Tenka.atkfilter,nil)
	return lg:GetSum(Card.GetLevel)*300
end
function Tenka.btkval(e,c)
	return c:GetLevel()*300
end
--kobayashi maid dragon
--advanced summon
function Tenka.MaidDragon(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e0:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e0:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_FIELD))
	e0:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e0)
end
--
function Tenka.Asamiya(c)
	c:EnableReviveLimit()
	aux.AddCodeList(c,81027000)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_CHANGE_CODE)
	e0:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e0:SetValue(81027000)
	c:RegisterEffect(e0)
end
