--宝具 六道五轮・俱利伽罗天象
function c22080210.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,5,c22080210.ovfilter,aux.Stringid(22080210,0),3,c22080210.xyzop)
	c:EnableReviveLimit()
	--WIND
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_IMMUNE_EFFECT)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCondition(c22080210.descon)
	e0:SetValue(c22080210.efilter)
	c:RegisterEffect(e0)
	--EARTH
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c22080210.descon1)
	e1:SetValue(c22080210.efilter1)
	c:RegisterEffect(e1)
	--FIRE
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetCondition(c22080210.descon2)
	e2:SetValue(c22080210.raval)
	c:RegisterEffect(e2)
	--WARTER
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	e3:SetCondition(c22080210.descon3)
	c:RegisterEffect(e3)
	--LIGHT
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetCondition(c22080210.descon4)
	e4:SetValue(5000)
	c:RegisterEffect(e4)
	--LIGHT
	--disable and atk down
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_DISABLE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetCondition(c22080210.adcon)
	e5:SetTarget(c22080210.adtg)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e6)
	--pendulum set
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCondition(c22080210.discon)
	e7:SetOperation(c22080210.rpop)
	c:RegisterEffect(e7)
end
function c22080210.cfilter(c)
	return c:IsSetCard(0xffd) and c:IsDiscardable()
end
function c22080210.ovfilter(c)
	return c:IsFaceup() and c:IsCode(22000440)
end
function c22080210.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22080210.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c22080210.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c22080210.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c22080210.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WIND)
end
function c22080210.efilter1(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c22080210.descon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_EARTH)
end
function c22080210.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_FIRE)
end
function c22080210.raval(e,c)
	local oc=e:GetHandler():GetOverlayCount()
	return math.max(0,oc-1)
end
function c22080210.descon3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WATER)
end
function c22080210.descon4(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_LIGHT)
end
function c22080210.adcon(e)
	local c=e:GetHandler()
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_LIGHT) and Duel.GetAttacker()==c and c:GetBattleTarget()
		and (Duel.GetCurrentPhase()==PHASE_DAMAGE or Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL)
end
function c22080210.adtg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c22080210.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c22080210.rpfilter(c,e,tp)
	return c:IsCode(22000440) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22080210.rpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SendtoGrave(c,REASON_EFFECT) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
			local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c22080210.rpfilter),tp,LOCATION_GRAVE,0,nil,e,tp)
			if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(22080210,1)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sg=g:Select(tp,1,1,nil)
				Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			end
	end
end