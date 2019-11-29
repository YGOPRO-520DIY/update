--badapple 露琪诺
function c4045.initial_effect(c)
	--xyz summon	
	aux.AddXyzProcedure(c,c4045.ff,4,3,c4045.ovfilter,aux.Stringid(4045,1))
	c:EnableReviveLimit()
	--extra attack  
	local e1=Effect.CreateEffect(c) 
	e1:SetType(EFFECT_TYPE_SINGLE)  
	e1:SetCode(EFFECT_EXTRA_ATTACK) 
	e1:SetValue(1)  
	c:RegisterEffect(e1)
	--immune	
	local e3=Effect.CreateEffect(c) 
	e3:SetType(EFFECT_TYPE_SINGLE)  
	e3:SetCode(EFFECT_IMMUNE_EFFECT)	
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)	
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c4045.imcon)
	e3:SetValue(c4045.efilter)  
	c:RegisterEffect(e3)
	--atk   
	local e2=Effect.CreateEffect(c) 
	e2:SetDescription(aux.Stringid(4045,0)) 
	e2:SetType(EFFECT_TYPE_IGNITION)	
	e2:SetRange(LOCATION_MZONE) 
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET) 
	e2:SetCountLimit(1) 
	e2:SetCost(c4045.cost)  
	e2:SetTarget(c4045.target)  
	e2:SetOperation(c4045.operation)	
	c:RegisterEffect(e2)
end
function c4045.imcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c4045.ff(c)		
	return c:IsSetCard(0x5907)
end
function c4045.ovfilter(c)  
	return c:IsFaceup() and c:IsRankBelow(3) and c:IsSetCard(0x3e7) 
	and c:GetOverlayCount()==0
end
function c4045.efilter(e,te)	
	return te:GetOwner()~=e:GetOwner()
end
function c4045.cost(e,tp,eg,ep,ev,re,r,rp,chk)  
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end   
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c4045.filter(c)	
	return c:IsFaceup() and c:GetAttack()>0  
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c4045.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)   
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c4045.filter(chkc) end   
	if chk==0 then return Duel.IsExistingTarget(c4045.filter,tp,0,LOCATION_MZONE,1,nil) end 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP) 
	Duel.SelectTarget(tp,c4045.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c4045.operation(e,tp,eg,ep,ev,re,r,rp) 
	local c=e:GetHandler()  
	local tc=Duel.GetFirstTarget()  
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then		
		local e1=Effect.CreateEffect(c)  
		e1:SetType(EFFECT_TYPE_SINGLE)  
		e1:SetCode(EFFECT_UPDATE_ATTACK)		
		e1:SetValue(tc:GetAttack())  
		e1:SetReset(RESET_PHASE+PHASE_END,2)	
		c:RegisterEffect(e1)	
	end
end

