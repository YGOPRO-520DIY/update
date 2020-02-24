--堕天的二重阴影
function c65030028.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetOperation(c65030028.activate)
	c:RegisterEffect(e0)
	--wudieffect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCost(c65030028.cost)
	e1:SetOperation(c65030028.op)
	c:RegisterEffect(e1)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCondition(c65030028.discon)
	e3:SetOperation(c65030028.disop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e4)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_DISABLE)
	e6:SetRange(LOCATION_FZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(c65030028.distg)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e7)
	local e8=e6:Clone()
	e8:SetCode(EFFECT_SET_ATTACK)
	e8:SetValue(0)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e9)
end
function c65030028.thfilter(c)
	return c:IsSetCard(0xcda1) and c:IsAbleToHand()
end
function c65030028.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c65030028.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.GetFlagEffect(tp,65030026)==0 and Duel.SelectYesNo(tp,aux.Stringid(65030028,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.RegisterFlagEffect(tp,65030026,RESET_PHASE+PHASE_END,0,1)
	end
end
function c65030028.costfil(c,tp)
	return c:IsType(TYPE_XYZ) and c:CheckRemoveOverlayCard(tp,1,1) and not c:IsType(TYPE_EFFECT)
end
function c65030028.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65030028.costfil,tp,LOCATION_MZONE,0,1,nil,tp) and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_EFFECT)==0 and (Duel.GetFlagEffect(tp,65030027)==0 or Duel.GetFlagEffect(tp,65030028)==0) end
	local g=Duel.SelectMatchingCard(tp,c65030028.costfil,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.HintSelection(g)
	g:GetFirst():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c65030028.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local b1=Duel.GetFlagEffect(tp,65030027)==0
	local b2=Duel.GetFlagEffect(tp,65030028)==0
	local op=3
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65030028,0),aux.Stringid(65030028,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(65030028,0))
	elseif b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65030028,1))+1
	end
	if op==0 then
		--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(0xff,0xff)
	e2:SetTarget(c65030028.disable)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e2,tp)
		Duel.RegisterFlagEffect(tp,65030027,RESET_PHASE+PHASE_END,0,2)
	elseif op==1 then
		--cannot link summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c65030028.splimit)
	e3:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e3,tp)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e4,tp)
		Duel.RegisterFlagEffect(tp,65030028,RESET_PHASE+PHASE_END,0,2)
	end
end
function c65030028.splimit(e,c,tp,sumtp,sumpos)
	return c:IsType(TYPE_EFFECT)
end
function c65030028.disable(e,c)
	return c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end
function c65030028.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and not c:IsType(TYPE_EFFECT)  
end
function c65030028.cfilter2(c)
	return c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c65030028.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttackTarget()
	if not c then return false end
	if c65030028.cfilter(c) then c=Duel.GetAttacker() end
	return c and c65030028.cfilter2(c,tp)
end
function c65030028.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if c65030028.cfilter(tc) then tc=Duel.GetAttacker() end
	tc:RegisterFlagEffect(65030028,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE,0,1)
end
function c65030028.distg(e,c)
	return c:GetFlagEffect(65030028)~=0
end
