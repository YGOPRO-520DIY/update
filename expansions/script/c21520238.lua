--星曜圣装-轸水蚓
function c21520238.initial_effect(c)
	c:SetSPSummonOnce(21520238)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520238,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520238.sprcon)
	e0:SetOperation(c21520238.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520238.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520238,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_DESTROY+CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520238.igtg)
	e2:SetOperation(c21520238.igop)
	c:RegisterEffect(e2)
end
c21520238.card_code_list={21520128}
function c21520238.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520238.spfilter(c)
	return c:IsCode(21520128) and c:IsAbleToRemoveAsCost()
end
function c21520238.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520238.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520238.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520238.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520238.igfilter(c)
	return c:IsAbleToHand() and c:IsType(TYPE_SPELL)
end
function c21520238.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c21520238.igop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if c:IsRelateToEffect(e) and g:GetCount()>0 then 
		local dt=Duel.TossDice(tp,1)
		if g:GetCount()>=dt then 
			local dg=Duel.GetDecktopGroup(tp,dt)
			Duel.ConfirmDecktop(tp,dt)
			if dg:IsExists(c21520238.igfilter,1,nil) then 
				Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
				local sg=dg:FilterSelect(tp,c21520237.igfilter,1,1,nil)
				Duel.SendtoHand(sg,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sg)
			else 
				Duel.Destroy(c,REASON_EFFECT)
			end
		else 
			Duel.Destroy(c,REASON_EFFECT)
		end
		Duel.ShuffleDeck(tp)
	end
end
