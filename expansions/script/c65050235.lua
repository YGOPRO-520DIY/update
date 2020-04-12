--沁恋甜心 花彩恋之玉兰
function c65050235.initial_effect(c)
	 --pendulum summon
	aux.EnablePendulumAttribute(c,true)
	--peffect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,65050235)
	e1:SetCost(c65050235.pcost)
	e1:SetTarget(c65050235.ptg)
	e1:SetOperation(c65050235.pop)
	c:RegisterEffect(e1)
	--flover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COIN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050236)
	e2:SetCost(c65050235.flvcost)
	e2:SetTarget(c65050235.flvtg)
	e2:SetOperation(c65050235.flvop)
	c:RegisterEffect(e2)
	--wudixiaoguo
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCountLimit(1,65050237)
	e3:SetTarget(c65050235.tg)
	e3:SetOperation(c65050235.op)
	c:RegisterEffect(e3)
end
c65050235.toss_coin=true
function c65050235.pcostfil(c,tp)
	return (c:IsSetCard(0x9da9) or c:IsSetCard(0xcda2)) and c:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(c65050235.ptgfil,tp,LOCATION_DECK,0,1,nil,c:GetCode()) and not c:IsPublic()
end
function c65050235.ptgfil(c,code)
	return c:IsCode(code) and c:IsAbleToGrave()
end
function c65050235.pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050235.pcostfil,tp,LOCATION_HAND,0,1,nil,tp) end
	local g=Duel.SelectMatchingCard(tp,c65050235.pcostfil,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabel(g:GetFirst():GetCode())
end
function c65050235.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c65050235.pop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local code=e:GetLabel()
	local g=Duel.SelectMatchingCard(tp,c65050235.ptgfil,tp,LOCATION_DECK,0,1,1,nil,code)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
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

function c65050235.flvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoHand(g,1-tp,REASON_COST)
end
function c65050235.flvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetChainLimit(aux.FALSE)
end
function c65050235.flvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=Duel.TossCoin(tp,1)
	if res==1 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 then
	   local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		Duel.ConfirmCards(tp,g)
		local sg=g:FilterSelect(tp,Card.IsCanBeSpecialSummoned,1,1,nil,e,0,tp,false,false,POS_FACEUP,tp)
		if sg:GetCount()>0 and Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)~=0 then
			Duel.Draw(1-tp,1,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
	end
end

function c65050235.filter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x9da9) or c:IsSetCard(0xcda2)) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c65050235.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050235.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c65050235.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c65050235.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local b1=tc:IsAbleToHand()
		local b2=tc:IsAbleToGrave()
		if b1 and b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65050235,0),aux.Stringid(65050235,1))
		elseif b1 then
			op=Duel.SelectOption(tp,aux.Stringid(65050235,0))
		elseif b2 then
			op=Duel.SelectOption(tp,aux.Stringid(65050235,1))+1
		end
		if op==0 then
			Duel.SendtoHand(tc,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		elseif op==1 then
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
end