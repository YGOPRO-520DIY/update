--星空闪耀之魔术师
function c34540010.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,false,true,c34540010.fusfilter1,c34540010.fusfilter2)
	-----------
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34540010,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c34540010.destg)
	e1:SetOperation(c34540010.desop)
	c:RegisterEffect(e1)
	------------------
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34540010,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,34540010)
	e3:SetCondition(c34540010.sccon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c34540010.thtg)
	e3:SetOperation(c34540010.thop)
	c:RegisterEffect(e3)
	----------------
end
function c34540010.fusfilter1(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS)
end
function c34540010.fusfilter2(c)
	return c:GetType()==TYPE_SPELL 
end
function c34540010.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c34540010.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) and c34540010.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c34540010.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c34540010.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c34540010.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
	local dg=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if dg:GetCount()>0 and tc:IsType(TYPE_SPELL) and Duel.SelectYesNo(tp,aux.Stringid(34540010,1)) then 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=dg:Select(tp,1,1,nil)
	Duel.HintSelection(sg)
	Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
function c34540010.sccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_FUSION 
end
------------------
function c34540010.thfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c34540010.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34540010.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c34540010.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34540010.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
