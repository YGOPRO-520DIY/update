--Fgo/Assassin 百貌哈桑
if not pcall(function() require("expansions/script/c2037") end) then require("script/c2037") end
local m=2039
local cm=_G["c"..m]
function cm.initial_effect(c)
	rsfv.SummonSucessFun(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,m)
	e1:SetOperation(cm.atkop)
	c:RegisterEffect(e1)
	--tk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,m1)
	e2:SetCondition(function(e) return e:GetHandler():IsAttackAbove(500) and not e:GetHandler():IsHasEffect(EFFECT_REVERSE_UPDATE) and e:GetHandler():GetEquipGroup():FilterCount(cm.cfilter,nil)>0 end)
	e2:SetTarget(cm.tktg)
	e2:SetOperation(cm.tkop)
	c:RegisterEffect(e2)
end
function cm.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x202)
end
function cm.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,2054,0,0x4011,0,0,2,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function cm.tkop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,2054,0,0x4011,0,0,2,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,2054)
	if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function cm.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end

