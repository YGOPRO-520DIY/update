--真爆裂疾风弹
function c44499909.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44499909)
	e1:SetCost(c44499909.cost)
	e1:SetTarget(c44499909.target)
	e1:SetOperation(c44499909.activate)
	c:RegisterEffect(e1)
    --set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44499909,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,44499919)
	e2:SetCost(c44499909.scost)
	e2:SetTarget(c44499909.settg)
	e2:SetOperation(c44499909.setop)
	c:RegisterEffect(e2)
end
c44499909.card_code_list={89631139}
function c44499909.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44499909.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c44499909.cfilter,tp,LOCATION_MZONE,0,nil)
	local sc=g:GetFirst()	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	sc:RegisterEffect(e1)

end
function c44499909.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xdd) and c:GetAttack()>0
end
function c44499909.filter(c)
	return c:IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
end
function c44499909.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c44499909.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44499909.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c44499909.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	if Duel.IsExistingMatchingCard(c44499909.filter1,tp,LOCATION_ONFIELD,0,1,nil) then
	Duel.SetChainLimit(c44499909.chlimit)
	end
end
function c44499909.filter1(c)
	return c:IsCode(89631139) and c:IsFaceup()
end
function c44499909.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c44499909.chlimit(e,lp,tp)
	return lp==tp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--set
function c44499909.cosfilter(c)
	return c:IsRace(RACE_DRAGON)
	and c:GetAttack()>0
	and c:IsType(TYPE_MONSTER) and c:IsReleasable()
end
function c44499909.scost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c44499909.costfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c44499909.costfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c44499909.scost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c44499909.cosfilter,tp,LOCATION_MZONE,0,nil,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.Release(g,REASON_COST)
end
function c44499909.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSSetable() end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c44499909.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsSSetable() then
		Duel.SSet(tp,c)
		Duel.ConfirmCards(1-tp,c)
	end
end



