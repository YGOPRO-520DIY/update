--灰篮恐慌
function c65080504.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c65080504.spcon)
	e2:SetOperation(c65080504.spop)
	c:RegisterEffect(e2)   
	--negate effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c65080504.negcon)
	e3:SetOperation(c65080504.negop)
	c:RegisterEffect(e3)
end

function c65080504.cosfil(c)
	return c:IsSetCard(0xd1) and c:IsType(TYPE_MONSTER)
end
function c65080504.spfil(c,e,tp)
	return c:IsSetCard(0xd1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c65080504.spcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c65080504.cosfil,tp,LOCATION_GRAVE,0,nil)
	return g:GetClassCount(Card.GetCode)>=3 and Duel.IsExistingMatchingCard(c65080504.spfil,tp,LOCATION_DECK,0,1,nil,e,tp) and ep~=tp and Duel.GetMZoneCount(tp)>0
end
function c65080504.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	e:GetHandler():RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(65080504,2))
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c65080504.repop)
end
function c65080504.repop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(1-tp)<=0 then return end
	local g=Duel.SelectMatchingCard(1-tp,c65080504.spfil,1-tp,LOCATION_DECK,0,1,1,nil,e,1-tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,1-tp,1-tp,false,false,POS_FACEUP) then
		Duel.Destroy(g,REASON_EFFECT)
	end
end


function c65080504.cfilter(c)
	return c:IsFaceup() and not c:IsDisabled() 
end
function c65080504.filter(c,tp,re,r,rp)
	return c:IsSetCard(0xd1) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousControler()==tp
		and c:IsReason(REASON_EFFECT) 
end
function c65080504.tdfil(c)
	return c:IsSetCard(0xd1) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c65080504.negcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65080504.filter,1,nil,tp,re,r,rp) and Duel.IsExistingMatchingCard(c65080504.tdfil,tp,LOCATION_GRAVE,0,1,nil) and e:GetHandler():GetFlagEffect(65080504)==0
end
function c65080504.negop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectYesNo(tp,aux.Stringid(65080504,0)) then return end
	Duel.Hint(HINT_CARD,0,65080504)
	local c=e:GetHandler()
	c:RegisterFlagEffect(65080504,RESET_PHASE+PHASE_END,0,1)
	local g1=Duel.SelectMatchingCard(tp,c65080504.cfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	local tc=g1:GetFirst()
	if tc and tc:IsFaceup() and not tc:IsDisabled() and tc:IsControler(1-tp) then
			Duel.HintSelection(g1)
			Duel.NegateRelatedChain(tc,RESET_TURN_SET)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
	end
end