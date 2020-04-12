--星月转夜 幻彩恋之迷灵
function c65050250.initial_effect(c)
	 --pendulum summon
	aux.EnablePendulumAttribute(c,true)
	--peffect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,65050250)
	e1:SetOperation(c65050250.pop)
	c:RegisterEffect(e1)
	--flover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COIN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050251)
	e2:SetCost(c65050250.flvcost)
	e2:SetTarget(c65050250.flvtg)
	e2:SetOperation(c65050250.flvop)
	c:RegisterEffect(e2)
	--wudixiaoguo
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65050250,0))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,65050252)
	e3:SetCost(c65050250.cost)
	e3:SetTarget(c65050250.tg)
	e3:SetOperation(c65050250.op)
	c:RegisterEffect(e3)
	--RaiseEvent
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEVEL_UP)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetOperation(c65050250.raop)
	c:RegisterEffect(e4)
end
c65050250.toss_coin=true
function c65050250.raop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsLocation(LOCATION_MZONE) then
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+65050216,e,0,tp,0,0)
	end
end
function c65050250.pop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_UPDATE_LEVEL)
		e3:SetValue(2)
		e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e3:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
		e3:SetTarget(c65050250.poptg)
		e3:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(3)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		c:RegisterEffect(e2)
end
function c65050250.poptg(e,c)
	return c:IsSetCard(0x9da9) or c:IsSetCard(0x5da9)
end

function c65050250.flvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoHand(g,1-tp,REASON_COST)
end
function c65050250.flvfil(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp) and c:IsFaceup() and ((Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and c:IsLocation(LOCATION_EXTRA)) or (Duel.GetMZoneCount(tp)>0 and c:IsLocation(LOCATION_REMOVED)))
end
function c65050250.flvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050250.flvfil,tp,0,LOCATION_REMOVED+LOCATION_EXTRA,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetChainLimit(aux.FALSE)
end
function c65050250.flvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=Duel.TossCoin(tp,1)
	if res==1 and Duel.IsExistingMatchingCard(c65050250.flvfil,tp,0,LOCATION_REMOVED+LOCATION_EXTRA,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 then
	   local g=Duel.SelectMatchingCard(tp,c65050250.flvfil,tp,0,LOCATION_REMOVED+LOCATION_EXTRA,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,fale,false,POS_FACEUP)
	end
end

function c65050250.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c65050250.filter(c)
	return (c:IsSetCard(0x5da9) or c:IsSetCard(0x9da9)) and c:IsAbleToHand()
end
function c65050250.tgfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c65050250.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c65050250.tgfilter(chkc) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c65050250.tgfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c65050250.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SelectTarget(tp,c65050250.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65050250.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.SelectMatchingCard(tp,c65050250.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoHand(g,tp,REASON_EFFECT)~=0 then
		Duel.ConfirmCards(1-tp,g)
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local lv=g:GetFirst():GetLevel()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(lv)
		tc:RegisterEffect(e1)
		end
	end
end