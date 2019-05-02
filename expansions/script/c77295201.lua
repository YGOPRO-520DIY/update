--百绘罗衣·式神 丑时之女
local m=77295201
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCost(cm.spcost)
	e1:SetTarget(cm.sptg1)
	e1:SetOperation(cm.spop1)
	c:RegisterEffect(e1)
	--token1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCost(cm.spcost)
	e2:SetTarget(cm.sptg2)
	e2:SetOperation(cm.spop2)
	c:RegisterEffect(e2)
   --spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,77295202)
	e3:SetCondition(cm.condition)
	e3:SetTarget(cm.target)
	e3:SetOperation(cm.activate)
	c:RegisterEffect(e3)
end
	--token
function cm.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function cm.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function cm.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,77295203,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,77295203)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
   --
function cm.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function cm.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(1-tp,77295203,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,77295203)
	Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP)
end
   --spsummon
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>1 and Duel.CheckChainUniqueness()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		local tg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local tc=tg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-400)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(-400)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
			tc=tg:GetNext()
		end
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e3:SetValue(LOCATION_DECKSHF)
		c:RegisterEffect(e3,true)
	end
end

