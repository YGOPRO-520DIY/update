--时眠之洛兰娜拉
function c65011020.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c65011020.sprcon)
	e0:SetOperation(c65011020.sprop)
	c:RegisterEffect(e0)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,65011020)
	e1:SetTarget(c65011020.target)
	e1:SetOperation(c65011020.activate)
	c:RegisterEffect(e1)
end
function c65011020.sprfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c65011020.sprfilter1(c,tp,g,sc)
	local lv=c:GetLevel()
	return c:IsType(TYPE_TUNER) and g:IsExists(c65011020.sprfilter2,1,c,tp,c,sc,lv)
end
function c65011020.sprfilter2(c,tp,mc,sc,lv)
	local sg=Group.FromCards(c,mc)
	return c:GetLevel()==lv-3 and c:GetOriginalLevel()>0 
		and Duel.GetLocationCountFromEx(tp,tp,sg,sc)>0
end
function c65011020.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c65011020.sprfilter,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c65011020.sprfilter1,1,nil,tp,g,c)
end
function c65011020.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c65011020.sprfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=g:FilterSelect(tp,c65011020.sprfilter1,1,1,nil,tp,g,c)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=g:FilterSelect(tp,c65011020.sprfilter2,1,1,mc,tp,mc,c,mc:GetLevel())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end

function c65011020.filter(c)
	local atk=c:GetAttack()
	local def=c:GetDefense()
	return c:IsType(TYPE_TUNER) and c:IsAbleToHand() and atk<=def+1000 and atk>=def-1000
end
function c65011020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65011020.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65011020.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65011020.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		if atk==def and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.SelectYesNo(tp,aux.Stringid(65011020,0)) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end