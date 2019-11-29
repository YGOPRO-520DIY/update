local m=15000015
local cm=_G["c"..m]
cm.name="UB·奈克洛兹玛·光辉之神"
function cm.initial_effect(c)
	--link summon  
	aux.AddLinkProcedure(c,nil,2,2,c15000015.lcheck)  
	c:EnableReviveLimit()
	--negate  
	local e1=Effect.CreateEffect(c)  
	e1:SetDescription(aux.Stringid(15000015,0))  
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)  
	e1:SetType(EFFECT_TYPE_QUICK_O)  
	e1:SetCode(EVENT_CHAINING)  
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)  
	e1:SetRange(LOCATION_MZONE)  
	e1:SetCountLimit(1,15000015)  
	e1:SetCondition(c15000015.discon)
	e1:SetCost(c15000015.discost)  
	e1:SetTarget(c15000015.distg)  
	e1:SetOperation(c15000015.disop)  
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,15010015)
	e2:SetTarget(c15000015.seqtg)
	e2:SetOperation(c15000015.seqop)
	c:RegisterEffect(e2)
	--atk up  
	local e3=Effect.CreateEffect(c)  
	e3:SetType(EFFECT_TYPE_SINGLE)  
	e3:SetCode(EFFECT_UPDATE_ATTACK)  
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)  
	e3:SetRange(LOCATION_MZONE)  
	e3:SetValue(c15000015.atkval)  
	c:RegisterEffect(e3)
	--disable  
	local e4=Effect.CreateEffect(c)  
	e4:SetType(EFFECT_TYPE_FIELD)  
	e4:SetCode(EFFECT_CANNOT_TRIGGER)  
	e4:SetRange(LOCATION_MZONE)  
	e4:SetTargetRange(0,LOCATION_MZONE)  
	e4:SetTarget(c15000015.antg)  
	c:RegisterEffect(e4)
	--special summon  
	local e5=Effect.CreateEffect(c)  
	e5:SetDescription(aux.Stringid(15000015,2))  
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)  
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)  
	e5:SetCode(EVENT_LEAVE_FIELD)  
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(c15000015.spcon)  
	e5:SetTarget(c15000015.sptg)  
	e5:SetOperation(c15000015.spop)  
	c:RegisterEffect(e5) 
	--cannot attack  
	local e6=Effect.CreateEffect(c)  
	e6:SetType(EFFECT_TYPE_FIELD)  
	e6:SetCode(EFFECT_CANNOT_ATTACK)  
	e6:SetRange(LOCATION_MZONE)  
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)  
	e6:SetTarget(c15000015.anttg)  
	c:RegisterEffect(e6)
end
function c15000015.lcheck(g,lc)  
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_FUSION) and g:IsExists(Card.IsLinkType,1,nil,TYPE_FLIP)
end
function c15000015.atkval(e,c)  
	local g=e:GetHandler():GetLinkedGroup():Filter(Card.IsFaceup,nil)  
	return g:GetSum(Card.GetBaseAttack)  
end
function c15000015.anttg(e,c)  
	return e:GetHandler():GetLinkedGroup():IsContains(c)  
end
function c15000015.antg(e,c)  
	return e:GetHandler():GetLinkedGroup():IsContains(c)  
end 
function c15000015.cfilter(c,g)  
	return c:IsFaceup() and c:IsSetCard(0xf30) and not c:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsCode(15000015)
end
function c15000015.discon(e,tp,eg,ep,ev,re,r,rp)  
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end  
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)  
end
function c15000015.discost(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return Duel.CheckReleaseGroup(tp,c15000015.cfilter,1,nil) end  
	local g=Duel.SelectReleaseGroup(tp,c15000015.cfilter,1,1,nil)  
	Duel.Release(g,REASON_COST)  
end  
function c15000015.distg(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return true end  
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)  
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then  
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)  
	end  
end  
function c15000015.disop(e,tp,eg,ep,ev,re,r,rp)  
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then  
		Duel.Destroy(eg,REASON_EFFECT)  
	end  
end
function c15000015.seqfilter(c)  
	local tp=c:GetControler()  
	return c:GetSequence()<5 and Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp,LOCATION_REASON_CONTROL)>0  
end  
function c15000015.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	local c=e:GetHandler()  
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c15000015.seqfilter(chkc) end  
	if chk==0 then return Duel.IsExistingTarget(c15000015.seqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end  
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(15000015,1))  
	Duel.SelectTarget(tp,c15000015.seqfilter,tp,0,LOCATION_MZONE,1,1,nil) 
end  
function c15000015.seqop(e,tp,eg,ep,ev,re,r,rp)  
	local tc=Duel.GetFirstTarget()  
	local ttp=tc:GetControler()  
	if not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) or Duel.GetLocationCount(1-ttp,LOCATION_MZONE,1-ttp,LOCATION_REASON_CONTROL)<=0 then return end  
	local p1,p2  
	if tc:IsControler(tp) then  
		p1=LOCATION_MZONE  
		p2=0  
	else  
		p1=0  
		p2=LOCATION_MZONE  
	end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)  
	local seq=math.log(Duel.SelectDisableField(tp,1,p1,p2,0),2)  
	if tc:IsControler(1-tp) then seq=seq-16 end  
	Duel.MoveSequence(tc,seq)  
end
function c15000015.spcon(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	return c:IsSummonType(SUMMON_TYPE_LINK)  
end  
function c15000015.spfilter(c,e,tp)  
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)  
end  
function c15000015.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c15000015.spfilter(chkc,e,tp) end  
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0  
		and Duel.IsExistingTarget(c15000015.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
	local g=Duel.SelectTarget(tp,c15000015.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)  
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)  
end  
function c15000015.spop(e,tp,eg,ep,ev,re,r,rp)  
	local c=e:GetHandler()  
	local tc=Duel.GetFirstTarget()  
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then  
		local e1=Effect.CreateEffect(c)  
		e1:SetType(EFFECT_TYPE_SINGLE)  
		e1:SetCode(EFFECT_DISABLE)  
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)  
		tc:RegisterEffect(e1)  
		local e2=e1:Clone()  
		e2:SetCode(EFFECT_DISABLE_EFFECT)  
		tc:RegisterEffect(e2)  
		local e3=e1:Clone()  
		e3:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)  
		e3:SetValue(1)  
		tc:RegisterEffect(e3)  
		Duel.SpecialSummonComplete()  
	end  
end