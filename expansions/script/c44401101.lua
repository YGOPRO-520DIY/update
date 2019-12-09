--白苍圣一
function c44401101.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44401101,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	--e2:SetCountLimit(1,44401101)
	--e2:SetCost(c44401101.cost)
	e2:SetCondition(c44401101.spcon)
	e2:SetOperation(c44401101.spop)
	c:RegisterEffect(e2)
	--announce
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44401101,1))
	e11:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1,44401101)
	e11:SetTarget(c44401101.target)
	e11:SetOperation(c44401101.operation)
	c:RegisterEffect(e11)
	--sset
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e22:SetProperty(EFFECT_FLAG_DELAY)
	e22:SetCode(EVENT_REMOVE)
	e22:SetCountLimit(1,44401111)
	e22:SetTarget(c44401101.stg)
	e22:SetOperation(c44401101.sop)
	c:RegisterEffect(e22)
end
--special summon
function c44401101.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c44401101.cfilter1(c)
	return c:IsType(TYPE_MONSTER)
	and c:IsReleasable()
	and ((bit.band(c:GetOriginalType(),TYPE_SPELL)~=0
	or bit.band(c:GetOriginalType(),TYPE_TRAP)~=0))
end
function c44401101.cfilter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
	and c:IsReleasable()
    and bit.band(c:GetOriginalType(),TYPE_MONSTER)~=0
end
function c44401101.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c44401101.cfilter1,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
		or (Duel.IsExistingMatchingCard(c44401101.cfilter2,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0)
end
function c44401101.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.GetMatchingGroup(c44401101.cfilter1,tp,LOCATION_ONFIELD,0,e:GetHandler())
	local g2=Duel.GetMatchingGroup(c44401101.cfilter2,tp,LOCATION_ONFIELD,0,e:GetHandler())
	g1:Merge(g2)
	Duel.Release(g1,REASON_COST)
end
--announce
function c44401101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	local ac=Duel.AnnounceCard(tp)
	e:SetLabel(ac)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c44401101.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)

    local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(ac)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44401101,2))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e2:SetLabelObject(e1)
	e2:SetOperation(c44401101.rstop)
	c:RegisterEffect(e2)
	--local sc=c:GetCode()
	Duel.BreakEffect()
	local dg=Duel.GetMatchingGroup(c44401101.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,ac)
	local tc=dg:GetFirst()
	while tc do
		local e11=Effect.CreateEffect(e:GetHandler())
		e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_CHANGE_LEVEL)
		e11:SetValue(12)
		e11:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e11)
		tc=dg:GetNext()
	end
	local e19=Effect.CreateEffect(c)
	e19:SetType(EFFECT_TYPE_SINGLE)
	e19:SetCode(EFFECT_SET_ATTACK_FINAL)
	e19:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e19:SetReset(RESET_EVENT+RESETS_STANDARD)
	e19:SetValue(c44401101.val)
	c:RegisterEffect(e19)
end
function c44401101.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=e:GetLabelObject()
	e1:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--atk
function c44401101.deffilter(c)
	return c:GetBaseAttack()>=0 
	and c:IsFaceup() and c:IsLevel(12)
end
function c44401101.val(e,c)
	local g=Duel.GetMatchingGroup(c44401101.deffilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,c)
	return g:GetSum(Card.GetAttack)
end
--level
function c44401101.filter2(c,ac)
	return c:IsFaceup() and c:IsCode(ac)
end
--sset
function c44401101.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44401101.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44401101.sop(e,tp,eg,ep,ev,re,r,rp)
	--if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44401101.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end


