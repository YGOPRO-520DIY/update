local m=13520116
local cm=_G["c"..m]
cm.name="怨冥蚀 墨龙"
function cm.initial_effect(c)
	--Summon With Hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetTarget(cm.htritg)
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(cm.drcon)
	e2:SetOperation(cm.drop)
	c:RegisterEffect(e2)
	--Remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_RELEASE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTarget(cm.rmtg)
	e3:SetOperation(cm.rmop)
	c:RegisterEffect(e3)
end
--Summon With Hand
function cm.htritg(e,c)
	return c~=e:GetHandler() and c:IsAttribute(ATTRIBUTE_DARK)
end
--Draw
function cm.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function cm.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	Duel.Draw(tp,1,REASON_EFFECT)
end
--Remove
function cm.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function cm.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(1-tp,3)
	if chk==0 then return g:IsExists(Card.IsAbleToRemove,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function cm.rmop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetDecktopGroup(p,d)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
	end
end