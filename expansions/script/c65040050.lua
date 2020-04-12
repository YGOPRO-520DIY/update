--虚灵人鱼
function c65040050.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c65040050.target)
	e1:SetOperation(c65040050.operation)
	c:RegisterEffect(e1)
	 --special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_REMOVE)
	e4:SetOperation(c65040050.spreg)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(65040050,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetCondition(c65040050.spcon)
	e5:SetTarget(c65040050.sptg)
	e5:SetOperation(c65040050.spop)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
function c65040050.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c65040050.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
	end
end

function c65040050.spreg(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()==tp then
		e:SetLabel(Duel.GetTurnCount()+2)
		c:RegisterFlagEffect(65040050,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,3)
	else	
		e:SetLabel(Duel.GetTurnCount()+1)
		c:RegisterFlagEffect(65040050,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2)
	end
end
function c65040050.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==Duel.GetTurnCount() and e:GetHandler():GetFlagEffect(65040050)>0
end
function c65040050.xtgfil(c,xc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and xc:IsCanBeXyzMaterial(c)
end
function c65040050.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(c65040050.xtgfil,tp,LOCATION_MZONE,0,1,nil,e:GetHandler())
	local b2=e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then return true end
	local op=99
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65040050,0),aux.Stringid(65040050,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(65040050,0))
	elseif b2 then
		op=Duel.SelectOption(tp,aux.Stringid(65040050,1))+1
	else return end
	if op==1 then
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c65040050.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
		e:GetHandler():ResetFlagEffect(65040050)
	end
	e:SetLabel(op)
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(65040050,op))
end
function c65040050.splimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsType(TYPE_XYZ)
end
function c65040050.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local op=e:GetLabel()
	if op==0 then
		local g=Duel.SelectMatchingCard(tp,c65040050.xtgfil,tp,LOCATION_MZONE,0,1,1,nil,c)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local xc=g:GetFirst()
			Duel.Overlay(xc,c)
		end
	elseif op==1 then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end