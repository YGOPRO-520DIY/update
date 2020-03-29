--破土种光的生命树
function c65071158.initial_effect(c)
	--atc
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--cont
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_FZONE)
	e1:SetOperation(aux.chainreg)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_FZONE)
	e2:SetOperation(c65071158.acop)
	c:RegisterEffect(e2)
	--Search
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c65071158.con)
	e4:SetCost(c65071158.cost)
	e4:SetTarget(c65071158.tg)
	e4:SetOperation(c65071158.op)
	c:RegisterEffect(e4)
end
function c65071158.acop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_ONFIELD,nil)
		g:AddCard(e:GetHandler())
		local c=g:GetFirst()
		while c do
			c:AddCounter(0x1da0,1)
			c=g:GetNext()
		end
	end
end

function c65071158.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c65071158.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c65071158.tgfil1(c,tp)
	return c:IsSSetable() and (Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or c:IsType(TYPE_FIELD)) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c65071158.tgfil2(c,tp)
	return c:IsAbleToGrave() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c65071158.tgfil3(c,tp)
	return c:IsSSetable() and (Duel.GetLocationCount(tp,LOCATION_SZONE)>0 or c:IsType(TYPE_FIELD) and (c:IsType(TYPE_QUICKPLAY) or (c:IsType(TYPE_NORMAL) and c:IsType(TYPE_TRAP))) 
end
function c65071158.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1da0)>=6 and Duel.IsExistingMatchingCard(c65071158.tgfil1,tp,LOCATION_DECK,0,1,nil,tp)
	local b2=Duel.GetCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1da0)>=8 and Duel.IsExistingMatchingCard(c65071158.tgfil2,tp,LOCATION_DECK,0,1,nil,tp)
	local b2=Duel.GetCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1da0)>=12 and Duel.IsExistingMatchingCard(c65071158.tgfil3,tp,LOCATION_DECK,0,1,nil,tp)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return e:GetHandler():GetFlagEffect(65071158)==0 and (b1 or b2 or b3) end
	local op=99
	if b1 and b2 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,0),aux.Stringid(65070018,1),aux.Stringid(65070018,2))
	elseif b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,0),aux.Stringid(65070018,1))
	elseif b1 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,0),aux.Stringid(65070018,2))
		if op==1 then op=2 end
	elseif b2 and b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,1),aux.Stringid(65070018,2))+1
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,0))
	elseif b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,1))+1
	elseif b3 then
		op=Duel.SelectOption(tp,aux.Stringid(65070018,2))+2
	end
	if op==0 then
		Duel.RemoveCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1da0,6,REASON_COST)
	elseif op==1 then
		e:SetCategory(CATEGORY_TOGRAVE)
		Duel.RemoveCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1da0,8,REASON_COST)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	elseif op==2 then
		Duel.RemoveCounter(tp,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1da0,12,REASON_COST)
	end
	e:SetLabel(op)
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(65071158,op))
	e:GetHandler():RegisterFlagEffect(65071158,RESET_CHAIN,0,1)
end
function c65071158.op(e,tp,eg,ep,ev,re,r,rp)
	if op==0 then
		local g1=Duel.SelectMatchingCard(tp,c65071158.tgfil1,tp,LOCATION_DECK,0,1,1,nil,tp)
		local tc1=g1:GetFirst()
		if tc1 and tc1:IsSSetable() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
			Duel.SSet(tp,tc1)
		end
	elseif op==1 then
		local g2=Duel.SelectMatchingCard(tp,c65071158.tgfil2,tp,LOCATION_DECK,0,1,1,nil,tp)
		if g2:GetCount()>0 then
			Duel.SendtoGrave(g2,REASON_EFFECT)
		end
	elseif op==2 then
		local g3=Duel.SelectMatchingCard(tp,c65071158.tgfil3,tp,LOCATION_DECK,0,1,1,nil,tp)
		local tc3=g1:GetFirst()
		if tc3 and tc3:IsSSetable() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
			Duel.SSet(tp,tc3)
			if tc3:IsType(TYPE_SPELL) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_QP_ACT_IN_SET_TURN)
			e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc3:RegisterEffect(e1)
			else
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
			e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc3:RegisterEffect(e1)
			end
		end 
	end
end