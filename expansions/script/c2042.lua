--Fgo/Assassin 初代哈桑
if not pcall(function() require("expansions/script/c2037") end) then require("script/c2037") end
local m=2042
local cm=_G["c"..m]
function cm.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,3)
	c:EnableReviveLimit()   
	rsfv.SummonSucessFun(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetCondition(function(e) return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE end)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(cm.aclimit)
	c:RegisterEffect(e1)
	--ss
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(cm.xyzcon)
	e2:SetOperation(cm.xyzop)
	e2:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e2)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--cannot be target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	e5:SetCondition(function(e) return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() and e:GetHandler():GetOverlayGroup():IsExists(Card.IsSetCard,1,nil,0x299) end)
	c:RegisterEffect(e5)
end
function cm.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function cm.xfilter(c,tp,xyzc)
	return c:IsSetCard(0x299) and c:IsAbleToGraveAsCost() and c:IsFaceup() and Duel.IsExistingMatchingCard(cm.xfilter2,tp,LOCATION_MZONE,0,1,c,tp,xyzc)
end
function cm.xfilter2(c,tp,xyzc)
	return c:IsSetCard(0x299) and c:IsFaceup() and c:IsCanBeXyzMaterial(xyzc) and Duel.GetLocationCountFromEx(tp,tp,c)>0 and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x299)
end
function cm.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(cm.xfilter,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function cm.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=Duel.SelectMatchingCard(tp,cm.xfilter,tp,LOCATION_MZONE,0,1,1,nil,tp,c):GetFirst()
	Duel.SendtoGrave(tc,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)   
	local mg=Duel.SelectMatchingCard(tp,cm.xfilter2,tp,LOCATION_MZONE,0,1,1,nil,tp,c)
	c:SetMaterial(mg)
	Duel.Overlay(c,mg)
end