--奇术都市 奇石晶城
function c65020162.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c65020162.cost)
	e1:SetTarget(c65020162.target)
	e1:SetOperation(c65020162.activate)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c65020162.tg)
	e2:SetOperation(c65020162.op)
	c:RegisterEffect(e2)
end
function c65020162.costfil(c,tp)
	return c:IsSetCard(0xada8) and not c:IsPublic() and Duel.IsExistingMatchingCard(c65020162.thfil,tp,LOCATION_DECK,0,1,nil,c:GetCode())
end
function c65020162.thfil(c,code)
	return (c:GetCode()==code+4 or c:GetCode()==code-4) and c:IsSetCard(0xada8) and c:IsAbleToHand()
end
function c65020162.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020162.costfil,tp,LOCATION_HAND,0,1,nil,tp) end
	local g=Duel.SelectMatchingCard(tp,c65020162.costfil,tp,LOCATION_HAND,0,1,1,nil,tp)
	local gc=g:GetFirst()
	Duel.ConfirmCards(1-tp,gc)
	Duel.ShuffleHand(tp)
	e:SetLabel(gc:GetCode())
end
function c65020162.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65020162.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65020162.thfil,tp,LOCATION_DECK,0,1,1,nil,code)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end


function c65020162.desfil(c)
	return c:GetCounter(0x1da2)>0
end
function c65020162.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65020162.desfil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c65020162.desfil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c65020162.op(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c65020162.desfil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
