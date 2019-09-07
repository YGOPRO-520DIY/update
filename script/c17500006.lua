--水元素魔法 随机涡流
function c17500006.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17500006.con)
	e1:SetTarget(c17500006.target)
	e1:SetOperation(c17500006.activate)
	c:RegisterEffect(e1)
end
c17500006.setname="ElementalSpell"
c17500006.toss_coin=true
function c17500006.damfil(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup()
end
function c17500006.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c17500006.damfil,tp,LOCATION_MZONE,0,1,nil)
end
function c17500006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0,nil)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND,nil) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,0,1)
end
function c17500006.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==0 then 
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0,nil)
		if g:GetCount()==0 then return end
		local sg=g:RandomSelect(tp,1)
		Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
	else 
		local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0,nil)
		if g:GetCount()==0 then return end
		local sg=g:RandomSelect(1-tp,1)
		Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT) 
	end
end