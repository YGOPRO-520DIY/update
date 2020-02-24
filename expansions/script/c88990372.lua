--超越的圣刻印
function c88990372.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,88990372+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c88990372.discost)
	e1:SetTarget(c88990372.target)
	e1:SetOperation(c88990372.activate)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88990372,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c88990372.atktg)
	e2:SetOperation(c88990372.atkop)
	c:RegisterEffect(e2)
end
function c88990372.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,Card.IsRace,1,e:GetHandler(),RACE_DRAGON) end
	local g=Duel.SelectReleaseGroupEx(tp,Card.IsRace,1,1,e:GetHandler(),RACE_DRAGON)
	Duel.Release(g,REASON_COST)
	local rc=g:GetFirst()
	if rc:IsSetCard(0x69) then e:SetLabel(1)
	--elseif not rc:IsSetCard(0x69) then e:SetLabel(2)
	else e:SetLabel(0)
	end
end
function c88990372.filter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c88990372.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c88990372.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88990372.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c88990372.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
end
function c88990372.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsDisabled() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if e:GetLabel()==1 then
 		    local dg=Duel.GetMatchingGroup(c88990372.thfilter,tp,0,LOCATION_ONFIELD,nil)
			if dg:GetCount()>1 then
		    Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		    local sg=dg:Select(1-tp,1,1,nil)
		    Duel.HintSelection(sg)
		    Duel.SendtoGrave(sg,REASON_RULE)
            end
		end
	end
end
function c88990372.thfilter(c)
	return c:IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) 
end
--atk
function c88990372.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x69)
end
function c88990372.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c88990372.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88990372.sfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c88990372.sfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c88990372.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end
