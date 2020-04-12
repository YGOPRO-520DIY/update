--失落看守者
function c65080055.initial_effect(c)
	--attack0
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_ACTION+CATEGORY_LEAVE_GRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,65080055)
	e1:SetCondition(c65080055.condition)
	e1:SetTarget(c65080055.target)
	e1:SetOperation(c65080055.activate)
	c:RegisterEffect(e1)
end
function c65080055.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c65080055.filter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFacedown()
end
function c65080055.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return c65080055.filter(chkc) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c65080055.filter,tp,LOCATION_MZONE,0,1,nil) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE) and Duel.GetMZoneCount(tp)>0 end
	Duel.SelectTarget(tp,c65080055.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c65080055.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsAttribute(ATTRIBUTE_EARTH) and tc:IsRace(RACE_ROCK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE) and Duel.GetMZoneCount(tp)>0 then
			if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)~=0 then
				Duel.ConfirmCards(1-tp,c)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetCode(EFFECT_ONLY_ATTACK_MONSTER)
				e1:SetTargetRange(0,LOCATION_MZONE)
				e1:SetValue(c65080055.atklimit)
				e1:SetLabel(c:GetRealFieldID())
				e1:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e1,tp)
				c:RegisterFlagEffect(65080055,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,0)
				if c:GetSummonLocation()==LOCATION_GRAVE then
					local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
				end
			end
		end
	end
end
function c65080055.atklimit(e,c)
	return c:GetRealFieldID()==e:GetLabel()
end