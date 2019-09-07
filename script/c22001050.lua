--从者Mooncancer B B
function c22001050.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),3,99,c22001050.lcheck)
	c:EnableReviveLimit()
   --control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22001050,1))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c22001050.cttg)
	e1:SetOperation(c22001050.ctop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22001050,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c22001050.cost)
	e2:SetCountLimit(1)
	e2:SetCondition(c22001050.ddcon)
	e2:SetTarget(c22001050.ddtg)
	e2:SetOperation(c22001050.ddop)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c22001050.eftg)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetCondition(c22001050.incon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e5)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetValue(aux.tgoval)
	c:RegisterEffect(e5)
end
function c22001050.lcheck(g)
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_FUSION)
end
function c22001050.eftg(e,c)
	return c:IsFaceup()
end
function c22001050.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c22001050.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler()==e:GetHandler()
		and re:IsActiveType(TYPE_MONSTER)
end
function c22001050.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c22001050.ddop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetDecktopGroup(tp,1)
	local g2=Duel.GetDecktopGroup(1-tp,1)
	g1:Merge(g2)
	Duel.DisableShuffleCheck()
	Duel.Remove(g1,POS_FACEDOWN,REASON_EFFECT)
end
function c22001050.ctfilter1(c)
	local tp=c:GetControler()
	return c:IsAbleToChangeControler() and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c22001050.ctfilter2(c)
	local tp=c:GetControler()
	return c:IsAbleToChangeControler()
		and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c22001050.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c22001050.ctfilter1,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingTarget(c22001050.ctfilter2,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g1=Duel.SelectTarget(tp,c22001050.ctfilter1,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g2=Duel.SelectTarget(tp,c22001050.ctfilter2,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g1,2,0,0)
end
function c22001050.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local a=g:GetFirst()
	local b=g:GetNext()
	if a:IsRelateToEffect(e) and b:IsRelateToEffect(e) then
		Duel.SwapControl(a,b)
	end
end
function c22001050.incon(e)
	return e:GetHandler():IsLinkState()
end