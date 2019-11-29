--星曜圣装-室火猪
function c21520223.initial_effect(c)
	c:SetSPSummonOnce(21520223)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520223,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520223.sprcon)
	e0:SetOperation(c21520223.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520223.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520223,1))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520223.igtg)
	e2:SetOperation(c21520223.igop)
	c:RegisterEffect(e2)
end
c21520223.card_code_list={21520113}
function c21520223.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520223.spfilter(c)
	return c:IsCode(21520113) and c:IsAbleToRemoveAsCost()
end
function c21520223.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520223.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520223.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520223.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520223.igfilter(c)
	return not c:IsPublic() and c:IsSetCard(0x491)
end
function c21520223.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21520223.igfilter,tp,LOCATION_HAND,0,1,nil) end
	local val=Duel.GetMatchingGroupCount(c21520223.igfilter,tp,LOCATION_HAND,0,nil)*600
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(val)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,val)
end
function c21520223.igop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(c21520223.igfilter,p,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then 
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_CONFIRM)
		local pg=g:Select(p,1,g:GetCount(),nil)
		Duel.ConfirmCards(1-p,pg)
		d=pg:GetCount()*600
		Duel.Recover(p,d,REASON_EFFECT)
	end
end
