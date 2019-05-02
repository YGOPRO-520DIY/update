--CENSORED
function c65071089.initial_effect(c)
	 --atk
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c65071089.con)
	e1:SetTarget(c65071089.tg)
	e1:SetOperation(c65071089.op)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,65071089)
	e2:SetCondition(c65071089.tkcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c65071089.tktg)
	e2:SetOperation(c65071089.tkop)
	c:RegisterEffect(e2)
end

function c65071089.tkfil(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end

function c65071089.tkcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.IsExistingMatchingCard(c65071089.tkfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c65071089.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65071089.tkfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,65071151,0,0x4011,500,1000,2,RACE_FIEND,ATTRIBUTE_DARK) end
	local g=Duel.GetMatchingGroup(c65071089.tkfil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c65071089.tkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsCanTurnSet,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		if Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)~=0 then
		local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
		if Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft=1 end
		local dg=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
		local ct=g:FilterCount(Card.IsFacedown,nil)
		if ct>ft then ct=ft end
		Duel.BreakEffect()
		local c=e:GetHandler()
			for i=1,ct do
				local token=Duel.CreateToken(tp,65071151)
				Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			end
		Duel.SpecialSummonComplete()
		end
	end
end

function c65071089.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c65071089.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ev/2)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev/2)
end
function c65071089.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
