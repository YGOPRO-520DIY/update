--自古弓兵多挂B！
function c2026.initial_effect(c)
	--装备
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c2026.eqtg)
	e2:SetOperation(c2026.eqop)   
	c:RegisterEffect(e2)
	--zhaohuan
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2026,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(aux.exccon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c2026.thtg)
	e3:SetOperation(c2026.thop)
	c:RegisterEffect(e3)
end
function c2026.filter(c)
	return c:IsSetCard(0x3903)
end
function c2026.filter1(c)
	return c:IsSetCard(0xa903) 
end
function c2026.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c2026.filter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c2026.filter,tp,LOCATION_EXTRA,0,1,nil) 
		and Duel.IsExistingTarget(c2026.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c2026.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c2026.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=1 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local g1=Duel.SelectMatchingCard(tp,c2026.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	local gc=g1:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,gc,tc) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		gc:RegisterEffect(e1)   
	end
end
function c2026.eqlimit(e,c)
	return e:GetOwner()==c
end
function c2026.thfilter(c)
	return c:IsSetCard(0xa903) and c:IsType(TYPE_MONSTER)
end
function c2026.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2026.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c2026.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c2026.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end