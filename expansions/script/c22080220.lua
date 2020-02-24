--宝具 苍辉银河即宇宙
function c22080220.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22080220,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,22080220+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c22080220.target)
	e1:SetOperation(c22080220.activate)
	c:RegisterEffect(e1)
end
c22080220.card_code_list={22000990}
function c22080220.filter(c)
	return c:IsType(TYPE_FUSION+TYPE_XYZ)
end
function c22080220.filter2(c,e,tp)
	return c:IsCode(22000990) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22080220.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c22080220.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c22080220.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c22080220.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c22080220.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local tc=Duel.GetFirstMatchingCard(c22080220.filter2,tp,LOCATION_EXTRA,0,nil,e,tp)
		if tc and Duel.SelectYesNo(tp,aux.Stringid(22080220,1)) then
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end