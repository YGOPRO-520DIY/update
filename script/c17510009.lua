--折返的歌姬 初音未来
function c17510009.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c17510009.matfilter,1,1)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetCountLimit(1,17510009)
	e1:SetCondition(c17510009.tdcon)
	e1:SetTarget(c17510009.tdtg)
	e1:SetOperation(c17510009.tdop)
	c:RegisterEffect(e1)
	--todeck!
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,17510010)
	e2:SetTarget(c17510009.tg)
	e2:SetOperation(c17510009.op)
	c:RegisterEffect(e2)
end
c17510009.setname="FloWBacK"
function c17510009.matfilter(c)
	return c.setname=="FloWBacK" and not c:IsLinkType(TYPE_LINK)
end
function c17510009.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c17510009.spfilter(c,e,tp)
	return c.setname=="FloWBacK" and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17510009.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17510009.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c17510009.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c17510009.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c17510009.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLinkedGroup():GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler():GetLinkedGroup():GetFirst(),1,0,0)
end
function c17510009.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetLinkedGroup():GetFirst()
	if tc then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end