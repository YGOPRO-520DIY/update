--恋风·高垣枫
function c81007004.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_XYZ),1,1)
	c:EnableReviveLimit()
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--battle
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(81007004,0))
	e4:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLED)
	e4:SetCondition(c81007004.xyzcon)
	e4:SetOperation(c81007004.xyzop)
	c:RegisterEffect(e4)
end
function c81007004.xyzcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	e:SetLabelObject(tc)
	return tc and tc:IsType(TYPE_MONSTER) and tc:IsReason(REASON_BATTLE) and not tc:IsType(TYPE_TOKEN)
end
function c81007004.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsFaceup() and c:IsType(TYPE_XYZ) then
		Duel.Overlay(c,tc)
	end
end
