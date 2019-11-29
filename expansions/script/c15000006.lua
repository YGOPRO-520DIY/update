local m=15000006
local cm=_G["c"..m]
cm.name="人间异物月食·奈克洛兹玛"
function cm.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,15000005,c15000006.efilter,1,true,true)
	--to grave  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000006,0))  
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)  
	e1:SetProperty(EFFECT_FLAG_DELAY)  
	e1:SetRange(LOCATION_MZONE)  
	e1:SetCountLimit(1,15000006)  
	e1:SetTarget(c15000006.sgtg)  
	e1:SetOperation(c15000006.sgop)  
	c:RegisterEffect(e1)
	--search  
	local e2=Effect.CreateEffect(c)  
	e2:SetDescription(aux.Stringid(15000006,1))  
	e2:SetCategory(CATEGORY_POSITION)  
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)  
	e2:SetRange(LOCATION_MZONE)  
	e2:SetProperty(EFFECT_FLAG_DELAY)  
	e2:SetCode(EVENT_TO_DECK)  
	e2:SetCondition(c15000006.thcon)
	e2:SetCountLimit(1,15010006)  
	e2:SetTarget(c15000006.thtg)  
	e2:SetOperation(c15000006.thop)  
	c:RegisterEffect(e2)
end  
function c15000006.efilter(e,c)  
	local tp=e:GetControler()  
	return c:IsControler(1-tp) and c:IsCanBeFusionMaterial() and c:IsType(TYPE_MONSTER)
end 
function c15000006.xfilter(c)
	return c:IsSetCard(0xf31)
end
function c15000006.wfilter(c,e,tp)
	return c:IsFacedown()
end
function c15000006.sgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0 end  
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)  
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	if chk==0 then return Duel.IsExistingMatchingCard(c15000006.xfilter,tp,LOCATION_DECK,0,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end  
function c15000006.sgop(e,tp,eg,ep,ev,re,r,rp)  
	local g=Duel.GetMatchingGroup(c15000006.wfilter,tp,0,LOCATION_MZONE,nil) 
	if g:GetCount()>0 then 
		Duel.Destroy(g,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local s=Duel.SelectMatchingCard(tp,c15000006.xfilter,tp,LOCATION_DECK,0,1,1,nil)
		if s:GetCount()>0 then  
			Duel.SendtoHand(s,nil,REASON_EFFECT)  
			Duel.ConfirmCards(1-tp,s)  
		end
	end
end
function c15000006.cfilter(c,tp)  
	return c:GetPreviousControler()==tp and c:IsLocation(LOCATION_DECK) and c:GetPreviousLocation()==LOCATION_GRAVE and c:IsSetCard(0xf31)
end  
function c15000006.thcon(e,tp,eg,ep,ev,re,r,rp)  
	return eg:IsExists(c15000006.cfilter,1,nil,tp)  
end  
function c15000006.filter(c)  
	return c:IsCanBeEffectTarget() and c:IsCanTurnSet()
end  
function c15000006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)  
	local c=e:GetHandler()  
	if chk==0 then return Duel.IsExistingMatchingCard(c15000006.filter,tp,0,LOCATION_MZONE,1,nil) end  
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,tp,LOCATION_MZONE)  
end  
function c15000006.thop(e,tp,eg,ep,ev,re,r,rp)  
	local g=Duel.GetMatchingGroup(c15000006.filter,tp,0,LOCATION_MZONE,1,1,nil)  
	if g:GetCount()>0 then  
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
		local c=e:GetHandler()  
		if c:IsRelateToEffect(e) and c:IsFaceup() then  
			Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)  
		end
	end  
end