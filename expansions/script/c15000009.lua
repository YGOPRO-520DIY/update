local m=15000009
local cm=_G["c"..m]
cm.name="UB02·费洛美螂"
function cm.initial_effect(c)
	--flip  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000009,0))  
	e1:SetCategory(CATEGORY_DESTROY)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)  
	e1:SetCountLimit(1,15000009)  
	e1:SetTarget(c15000009.target)  
	e1:SetOperation(c15000009.operation)  
	c:RegisterEffect(e1)
	--Special Summon  
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(15000009,1))  
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)  
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)  
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)  
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)  
	e2:SetRange(LOCATION_GRAVE)  
	e2:SetCountLimit(1,15010009)  
	e2:SetCondition(c15000009.spcon)  
	e2:SetTarget(c15000009.sptg)  
	e2:SetOperation(c15000009.spop)  
	c:RegisterEffect(e2)
end
function c15000009.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chkc then return chkc:IsOnField() and chkc:IsType(TYPE_SPELL+TYPE_TRAP) end  
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)  
	local g=Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_ONFIELD,1,1,nil,TYPE_SPELL+TYPE_TRAP)  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)  
end  
function c15000009.operation(e,tp,eg,ep,ev,re,r,rp)  
	local tc=Duel.GetFirstTarget()  
	if tc:IsRelateToEffect(e) then  
		Duel.Destroy(tc,REASON_EFFECT)  
	end  
end
function c15000009.wfilter(c)  
	return c:IsCanBeEffectTarget() and c:IsCanTurnSet() and c:IsFaceup()
end  
function c15000009.spcon(e,tp,eg,ep,ev,re,r,rp)  
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil  
end  
function c15000009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0  
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE) and Duel.IsExistingMatchingCard(c15000009.wfilter,tp,0,LOCATION_MZONE+LOCATION_EXTRA,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION,e:GetHandler(),1,0,0)  
end  
function c15000009.spop(e,tp,eg,ep,ev,re,r,rp) 
	if Duel.GetMatchingGroupCount(c15000009.wfilter,tp,0,LOCATION_MZONE+LOCATION_EXTRA,nil)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local x=Duel.SelectMatchingCard(tp,c15000009.wfilter,tp,0,LOCATION_MZONE+LOCATION_EXTRA,1,1,nil)
	Duel.ChangePosition(x,POS_FACEDOWN_DEFENSE)
	local c=e:GetHandler()  
	if c:IsRelateToEffect(e) then  
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)  
		Duel.ConfirmCards(1-tp,c)
	end 
end