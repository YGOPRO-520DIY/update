--御主 卫宫士郎
function c22090010.initial_effect(c)
	--special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_HAND)
	e0:SetCountLimit(1,22090010)
	e0:SetCondition(c22090010.hspcon)
	e0:SetOperation(c22090010.hspop)
	e0:SetValue(1)
	c:RegisterEffect(e0)
	--code
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetValue(22000020)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22090010,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c22090010.lvcost)
	e2:SetOperation(c22090010.lvop)
	c:RegisterEffect(e2)
end
function c22090010.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.CheckLPCost(tp,1000)
end
function c22090010.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,1000)
end
function c22090010.costfilter(c,lv)
	local clv=c:GetLevel()
	return clv>0 and clv~=lv and c:IsSetCard(0xfff) and c:IsAbleToGraveAsCost()
end
function c22090010.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=e:GetHandler():GetLevel()
	if chk==0 then return Duel.IsExistingMatchingCard(c22090010.costfilter,tp,LOCATION_DECK,0,1,nil,lv) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c22090010.costfilter,tp,LOCATION_DECK,0,1,1,nil,lv)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c22090010.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lv=e:GetLabel()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end