--星曜斥力
function c21520146.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520146,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c21520146.condition)
	e1:SetTarget(c21520146.target)
	e1:SetOperation(c21520146.activate)
	c:RegisterEffect(e1)
	--power up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520146,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetCondition(c21520146.pcon)
	e2:SetTarget(c21520146.ptg)
	e2:SetOperation(c21520146.pop)
	c:RegisterEffect(e2)
	if not c21520146.global_check then
		c21520146.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLED)
		ge1:SetOperation(c21520146.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c21520146.checkop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	local dc=Duel.GetAttackTarget()
	if ac and ac:IsStatus(STATUS_BATTLE_DESTROYED) then
		ac:RegisterFlagEffect(21520146,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
	if dc and dc:IsStatus(STATUS_BATTLE_DESTROYED) then
		dc:RegisterFlagEffect(21520146,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
end
function c21520146.filter(c,tp)
	return c:GetFlagEffect(21520146)~=0 and c:GetPreviousControler()==tp
end
function c21520146.effectfilter(c)
	return c:IsCode(21520133) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21520146.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c21520146.filter,1,nil,tp) and Duel.IsExistingMatchingCard(c21520146.effectfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function c21520146.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c21520146.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
function c21520146.pcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,21520142)
end
function c21520146.ptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c21520146.pop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,tc)
	local mc=g:GetFirst()
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		mc=g:GetFirst()
		while mc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(-tc:GetAttack())
			mc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			e2:SetValue(-tc:GetDefense())
			mc:RegisterEffect(e2)
			mc=g:GetNext()
		end
	end
end
