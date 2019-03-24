--叠光超载
function c91000004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91000004,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c91000004.target)
	e1:SetOperation(c91000004.activate)
	c:RegisterEffect(e1)
end
function c91000004.filter(c,tp)
	if not c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0 then return false end
	local g=Duel.GetDecktopGroup(tp,c:GetOverlayCount())
	return g:FilterCount(Card.IsAbleToRemove,nil)==c:GetOverlayCount()
end
function c91000004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
   if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c91000004.filter(chkc) end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.IsExistingTarget(c91000004.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
local g=Duel.SelectTarget(tp,c91000004.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local rg=Duel.GetDecktopGroup(tp,g:GetFirst():GetOverlayCount())
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,rg,rg:GetCount(),0,0)
end
function c91000004.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local ol=tc:GetOverlayCount()
		local rg=Duel.GetDecktopGroup(tp,ol)
		Duel.DisableShuffleCheck()
		Duel.Overlay(tc,rg)
		Duel.SetLP(tp,Duel.GetLP(tp)-ol*2000)
	end
end