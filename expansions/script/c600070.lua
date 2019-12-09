--铠恶龙-电子暗魔龙
function c600070.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,45078193,600070,true,true)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(600070,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_GRAVE+LOCATION_MZONE)
	e1:SetCountLimit(1,600070)
	e1:SetTarget(c600070.eqtg)
	e1:SetOperation(c600070.eqop)
	c:RegisterEffect(e1)   
	--send to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600070,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,6000070)
	e2:SetCondition(c600070.gycon)
	e2:SetTarget(c600070.gytg)
	e2:SetOperation(c600070.gyop)
	c:RegisterEffect(e2)
	--search monster
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600070,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,5250035)
	e3:SetCondition(c600070.con)
	e3:SetCost(c600070.cost)
	e3:SetTarget(c600070.tg)
	e3:SetOperation(c600070.op)
	c:RegisterEffect(e3)
end
function c600070.eqfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4093) and c:IsRace(RACE_MACHINE)
end
function c600070.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c600070.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c600070.eqfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c600070.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c600070.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) or not c:CheckUniqueOnField(tp) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c600070.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(2000)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c600070.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c600070.tgfilter(c)
	return c:IsAbleToGrave()
end
function c600070.gycon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ec and (ec==Duel.GetAttacker() or ec==Duel.GetAttackTarget())
end
function c600070.gytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c600070.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
end
function c600070.gyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c600070.tgfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c600070.cnfilter(c)
	return c:GetSequence()>=5
end
function c600070.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetPreviousLocation()==LOCATION_SZONE and not c:IsReason(REASON_LOST_TARGET) and not Duel.IsExistingMatchingCard(c600070.cnfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c600070.costfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c600070.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c600070.costfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c600070.costfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c600070.filter(c,e,tp)
	return c:IsRace(RACE_MACHINE) and c:IsSetCard(0x4093) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,true,true)
end
function c600070.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c600070.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c600070.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600070.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,SUMMON_TYPE_FUSION,tp,tp,true,true,POS_FACEUP)
	end
end
