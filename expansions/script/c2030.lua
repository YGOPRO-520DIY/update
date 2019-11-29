--许愿的圣杯
function c2030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2030,1))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--e1:SetCountLimit(1,2030)
	e1:SetCondition(c2030.condition)
	e1:SetTarget(c2030.target)
	e1:SetOperation(c2030.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(2030,2))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetCondition(c2030.condition2)
	e2:SetTarget(c2030.target2)
	e2:SetOperation(c2030.activate2)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetDescription(aux.Stringid(2030,3))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetCondition(c2030.condition3)
	e3:SetTarget(c2030.target3)
	e3:SetOperation(c2030.activate3)
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetDescription(aux.Stringid(2030,4))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetCondition(c2030.condition4)
	e4:SetTarget(c2030.target4)
	e4:SetOperation(c2030.activate4)
	c:RegisterEffect(e4)	
end
function c2030.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3903)
end
function c2030.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2030.cfilter,tp,LOCATION_SZONE,0,1,nil)
end
function c2030.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2030.cfilter,tp,LOCATION_SZONE,0,2,nil)
end
function c2030.condition3(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2030.cfilter,tp,LOCATION_SZONE,0,3,nil)
end
function c2030.condition4(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2030.cfilter,tp,LOCATION_SZONE,0,4,nil)
end
function c2030.rmfilter(c)
	return c:IsSetCard(0x3903)	 
end
function c2030.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2030.rmfilter,tp,LOCATION_EXTRA,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c2030.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c2030.rmfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	local lv=tc:GetLevel()
	if tc:GetLevel()>0 then
		Duel.Damage(1-tp,lv*200,REASON_EFFECT)
	end
end
function c2030.filter(c)
	return c:IsDestructable()
end
function c2030.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2030.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c2030.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c2030.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c2030.filter,tp,0,LOCATION_ONFIELD,1,2,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c2030.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c2030.activate3(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c2030.target4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c2030.activate4(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end


