--星曜圣装-柳土獐
function c21520234.initial_effect(c)
	c:SetSPSummonOnce(21520234)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(21520234,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c21520234.sprcon)
	e0:SetOperation(c21520234.sprop)
	c:RegisterEffect(e0)
	local e01=Effect.CreateEffect(c)
	e01:SetType(EFFECT_TYPE_SINGLE)
	e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e01:SetCode(EFFECT_SPSUMMON_CONDITION)
	e01:SetValue(c21520234.splimit)
	c:RegisterEffect(e01)
	--ignition effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520234,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c21520234.igtg)
	e2:SetOperation(c21520234.igop)
	c:RegisterEffect(e2)
end
c21520234.card_code_list={21520124}
function c21520234.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS) and se:GetHandler():IsSetCard(0xa491)
end
function c21520234.spfilter(c)
	return c:IsCode(21520124) and c:IsAbleToRemoveAsCost()
end
function c21520234.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c21520234.spfilter,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) and Duel.GetLocationCountFromEx(tp)>0 
end
function c21520234.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local player=e:GetHandlerPlayer()
	local rg=Duel.SelectMatchingCard(player,c21520234.spfilter,player,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c21520234.igtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function c21520234.igop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	if g1:GetCount()>0 and g2:GetCount()>0 then 
		local dg1=Duel.GetDecktopGroup(tp,1)
		local dg2=Duel.GetDecktopGroup(1-tp,1)
		Duel.ConfirmDecktop(tp,1)
		Duel.ConfirmDecktop(1-tp,1)
		local tpc1=dg1:GetFirst()
		local tpc2=dg2:GetFirst()
		if (tpc1:IsType(TYPE_MONSTER) and tpc2:IsType(TYPE_MONSTER)) or (tpc1:IsType(TYPE_SPELL) and tpc2:IsType(TYPE_SPELL)) or (tpc1:IsType(TYPE_TRAP) and tpc2:IsType(TYPE_TRAP)) then 
			Duel.DisableShuffleCheck()
			Duel.Remove(dg1,POS_FACEUP,REASON_EFFECT)
			Duel.DisableShuffleCheck()
			Duel.Remove(dg2,POS_FACEUP,REASON_EFFECT)
			Duel.Draw(tp,2,REASON_EFFECT)
		else 
			Duel.MoveSequence(tpc1,1)
			Duel.MoveSequence(tpc2,1)
		end
	end
end
