--指令·占术
function c95210002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,95210002)
	e1:SetTarget(c95210002.target)
	e1:SetOperation(c95210002.activate)
	c:RegisterEffect(e1)
end
function c95210002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c95210002.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,5)
	if Duel.GetFlagEffect(tp,95210002)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(95210002,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelAbove,5))
	e1:SetValue(0x1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end

