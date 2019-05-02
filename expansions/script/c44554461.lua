--黑虎白樱
function c44554461.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44554461.matfilter,1)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c44554461.dtg)
	e1:SetOperation(c44554461.dop)
	c:RegisterEffect(e1)
end
function c44554461.matfilter(c)
	return c:GetAttack()>=2500
end
function c44554461.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
	and c:IsCanChangePosition()	and not c:IsDisabled()
end
function c44554461.dtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44554461.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44554461.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	Duel.SelectTarget(tp,c44554461.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)

end
function c44554461.dop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsDisabled() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
			e2:SetValue(0)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
	end
	local gc=tc:GetCode()
	e:SetLabel(gc)
		--local tc=g:GetFirst()
		local e11=Effect.CreateEffect(e:GetHandler())
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_CHANGE_CODE)
		e11:SetReset(RESET_EVENT+0x1fe0000)
		e11:SetValue(e:GetLabel())
		c:RegisterEffect(e11)
end