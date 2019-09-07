--元素魔法 妖精护盾
function c17500024.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17500024.con)
	e1:SetTarget(c17500024.tg)
	e1:SetOperation(c17500024.op)
	c:RegisterEffect(e1)
end
c17500024.setname="ElementalSpell"
function c17500024.confil(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end 
function c17500024.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500024.confil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500024.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local m=Duel.SelectOption(tp,aux.Stringid(17500024,0),aux.Stringid(17500024,1))
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(17500024,m))
	e:SetLabel(m)
end
function c17500024.op(e,tp,eg,ep,ev,re,r,rp)
	local m=e:GetLabel()
	local c=e:GetHandler()
	if m==0 and Duel.IsExistingMatchingCard(c17500024.confil,tp,LOCATION_MZONE,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c17500024.confil,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_IMMUNE_EFFECT)
		e4:SetValue(c17500024.efilter)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e4)
	elseif m==1 then
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c17500024.damval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	end
end
function c17500024.efilter(e,re)
	return e:GetHandlerPlayer()~=re:GetOwnerPlayer()
end
function c17500024.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end