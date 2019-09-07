--青眼白皇龙
function c44490990.initial_effect(c)
    c:SetUniqueOnField(1,0,44490990)
	--fusion material
	aux.AddFusionProcFun2(c,89631139,c44490990.mfilter2,true)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44490990,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,44490990)
	e1:SetCondition(c44490990.thcon)
	e1:SetTarget(c44490990.thtg)
	e1:SetOperation(c44490990.thop)
	c:RegisterEffect(e1)
	--ATK
	--INDESTRUCTABLE
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44490990,2))
	e22:SetCategory(CATEGORY_ATKCHANGE)
	e22:SetType(EFFECT_TYPE_QUICK_O)
	e22:SetCode(EVENT_FREE_CHAIN)
	e22:SetCountLimit(1,44490991)
	e22:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)

	e22:SetRange(LOCATION_MZONE)
	e22:SetCost(c44490990.dcost)
	e22:SetTarget(c44490990.dtg)
	e22:SetOperation(c44490990.dop)
	c:RegisterEffect(e22)

end
c44490990.material_setcode=89631139
function c44490990.mfilter1(c)
	return c:IsCode(89631139)
end
function c44490990.mfilter2(c)
	return c:GetAttack()>=3000 and c:IsType(TYPE_MONSTER)
end
--search
function c44490990.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c44490990.thfilter(c)
	return ((aux.IsCodeListed(c,89631139) or aux.IsCodeListed(c,23995346))
	and c:IsType(TYPE_SPELL+TYPE_TRAP))
	and c:IsAbleToHand()
end
function c44490990.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44490990.thfilter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44490990.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44490990.thfilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--ATK
function c44490990.filter(c)
	return c:IsFaceup()
	--and c:IsSetCard(0xdd)
end
--INDESTRUCTABLE
function c44490990.dcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c44490990.dtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c44490990.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44490990.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c44490990.dop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
		if tc:IsSetCard(0xdd) then 
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		end
	end
end


function c44490990.aop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end


