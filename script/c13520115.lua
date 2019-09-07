local m=13520115
local cm=_G["c"..m]
cm.name="怨冥巫 小丑"
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
	--Set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_RELEASE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetTarget(cm.settg)
	e3:SetOperation(cm.setop)
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
--Set
function cm.setfilter(c,tp)
	return c:IsType(TYPE_SPELL) and c:IsSSetable(true)
		and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
end
function cm.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.setfilter,tp,0,LOCATION_GRAVE,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,1-tp,LOCATION_GRAVE)
end
function cm.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(cm.setfilter),tp,0,LOCATION_GRAVE,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
		Duel.ConfirmCards(1-tp,g)
	end
end