--神奇术士的虹彩石
function c65020161.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c65020161.ac)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1) 
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c65020161.con)
	e2:SetTarget(c65020161.tg)
	e2:SetOperation(c65020161.op)
	c:RegisterEffect(e2)
	--fukaz!
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,65020161)
	e3:SetCondition(c65020161.econ)
	e3:SetTarget(c65020161.etg)
	e3:SetOperation(c65020161.eop)
	c:RegisterEffect(e3)
end
function c65020161.ecfil(c)
	return c:IsSetCard(0xada8) and c:IsType(TYPE_CONTINUOUS) and c:IsPreviousLocation(LOCATION_SZONE)
end
function c65020161.econ(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65020161.ecfil,1,nil) and not eg:IsContains(e:GetHandler())
end
function c65020161.etg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and not e:GetHandler():IsForbidden() end
end
function c65020161.eop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		local tc=e:GetHandler()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		tc:AddCounter(0x1da2,1)
end

function c65020161.ac(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x1da2,2)
	end
end

function c65020161.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x1da2)<=0
end
function c65020161.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c65020161.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end