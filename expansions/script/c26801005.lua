--死亡之力·和泉爱依
function c26801005.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,26801005)
	e1:SetCondition(c26801005.tdcon)
	e1:SetTarget(c26801005.tdtg)
	e1:SetOperation(c26801005.tdop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,26801905)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c26801005.thtg)
	e2:SetOperation(c26801005.thop)
	c:RegisterEffect(e2)
	--reset atk
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c26801005.atkcon2)
	e3:SetOperation(c26801005.atkop2)
	c:RegisterEffect(e3)
end
function c26801005.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c26801005.filter(c)
	return c:IsFacedown() and c:IsAbleToDeck()
end
function c26801005.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26801005.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c26801005.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetChainLimit(c26801005.chlimit)
end
function c26801005.chlimit(e,ep,tp)
	return tp==ep
end
function c26801005.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c26801005.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	end
end
function c26801005.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=a:GetBattleTarget()
	if a:IsControler(tp) then a,d=d,a end
	local wc=a:GetBaseAttack()/2
	return a and a:IsControler(1-tp) and not a:IsAttack(wc)
end
function c26801005.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(tp) then tc=tc:GetBattleTarget() end
	if tc and tc:IsFaceup() and not tc:IsAttack(tc:GetBaseAttack()) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetBaseAttack()/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc:RegisterEffect(e1)
	end
end
function c26801005.thfilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_TUNER) and c:IsAbleToHand()
end
function c26801005.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26801005.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c26801005.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c26801005.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
