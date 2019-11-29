--badapple 八意永琳
function c4044.initial_effect(c)
	--xyz summon		
	aux.AddXyzProcedure(c,c4044.ff,5,2,c4044.ovfilter,aux.Stringid(4044,0))
	c:EnableReviveLimit() 
	--zhanpo
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c4044.imcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c4044.atkval)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c4044.reptg)
	c:RegisterEffect(e3)
end
function c4044.ff(c)		
	return c:IsSetCard(0x5907)
end
function c4044.imcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c4044.ovfilter(c)  
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x5907) and not c:IsCode(4044)
end
function c4044.atkval(e,c)
	return c:GetOverlayCount()*400
end
function c4044.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(4044,1)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
