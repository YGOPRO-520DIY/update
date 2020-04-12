--单向基因组
function c65040049.initial_effect(c)
	--link summon
	c:SetSPSummonOnce(65040049)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_LINK),1,1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65040049,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c65040049.descon)
	e3:SetTarget(c65040049.destg)
	e3:SetOperation(c65040049.desop)
	c:RegisterEffect(e3)
end
function c65040049.cfilter(c,ec)
	local g=c:GetMaterial()
	return ec:GetLinkedGroup():IsContains(c) and c:IsType(TYPE_LINK) and c:IsSummonType(SUMMON_TYPE_LINK) and g:GetCount()>0 and g:IsExists(Card.IsLinkCode,1,nil,c:GetCode())
end
function c65040049.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65040049.cfilter,1,nil,e:GetHandler())
end
function c65040049.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c65040049.desop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end