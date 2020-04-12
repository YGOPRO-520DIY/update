--甜美彩恋 甜腻少女
function c65050261.initial_effect(c)
	c:SetUniqueOnField(1,0,65050261)
	 --link summon
	aux.AddLinkProcedure(c,nil,2,99,c65050261.lcheck)
	c:EnableReviveLimit()
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c65050261.con1)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e11:SetRange(LOCATION_MZONE)
	e11:SetTargetRange(LOCATION_MZONE,0)
	e11:SetTarget(c65050261.eftg)
	e11:SetLabelObject(e1)
	c:RegisterEffect(e11)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c65050261.con3)
	e2:SetTarget(c65050261.target)
	e2:SetOperation(c65050261.activate)
	local e12=e11:Clone()
	e12:SetLabelObject(e2)
	c:RegisterEffect(e12)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCondition(c65050261.con2)
	e3:SetValue(200)
	local e13=e11:Clone()
	e13:SetLabelObject(e3)
	c:RegisterEffect(e13)
end
function c65050261.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9da9)
end
function c65050261.eftg(e,c)
	local seq=c:GetSequence()
	return c:IsType(TYPE_EFFECT) and c:IsSetCard(0x9da9)
end
function c65050261.contfil(c,tp)
	return c:GetOwner()~=tp
end
function c65050261.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c65050261.contfil,tp,LOCATION_MZONE,0,nil,tp)>=1
end
function c65050261.con2(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c65050261.contfil,tp,LOCATION_MZONE,0,nil,tp)>=2
end
function c65050261.con3(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(c65050261.contfil,tp,LOCATION_MZONE,0,nil,tp)>=3
end
function c65050261.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ctt=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local ct=ctt-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c65050261.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ctt=Duel.GetFieldGroupCount(p,0,LOCATION_HAND)
	local ct=ctt-Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if ct>0 then
		Duel.Draw(p,ct,REASON_EFFECT)
	end
end