local m=13520216
local tg={13520200,13520220}
local cm=_G["c"..m]
cm.name="花骑士 鞘蕊"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,m,LOCATION_MZONE)
	--Fusion Material
	aux.AddFusionProcFunRep(c,cm.ffilter,2,true)
	--Lock SZone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(cm.lockcon)
	e1:SetTarget(cm.locktg)
	e1:SetOperation(cm.lockop)
	c:RegisterEffect(e1)
end
function cm.flower(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Fusion Material
function cm.ffilter(c,fc,sub,mg,sg)
	return c:IsRace(RACE_PLANT) and (not sg or not sg:IsExists(Card.IsFusionAttribute,1,c,c:GetFusionAttribute()))
end
--Lock SZone
function cm.lockfilter(c,tp)
	return c:IsControler(tp) and not c:IsReason(REASON_DRAW)
end
function cm.lockcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(cm.lockfilter,1,nil,1-tp)
end
function cm.locktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_SZONE,PLAYER_NONE,0)>0 end
end
function cm.lockop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE,PLAYER_NONE,0)==0 then return end
	local dis=Duel.SelectDisableField(tp,1,0,LOCATION_SZONE,0xe000e0)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetLabel(dis)
	e1:SetOperation(cm.disop)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	Duel.RegisterEffect(e1,tp)
end
function cm.disop(e,tp)
	return e:GetLabel()
end