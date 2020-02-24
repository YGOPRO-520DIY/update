--圣刻龙-孔斯龙
function c88990338.initial_effect(c)
	--Normal monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_REMOVE_TYPE)
	e2:SetValue(TYPE_EFFECT)
	c:RegisterEffect(e2)
	--spsummon proc
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_SPSUMMON_PROC)
	e11:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e11:SetRange(LOCATION_DECK)
	e11:SetCountLimit(1,88990338)
	e11:SetCondition(c88990338.spcon)
	e11:SetCost(c88990338.spcost)
	e11:SetOperation(c88990338.spop)
	e11:SetValue(1)
	c:RegisterEffect(e11)
	--lv change
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(88990338,0))
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e12:SetCode(EVENT_SUMMON_SUCCESS)
	e12:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)

	e12:SetTarget(c88990338.tg)
	e12:SetOperation(c88990338.op)
	c:RegisterEffect(e12)
	local e31=e12:Clone()
	e31:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e31)
	Duel.AddCustomActivityCounter(88990338,ACTIVITY_SPSUMMON,c88990338.counterfilter)
end
function c88990338.counterfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON)
end
--spsummon proc
function c88990338.spfilter1(c,tp)
	return (c:IsSetCard(0x69)
	or (c:IsType(TYPE_NORMAL) and c:IsRace(RACE_DRAGON)))
	and c:IsType(TYPE_MONSTER)
	and c:IsReleasable()
end

function c88990338.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c88990338.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c88990338.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(88990338,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c88990338.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c88990338.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not (c:IsAttribute(ATTRIBUTE_LIGHT)) and c:IsLocation(LOCATION_EXTRA)
end
function c88990338.spop(e,tp,eg,ep,ev,re,r,rp,c)
	if chk==0 then return Duel.IsExistingMatchingCard(c88990338.spfilter1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=Duel.SelectMatchingCard(tp,c88990338.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Release(g1,REASON_COST)
	Duel.ShuffleDeck(tp)
end
--lv change
function c88990338.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local lv=e:GetHandler():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(88990338,1))
	e:SetLabel(Duel.AnnounceLevel(tp,1,8,lv))
end
function c88990338.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end