--神装-妄想毒身
local m=2050
local cm=_G["c"..m]
function cm.initial_effect(c)
	rsfv.GraveRemovefun(c)
	rsfv.EquipFun(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(cm.destg)
	e2:SetOperation(cm.desop)
	c:RegisterEffect(e2)
end
function cm.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if chk==0 then return ec end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,LOCATION_ONFIELD)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	local b=0
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local ec=c:GetEquipTarget()
		if not ec then return end
		local g=ec:GetColumnGroup():Filter(Card.IsControler,nil,1-tp)
		if #g>0 then
			b=Duel.Destroy(g,REASON_EFFECT)
		end
	end
	if b==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if #dg>0 then Duel.Destroy(dg,REASON_EFFECT) end
	elseif b==1 then
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local lp=Duel.GetLP(1-tp)
		local atk=c:GetAttack()
		if lp<=atk then Duel.Damage(1-tp,atk,REASON_EFFECT) end
	end
end