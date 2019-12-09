--华美之宴·高垣枫
function c81007011.initial_effect(c)
	c:SetSPSummonOnce(81007011)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,c81007011.ovfilter,aux.Stringid(81007011,0))
	c:EnableReviveLimit()
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,81007911)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c81007011.mattg)
	e2:SetOperation(c81007011.matop)
	c:RegisterEffect(e2)
	--disable special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(81007011,1))
	e5:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_SPSUMMON)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,81007011)
	e5:SetCondition(c81007011.discon)
	e5:SetCost(c81007011.discost)
	e5:SetTarget(c81007011.distg)
	e5:SetOperation(c81007011.disop)
	c:RegisterEffect(e5)
end
function c81007011.ovfilter(c)
	return c:IsFaceup() and c:IsCode(81007004)
end
function c81007011.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function c81007011.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c81007011.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c81007011.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c81007011.xyzfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_XYZ)
end
function c81007011.matfilter(c)
	return c:IsType(TYPE_LINK) and c:IsType(TYPE_MONSTER)
end
function c81007011.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c81007011.xyzfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81007011.xyzfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c81007011.matfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c81007011.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c81007011.matop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c81007011.matfilter,tp,LOCATION_EXTRA,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.Overlay(tc,g)
		end
	end
end
