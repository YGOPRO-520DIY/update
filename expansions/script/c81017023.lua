--收获之秋·高山纱代子
function c81017023.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),true)
	--summon success
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetCondition(c81017023.sumcon)
	e0:SetOperation(c81017023.sumsuc)
	c:RegisterEffect(e0)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81017023)
	e1:SetCondition(c81017023.btkcon)
	e1:SetTarget(c81017023.btktg)
	e1:SetOperation(c81017023.btkop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c81017023.valcheck)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c81017023.atkcon)
	e3:SetOperation(c81017023.atkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c81017023.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c81017023.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c81017023.actlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c81017023.disable)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c81017023.actlimit(e,re,tp)
	return re:GetHandler():IsRace(RACE_FAIRY) and re:IsActiveType(TYPE_MONSTER)
end
function c81017023.disable(e,c)
	return bit.band(c:GetRace(),RACE_FAIRY)~=0
end
function c81017023.valcheck(e,c)
	local g=c:GetMaterial()
	local atk=0
	local tc=g:GetFirst()
	if tc:IsRace(RACE_WARRIOR) or tc:CheckFusionSubstitute(c) then tc=g:GetNext() end
	if tc:IsRace(RACE_FAIRY) then
		atk=tc:GetTextAttack()
	end
	e:SetLabel(atk)
end
function c81017023.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c81017023.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=e:GetLabelObject():GetLabel()
	if atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c81017023.btkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsControler(1-tp) and tc:IsRace(RACE_FAIRY)
end
function c81017023.effilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAbleToRemove()
end
function c81017023.btktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81017023.effilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c81017023.effilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	if e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION) and not Duel.IsExistingMatchingCard(c81017023.acfilter,tp,LOCATION_MZONE,0,1,nil) then
		Duel.SetChainLimit(c81017023.chainlm)
	end
end
function c81017023.acfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c81017023.chainlm(e,rp,tp)
	return tp==rp
end
function c81017023.btkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c81017023.effilter,tp,0,LOCATION_MZONE,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
