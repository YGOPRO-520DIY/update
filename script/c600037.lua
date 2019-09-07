--玄化爆风龙
function c600037.initial_effect(c)
	--fusion material
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x105),3,false)  
	c:SetSPSummonOnce(600037)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c600037.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c600037.sprcon)
	e2:SetOperation(c600037.sprop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600037,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c600037.condition)
	e3:SetTarget(c600037.target)
	e3:SetOperation(c600037.operation)
	c:RegisterEffect(e3)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(600037,2))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_REMOVED)
	e4:SetCondition(c600037.drcon)
	e4:SetCost(c600037.drcost)
	e4:SetTarget(c600037.drtg)
	e4:SetOperation(c600037.drop)
	c:RegisterEffect(e4)
end
function c600037.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c600037.spfilter(c)
	return c:IsFusionSetCard(0x105) and c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemoveAsCost()
end
function c600037.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c600037.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,3,nil)
end
function c600037.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c600037.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,3,3,nil)
	c:SetMaterial(g)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c600037.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP() and  not e:GetHandler():IsStatus(STATUS_SPSUMMON_TURN)
end
function c600037.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x105) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c600037.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c600037.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c600037.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c600037.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c600037.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(400)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2) 
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_DEFENSE)
		e3:SetValue(400)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
function c600037.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetHandler():GetTurnID()+1
end
function c600037.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),tp,2,REASON_COST)
end
function c600037.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x105) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck()
end
function c600037.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tg=Duel.GetMatchingGroup(c600037.tgfilter,tp,LOCATION_REMOVED,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,tg:GetCount(),tp,LOCATION_REMOVED)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c600037.drop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c600037.tgfilter,tp,LOCATION_REMOVED,0,nil)
	if tg:GetCount()>0 and Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)~=0 then
	 Duel.ShuffleDeck(tp)
	 Duel.Draw(tp,1,REASON_EFFECT)
	end
end