--奇妙仙灵 翼彩恋之片月
function c65050247.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,true)
	--peffect
	 local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,65050247)
	e1:SetTarget(c65050247.ptg)
	e1:SetOperation(c65050247.pop)
	c:RegisterEffect(e1)
	--flover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COIN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050239)
	e2:SetCost(c65050247.flvcost)
	e2:SetTarget(c65050247.flvtg)
	e2:SetOperation(c65050247.flvop)
	c:RegisterEffect(e2)
	--wudixiaoguo
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_DECK)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,65050240)
	e3:SetCondition(c65050247.con)
	e3:SetTarget(c65050247.tg)
	e3:SetOperation(c65050247.op)
	c:RegisterEffect(e3)
end
c65050247.toss_coin=true
function c65050247.ptgfil(c,e,tp)
	return (c:IsSetCard(0x9da9) or c:IsSetCard(0x9da8)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c65050247.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050247.ptgfil,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c65050247.pop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.SelectMatchingCard(tp,c65050247.ptgfil,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		 local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(5)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		c:RegisterEffect(e2)
	end
end
function c65050247.flvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoHand(g,1-tp,REASON_COST)
end
function c65050247.flvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)>=3 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetChainLimit(aux.FALSE)
end
function c65050247.flvfil(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and c:IsFacedown()
end
function c65050247.flvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=Duel.TossCoin(tp,1)
	if res==1 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)>=3 then
	   local g=Duel.GetMatchingGroup(c65050247.flvfil,1-tp,LOCATION_EXTRA,0,nil,e,tp)
		if g:GetClassCount(Card.GetCode)>=3 then
			local sg=g:SelectSubGroup(1-tp,aux.dncheck,false,3,3)
			if #sg>0 then
				Duel.ConfirmCards(tp,sg)
				local tc=sg:Select(tp,1,1,nil):GetFirst()
				if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
						 local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
				local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK)
		e3:SetValue(0)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_SET_DEFENSE)
		tc:RegisterEffect(e4)
					local e5=e1:Clone()
					e5:SetCode(EFFECT_CANNOT_TRIGGER)
					tc:RegisterEffect(e5)
				end
				Duel.SpecialSummonComplete()
			end
		end
	end
end

function c65050247.confil(c)
	return (c:IsSetCard(0x9da9) or c:IsSetCard(0x9da8)) and c:IsFaceup()
end
function c65050247.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c65050247.confil,tp,LOCATION_MZONE,0,1,nil) and e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c65050247.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGrave() and Duel.IsPlayerCanDraw(tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,tp,1)
end
function c65050247.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoGrave(c,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end

