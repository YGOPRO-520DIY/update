--云上·黑崎智秋
function c81019021.initial_effect(c)
	c:SetSPSummonOnce(81019021)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2,c81019021.lcheck)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c81019021.atkval)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCountLimit(1,81019021)
	e2:SetCondition(c81019021.ccon)
	e2:SetOperation(c81019021.cop)
	c:RegisterEffect(e2)
end
function c81019021.lcheck(g,lc)
	return g:IsExists(c81019021.mzfilter,1,nil)
end
function c81019021.mzfilter(c)
	return c:GetCounter(0x1da0)>0 and c:IsLinkType(TYPE_MONSTER)
end
function c81019021.atkval(e,c)
	return Duel.GetCounter(0,1,1,0x1da0)*200
end
function c81019021.ccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c81019021.cop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,0,LOCATION_ONFIELD,nil,0x1da0,1)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1da0,1)
		tc=g:GetNext()
	end
end
