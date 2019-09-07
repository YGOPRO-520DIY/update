--雪暴猎鹰的摧残
function c43694490.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43694490,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43694490,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCondition(c43694490.damcon)
	e2:SetTarget(c43694490.damtg)
	e2:SetOperation(c43694490.damop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e3)
end
function c43694490.damfil(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousAttributeOnField()==ATTRIBUTE_WATER and c:GetPreviousRaceOnField()==RACE_WINDBEAST 
end
function c43694490.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c43694490.damfil,1,nil,tp)
end

function c43694490.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(43694490)==0 end
	local g=eg:Filter(c43694490.damfil,nil,tp)
	local tc=g:GetFirst()
	local dam=0
	while tc do
		dam=dam+tc:GetBaseAttack()
		tc=g:GetNext()
	end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
	e:GetHandler():RegisterFlagEffect(43694490,RESET_CHAIN,0,1)
end
function c43694490.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end