local m=15000004
local cm=_G["c"..m]
cm.name="异兽的都市"
function cm.initial_effect(c)
	--Activate  
	local e1=Effect.CreateEffect(c)  
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)  
	e1:SetType(EFFECT_TYPE_ACTIVATE)  
	e1:SetCode(EVENT_FREE_CHAIN)  
	e1:SetCountLimit(1,15000004)  
	e1:SetOperation(c15000004.activate)  
	c:RegisterEffect(e1)
	--pos (face-down)  
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetDescription(aux.Stringid(15000004,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,15010004)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c15000004.postg1)
	e2:SetOperation(c15000004.posop1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15000004,2))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,15020004)
	e3:SetOperation(c15000004.tgop)
	c:RegisterEffect(e3)
end
function c15000004.thfilter(c)  
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xf30) and c:IsAbleToHand()  
end  
function c15000004.activate(e,tp,eg,ep,ev,re,r,rp)  
	if not e:GetHandler():IsRelateToEffect(e) then return end  
	local g=Duel.GetMatchingGroup(c15000004.thfilter,tp,LOCATION_DECK,0,nil)  
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(15000004,0)) then  
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)  
		local sg=g:Select(tp,1,1,nil)  
		Duel.SendtoHand(sg,nil,REASON_EFFECT)  
		Duel.ConfirmCards(1-tp,sg)  
	end  
end
function c15000004.xfilter1(c)  
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xf30) and c:IsFaceup() and c:IsCanTurnSet()
end  
function c15000004.xfilter2(c)  
	return c:IsType(TYPE_MONSTER) and c:IsFacedown()  
end  
function c15000004.postg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local b1=Duel.IsExistingMatchingCard(c15000004.xfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
	local b2=Duel.IsExistingMatchingCard(c15000004.xfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
	if chk==0 then return b1 or b2 end  
	local off=1  
	local ops={}  
	local opval={}  
	if b1 then  
		ops[off]=aux.Stringid(15000004,1)  
		opval[off-1]=1  
		off=off+1  
	end  
	if b2 then  
		ops[off]=aux.Stringid(15000004,2)  
		opval[off-1]=2  
		off=off+1  
	end   
	local op=Duel.SelectOption(tp,table.unpack(ops))  
	local sel=opval[op]  
	e:SetLabel(sel)  
	if sel==1 then  
		if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc:IsSetCard(0xf30) and c:IsCanTurnSet() end
		if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)  
	elseif sel==2 then  
		if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFacedown() and chkc:IsSetCard(0xf30) end
		if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		local g=Duel.SelectTarget(tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	end  
end
function c15000004.posop1(e,tp,eg,ep,ev,re,r,rp)
	local sel=e:GetLabel()  
	if sel==1 then  
		if not e:GetHandler():IsRelateToEffect(e) then return end
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local pos1=0
			if not tc:IsPosition(POS_FACEDOWN_DEFENSE) then pos1=pos1+POS_FACEDOWN_DEFENSE end
			local pos2=Duel.SelectPosition(tp,tc,pos1)
			Duel.ChangePosition(tc,pos2)
		end
	elseif sel==2 then
		if not e:GetHandler():IsRelateToEffect(e) then return end
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsFacedown() then
			local pos1=0
			if not tc:IsPosition(POS_FACEUP_ATTACK) then pos1=pos1+POS_FACEUP_ATTACK end
			if not tc:IsPosition(POS_FACEUP_DEFENSE) then pos1=pos1+POS_FACEUP_DEFENSE end
			local pos2=Duel.SelectPosition(tp,tc,pos1)
			Duel.ChangePosition(tc,pos2)
		end
	end
end
function c15000004.sfilter(c,e,tp)
	return c:IsSetCard(0xf31) and not c:IsCode(15000004)
end
function c15000004.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,400,REASON_EFFECT)
	local g=Duel.SelectMatchingCard(tp,c15000004.sfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local c=e:GetHandler()
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ConfirmCards(1-tp,c)
		Duel.SendtoDeck(c,nil,3,REASON_EFFECT)
	end
end