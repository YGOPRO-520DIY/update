--折返的病毒 佩姬
function c17510028.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c17510028.matfilter,2,99,c17510028.lcheck)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c17510028.efilter)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TODECK+CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCountLimit(1,17510028)
	e4:SetCondition(c17510028.descon)
	e4:SetTarget(c17510028.destg)
	e4:SetOperation(c17510028.desop)
	c:RegisterEffect(e4)
	--win
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetCode(EVENT_ADJUST)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c17510028.winop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e6)
end
c17510028.setname="FloWBacK"
function c17510028.matfilter(c)
	return c.setname=="FloWBacK"
end
function c17510028.winop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_GHOSTRICK_SPOILEDANGEL=0xfb
	if e:GetHandler():GetAttack()==4500 then
		Duel.Win(tp,WIN_REASON_GHOSTRICK_SPOILEDANGEL)
	end
end
function c17510028.lcheck(g)
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_SYNCHRO) and g:IsExists(Card.IsLinkType,1,nil,TYPE_LINK)
end
function c17510028.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c17510028.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	local bc=c:GetBattleTarget()
	return bc and (bc:IsAttackBelow(atk) or bc:IsDefenseBelow(atk))
end
function c17510028.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c17510028.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() and Duel.SendtoDeck(bc,nil,2,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetValue(1000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)
	end
end