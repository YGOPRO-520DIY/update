--tricoro·乙仓悠贵·S
function c81019008.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,3,2,nil,nil,99)
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81019008,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81019008)
	e1:SetCondition(c81019008.chcon)
	e1:SetCost(c81019008.cost)
	e1:SetOperation(c81019008.chop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c81019008.damcon1)
	e2:SetOperation(c81019008.damop1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c81019008.regcon)
	e3:SetOperation(c81019008.regop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_CHAIN_SOLVED)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c81019008.damcon2)
	e4:SetOperation(c81019008.damop2)
	c:RegisterEffect(e4)
	if not c81019008.global_check then
		c81019008.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVING)
		ge1:SetOperation(c81019008.count)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_CHAIN_SOLVED)
		ge2:SetOperation(c81019008.reset)
		Duel.RegisterEffect(ge2,0)
	end
end
function c81019008.count(e,tp,eg,ep,ev,re,r,rp)
	c81019008.chain_solving=true
end
function c81019008.reset(e,tp,eg,ep,ev,re,r,rp)
	c81019008.chain_solving=false
end
function c81019008.damcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp) and not c81019008.chain_solving
end
function c81019008.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,81019008)
	local ct=eg:FilterCount(Card.IsControler,nil,1-tp)
	Duel.Damage(1-tp,ct*200,REASON_EFFECT)
end
function c81019008.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp) and c81019008.chain_solving
end
function c81019008.regop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(Card.IsControler,nil,1-tp)
	e:GetHandler():RegisterFlagEffect(81019908,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,0,1,ct)
end
function c81019008.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(81019908)>0
end
function c81019008.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,81019008)
	local labels={e:GetHandler():GetFlagEffectLabel(81019908)}
	local ct=0
	for i=1,#labels do ct=ct+labels[i] end
	e:GetHandler():ResetFlagEffect(81019908)
	Duel.Damage(1-tp,ct*200,REASON_EFFECT)
end
function c81019008.chcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return (re:IsActiveType(TYPE_MONSTER) and loc==LOCATION_MZONE)
		or ((re:GetActiveType()==TYPE_SPELL or re:GetActiveType()==TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c81019008.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c81019008.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c81019008.repop)
end
function c81019008.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
