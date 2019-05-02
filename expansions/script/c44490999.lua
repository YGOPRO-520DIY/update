--青眼魔圣龙
function c44490999.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c44490999.mfilter,8,2,c44490999.ovfilter,aux.Stringid(44490999,0),3,c44490999.xyzop)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44490999,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c44490999.atkcost)
	e1:SetOperation(c44490999.atkop)
	c:RegisterEffect(e1)
	--immune
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(c44490999.imcon)
	e11:SetValue(c44490999.efilter)
	c:RegisterEffect(e11)
	--tohand
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44490999,1))
	e31:SetCountLimit(1,44490999)
	e31:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetCode(EVENT_REMOVE)
	e31:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e31:SetTarget(c44490999.thtg)
	e31:SetOperation(c44490999.thop)
	c:RegisterEffect(e31)
end
function c44490999.ovfilter(c)
	return c:IsFaceup() and c:IsCode(89631139)
end
function c44490999.mfilter(c)
	return c:IsFaceup()
end
function c44490999.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,44490999)==0 end
	Duel.RegisterFlagEffect(tp,44490999,RESET_PHASE+PHASE_END,0,1)
end
function c44490999.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c44490999.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(500)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e1)
			
			--attribute
	        local e2=Effect.CreateEffect(c)
	        e2:SetType(EFFECT_TYPE_SINGLE)
	        --e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	        --e2:SetRange(LOCATION_MZONE)
	        e2:SetCode(EFFECT_ADD_ATTRIBUTE)
	        e2:SetValue(ATTRIBUTE_LIGHT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
	        c:RegisterEffect(e2)
			--code
	        local e22=Effect.CreateEffect(c)
	        e22:SetType(EFFECT_TYPE_SINGLE)
			e22:SetCode(EFFECT_CHANGE_CODE)
	        e22:SetValue(89631139)
			e22:SetReset(RESET_EVENT+0x1fe0000)
	        c:RegisterEffect(e22)
	end
end
--immune
function c44490999.imcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c44490999.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
--tohand
function c44490999.filter(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44490999.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490999.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44490999.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44490999.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
