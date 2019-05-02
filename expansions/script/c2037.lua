--Fgo/Assassin 侏儒哈桑
local m=2037
local cm=_G["c"..m]
if not RealSclFgoVal then
	RealSclFgoVal=RealSclFgoVal or {}
	rsfv=RealSclFgoVal
	rsfv.codelist={[2049]=2037,[2050]=2038,[2051]=2039,
				[2017]=2012,[2052]=2041,[2053]=2042}
function rsfv.SummonSucessFun(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(rsfv.tgtg)
	e1:SetOperation(rsfv.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function rsfv.tgfilter(c)
	return c:IsSetCard(0x202) and c:IsAbleToGrave()
end
function rsfv.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(rsfv.tgfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function rsfv.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,rsfv.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function rsfv.GraveRemovefun(c)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk) 
		if chk==0 then return e:GetHandler():IsAbleToRemove() end
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
		end)
	e1:SetOperation(function(e) 
		if e:GetHandler():IsRelateToEffect(e) then Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT) end
		end)
	c:RegisterEffect(e1)
end
function rsfv.EquipFun(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_REMOVE)
	e1:SetTarget(rsfv.eqtg)
	e1:SetOperation(rsfv.eqop)
	c:RegisterEffect(e1)
end
function rsfv.eqfilter(c,code)
	return c:IsFaceup() and (c:IsCode(code) or c:IsHasEffect(2041))
end
function rsfv.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local code=rsfv.codelist[c:GetOriginalCode()]
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and rsfv.eqfilter(chkc,code) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(rsfv.eqfilter,tp,LOCATION_MZONE,0,1,nil,code) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,rsfv.eqfilter,tp,LOCATION_MZONE,0,1,1,nil,code)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,c,1,0,0)
end
function rsfv.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(rsfv.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetReset(RESET_EVENT+RESETS_REDIRECT)
	e2:SetValue(LOCATION_DECK)
	c:RegisterEffect(e2,true)
	c:RegisterFlagEffect(m,RESET_EVENT+RESETS_STANDARD,0,1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetLabelObject(c)
	e3:SetCondition(rsfv.tdcon)
	e3:SetOperation(rsfv.tdop)
	Duel.RegisterEffect(e3,tp)
end
function rsfv.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function rsfv.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(m)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end
function rsfv.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
end

------------------------
end
------------------------
if cm then
function cm.initial_effect(c)
	rsfv.SummonSucessFun(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,2))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)
	--dice2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,3))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE+CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,m)
	e2:SetCondition(function(e,tp) return e:GetHandler():GetEquipGroup():FilterCount(cm.cfilter,nil)>0 end)
	e2:SetOperation(cm.operation2)
	c:RegisterEffect(e2)
end
function cm.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x202)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	if d==3 or d==4 then
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	elseif d==5 then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif d>=6 then
		Duel.Damage(tp,500,REASON_EFFECT)
	end
end
function cm.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.TossDice(tp,1)
	if d>=1 and d<=4 then
		if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	elseif d==5 then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif d>=6 then
		Duel.Damage(tp,500,REASON_EFFECT)
	end
end

end
