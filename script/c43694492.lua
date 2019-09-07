--雪暴猎鹰-水月
function c43694492.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c43694492.matfilter,8,2)
	c:EnableReviveLimit()
	--code
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(43694481)
	c:RegisterEffect(e1)
	 --self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c43694492.sdcon)
	c:RegisterEffect(e2)
	--todeck
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_RELEASE)
	e3:SetTarget(c43694492.tdtg)
	e3:SetOperation(c43694492.tdop)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(43694492,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c43694492.cost)
	e4:SetOperation(c43694492.operation)
	c:RegisterEffect(e4)
	 --search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(43694492,1))
	e5:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_PREDRAW)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c43694492.drcon)
	e5:SetCost(c43694492.drcost)
	e5:SetTarget(c43694492.drtg)
	e5:SetOperation(c43694492.drop)
	c:RegisterEffect(e5)
end
function c43694492.drcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.GetDrawCount(tp)>0
end
function c43694492.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local costg=Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,nil)
	local costnum=costg:GetCount()
	if chk==0 then return costnum>0 and costnum==Duel.GetFieldGroupCount(tp,LOCATION_HAND,0) and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.SendtoGrave(costg,REASON_COST)
end
function c43694492.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
	local sg=Duel.GetFieldGroup(tp,LOCATION_REMOVED,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,tp,sg:GetCount())
end
function c43694492.drop(e,tp,eg,ep,ev,re,r,rp)
	_replace_count=_replace_count+1
	if _replace_count>_replace_max then return end
	local sg=Duel.GetFieldGroup(tp,LOCATION_REMOVED,0)
	if Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)~=0 then
		Duel.Draw(tp,sg:GetCount(),REASON_EFFECT)
	end
end

function c43694492.matfilter(c)
	return c:IsSetCard(0x436) or c:IsCode(43694481)
end
function c43694492.sdcon(e)
	return not (e:GetHandler():IsAttribute(ATTRIBUTE_WATER) and e:GetHandler():IsRace(RACE_WINDBEAST))
end
function c43694492.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c43694492.tdop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end

function c43694492.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c43694492.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
end