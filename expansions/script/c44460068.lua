--神依-炽月白凰
function c44460068.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSynchroType,TYPE_NORMAL),2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460068,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c44460068.xycost)
	e1:SetTarget(c44460068.xytg)
	e1:SetOperation(c44460068.xyop)
	c:RegisterEffect(e1)
	--spsummon condition
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetCode(EFFECT_SPSUMMON_CONDITION)
	e11:SetValue(c44460068.splimit)
	c:RegisterEffect(e11)
	--special summon rule
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_SPSUMMON_PROC)
	e21:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e21:SetRange(LOCATION_EXTRA)
	e21:SetCountLimit(1,44460068)
	e21:SetCondition(c44460068.spcon)
	e21:SetOperation(c44460068.spop)
	c:RegisterEffect(e21)
	--special summon rule2
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetCode(EFFECT_SPSUMMON_PROC)
	e22:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e22:SetRange(LOCATION_GRAVE)
	e22:SetCountLimit(1,44460068)
	e22:SetCondition(c44460068.spcon2)
	e22:SetOperation(c44460068.spop2)
	c:RegisterEffect(e22)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_ONFIELD)
	e3:SetOperation(c44460068.damop)
	c:RegisterEffect(e3)
end
--sy
function c44460068.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1500) end
	Duel.PayLPCost(tp,1500)
end
function c44460068.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460068.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsCode(44460003)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-3
        and Duel.IsExistingMatchingCard(c44460068.tfilter,tp,LOCATION_ONFIELD,0,3,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460068.climit)
end
function c44460068.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460068.tfilter,tp,LOCATION_ONFIELD,0,3,3,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
	end
end
function c44460068.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--spsummon condition
function c44460068.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_SYNCHRO
end
--special summon rule
function c44460068.matfilter(c)
	return c:IsSetCard(0x679) and c:IsSetCard(0x680)  and c:IsAbleToGraveAsCost()
end
function c44460068.spfilter1(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x679) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c44460068.spfilter2,tp,LOCATION_SZONE,0,1,c)
end
function c44460068.spfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x680) and c:IsAbleToGraveAsCost()
end
function c44460068.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c44460068.spfilter1,tp,LOCATION_SZONE,0,1,nil,tp)
end
function c44460068.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c44460068.spfilter1,tp,LOCATION_SZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c44460068.spfilter2,tp,LOCATION_SZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c44460068.spcon2(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.GetLocationCountFromEx(tp)>0
	and Duel.IsExistingMatchingCard(c44460068.spfilter1,tp,LOCATION_SZONE,0,1,nil,tp)
end
function c44460068.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=Duel.SelectMatchingCard(tp,c44460068.spfilter1,tp,LOCATION_SZONE,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c44460068.spfilter2,tp,LOCATION_SZONE,0,1,1,g1:GetFirst())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end
--damage
function c44460068.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,300,REASON_EFFECT)
end