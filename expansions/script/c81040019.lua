--周子·红叶秋风
function c81040019.initial_effect(c)
	local e1=aux.AddRitualProcGreater2(c,c81040019.filter,LOCATION_HAND+LOCATION_GRAVE)   
	e1:SetCountLimit(1,81040019)
	--to deck
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_GRAVE)
	e6:SetCountLimit(1,81040919)
	e6:SetCondition(aux.exccon)
	e6:SetCost(aux.bfgcost)
	e6:SetTarget(c81040019.tdtg)
	e6:SetOperation(c81040019.tdop)
	c:RegisterEffect(e6)
end
function c81040019.filter(c)
	return c:IsSetCard(0x81c)
end
function c81040019.tdfilter(c)
	return not c:IsCode(81040019) and c:IsSetCard(0x81c) and c:IsAbleToDeck()
		and (not e or c:IsCanBeEffectTarget(e))
		and (not c:IsLocation(LOCATION_REMOVED) or c:IsFaceup())
end
function c81040019.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c81040019.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81040019.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.GetMatchingGroup(c81040019.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,e:GetHandler(),e)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,#g)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,#sg,0,0)
end
function c81040019.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
