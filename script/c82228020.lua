
function c82228020.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c82228020.ffilter,2,true)
	aux.AddContactFusionProcedure(c,IsReleasable,LOCATION_MZONE,0,Duel.Release,REASON_COST+REASON_FUSION+REASON_MATERIAL)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c82228020.splimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(82228020,0))  
	e2:SetCategory(CATEGORY_ATKCHANGE)  
	e2:SetType(EFFECT_TYPE_IGNITION)  
	e2:SetCountLimit(1,82228020)  
	e2:SetRange(LOCATION_MZONE)  
	e2:SetCost(c82228020.atkcost)   
	e2:SetOperation(c82228020.atkop)  
	c:RegisterEffect(e2)  
	local e3=Effect.CreateEffect(c)  
	e3:SetCategory(CATEGORY_TOHAND)  
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)  
	e3:SetCode(EVENT_DESTROYED)  
	e3:SetCountLimit(1,82228020)  
	e3:SetCondition(c82228020.thcon)  
	e3:SetTarget(c82228020.target)  
	e3:SetOperation(c82228020.thop)  
	c:RegisterEffect(e3)  
end

function c82228020.ffilter(c)
	return c:IsRace(RACE_MACHINE)
end

function c82228020.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
 
function c82228020.atkfilter(c)  
	return c:IsRace(RACE_MACHINE) and c:IsAbleToGraveAsCost()  
end  

function c82228020.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then return 
	Duel.IsExistingMatchingCard(c82228020.atkfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.DiscardHand(tp,nil,1,1,REASON_COST,nil)
	local g=Duel.SelectMatchingCard(tp,c82228020.atkfilter,tp,LOCATION_DECK,0,1,2,nil)
	local ct=Duel.SendtoGrave(g,REASON_COST)  
	c82228020[0]=ct
end  

function c82228020.atkop(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler() 
	local ct=c82228020[0]
	if c:IsFaceup() and c:IsRelateToEffect(e) then  
		local e1=Effect.CreateEffect(c)  
		e1:SetType(EFFECT_TYPE_SINGLE)  
		e1:SetCode(EFFECT_UPDATE_ATTACK)  
		e1:SetValue(ct*500)  
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)  
		c:RegisterEffect(e1)  
	end  
end  

function c82228020.thcon(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	return (c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp))
end  

function c82228020.thfilter(c,e,tp)  
	return c:IsCode(70095154)
end  
 
function c82228020.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c82228020.thfilter(chkc,e,tp) end  
	if chk==0 then return Duel.IsExistingTarget(c82228020.thfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)  
	local g=Duel.SelectTarget(tp,c82228020.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)  
end 
  
function c82228020.thop(e,tp,eg,ep,ev,re,r,rp)  
	local tc=Duel.GetFirstTarget()  
	if tc and tc:IsRelateToEffect(e) then  
		Duel.SendtoHand(tc,nil,REASON_EFFECT)  
	end  
end  


