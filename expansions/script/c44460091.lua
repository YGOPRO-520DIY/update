--古夕幻历-龙生烟玉
function c44460091.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44460091.target)
	e1:SetOperation(c44460091.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c44460091.eqlimit)
	c:RegisterEffect(e2)
	--rset
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44460091,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c44460091.rscon)
	e3:SetTarget(c44460091.rstg)
	e3:SetOperation(c44460091.rsop)
	c:RegisterEffect(e3)
	--set
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(44460091,1))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCountLimit(1,44460091)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetTarget(c44460091.stg)
	e6:SetOperation(c44460091.sop)
	c:RegisterEffect(e6)
end
function c44460091.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function c44460091.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44460091.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44460091.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c44460091.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44460091.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c44460091.eqlimit(e,c)
	return c:IsType(TYPE_NORMAL)
end
--rset
function c44460091.rscon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local c=e:GetHandler():GetEquipTarget()
	return d and (a==c or d==c)
end
function c44460091.rstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	local tc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,nil,tc,1,0,0)
end
function c44460091.rsop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	local c=e:GetHandler()
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end
--set
function c44460091.setfilter(c)
	return (c:IsSetCard(0x679) or c:IsSetCard(0x680)) and not c:IsForbidden() and not c:IsCode(44460091)
end
function c44460091.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460091.setfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44460091.sop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44460091.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_TRAP)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end