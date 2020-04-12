--期许彩恋 约定少女
function c65050257.initial_effect(c)
	 --link summon
	aux.AddLinkProcedure(c,nil,2,2,c65050257.lcheck)
	c:EnableReviveLimit()
	 --tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65050257)
	e1:SetCondition(c65050257.spcon)
	e1:SetTarget(c65050257.sptg)
	e1:SetOperation(c65050257.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050258)
	e2:SetCondition(c65050257.condition)
	e2:SetCost(c65050257.cost)
	e2:SetTarget(c65050257.target)
	e2:SetOperation(c65050257.activate)
	c:RegisterEffect(e2)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MATERIAL_CHECK)
	e4:SetValue(c65050257.valcheck)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCondition(c65050257.regcon)
	e5:SetOperation(c65050257.regop)
	c:RegisterEffect(e5)
	e4:SetLabelObject(e5)
end
function c65050257.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9da9)
end
function c65050257.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x9da9) and c:IsControler(tp)
end
function c65050257.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c65050257.cfilter,1,nil,tp)
end
function c65050257.spfilter(c)
	return c:IsSetCard(0x9da9) and c:IsAbleToHand()
end
function c65050257.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c65050257.spfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65050257.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectTarget(tp,c65050257.spfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c65050257.valcfil(c,tp)
	return c:GetOwner()~=tp
end
function c65050257.valcheck(e,c)
	local tp=c:GetControler()
	local g=c:GetMaterial()
	if g:IsExists(c65050257.valcfil,1,nil,tp) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c65050257.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) and e:GetLabel()==1
end
function c65050257.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(65050257,RESET_EVENT+RESETS_STANDARD,0,1)
end
function c65050257.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(65050257)~=0
end
function c65050257.costfil(c)
	return c:IsAbleToGraveAsCost() and c:IsFaceup() and c:IsSetCard(0x9da9)
end
function c65050257.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050257.costfil,tp,LOCATION_EXTRA,0,1,nil) end
	local g=Duel.SelectMatchingCard(tp,c65050257.costfil,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c65050257.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c65050257.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end