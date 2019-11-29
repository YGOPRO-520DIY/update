local m=15000007
local cm=_G["c"..m]
cm.name="人间异物日食·奈克洛兹玛"
function cm.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,15000005,c15000007.efilter,1,true,true)
	--to grave  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000007,0))  
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetRange(LOCATION_MZONE)  
	e1:SetCountLimit(1,15000007)  
	e1:SetValue(c15000007.wfilter)
	e1:SetTarget(c15000007.sgtg)  
	e1:SetOperation(c15000007.sgop)  
	c:RegisterEffect(e1)
	--negate 
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(15000007,1))  
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)  
	e2:SetType(EFFECT_TYPE_QUICK_O)  
	e2:SetRange(LOCATION_MZONE)  
	e2:SetCountLimit(1,15010007)  
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)  
	e2:SetCode(EVENT_CHAINING)  
	e2:SetCondition(c15000007.discon)  
	e2:SetTarget(c15000007.distg)  
	e2:SetOperation(c15000007.disop)  
	c:RegisterEffect(e2) 
end
function c15000007.efilter(e,c)  
	local tp=e:GetControler()  
	return c:IsControler(tp) and c:IsCanBeFusionMaterial() and c:IsType(TYPE_MONSTER) and not c:IsCode(15000005)
end 
function c15000007.xfilter(c)
	return c:IsSetCard(0xf30)
end
function c15000007.wfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsOnField() and c:IsAbleToGrave() and c:IsFaceup()
end
function c15000007.sgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 end  
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)  
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	if chk==0 then return Duel.IsExistingMatchingCard(c15000007.xfilter,tp,LOCATION_GRAVE,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end 
function c15000007.sgop(e,tp,eg,ep,ev,re,r,rp)  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local s=Duel.SelectMatchingCard(tp,c15000007.xfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if s:GetCount()>0 then  
		Duel.SendtoHand(s,nil,REASON_EFFECT)  
		Duel.ConfirmCards(1-tp,s)  
	end
	local g=Duel.GetMatchingGroup(c15000007.wfilter,tp,0,LOCATION_ONFIELD+LOCATION_FZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c15000007.discon(e,tp,eg,ep,ev,re,r,rp)  
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)  
end  
function c15000007.distg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return true end  
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)  
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then  
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)  
	end  
end  
function c15000007.disop(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end  
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then  
		Duel.Destroy(eg,REASON_EFFECT)  
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end  
end