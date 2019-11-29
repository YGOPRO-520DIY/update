--星曜再现
function c21520148.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520148,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH+CATEGORY_TOHAND) 
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c21520148.condition)
	e1:SetTarget(c21520148.target)
	e1:SetOperation(c21520148.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e2)
	--send to grave
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetTarget(c21520148.stgtg)
	e3:SetOperation(c21520148.stgop)
	c:RegisterEffect(e3)
--[[
	--send to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c21520148.stgop)
	c:RegisterEffect(e3)--]]
end
function c21520148.spfilter(c,e,tp,atk)
	return c:IsSetCard(0x491) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetAttack()<=atk
end
function c21520148.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c21520148.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.IsExistingMatchingCard(c21520148.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,ev) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
--[[	if (e:GetHandler():GetFlagEffect(21520148)==0
		and Duel.IsExistingMatchingCard(c21520148.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,ev)) then
		e:GetHandler():RegisterFlagEffect(21520148,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	else
		e:SetProperty(0)
	end--]]
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c21520148.thfilter(c)
	return  c:IsSetCard(0x491) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c21520148.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c21520148.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,ev)
	local tc=g:GetFirst()
--	local fid=c:GetFieldID()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
--		tc:CreateRelation(c,RESET_EVENT+0x1fe0000)
		if Duel.IsExistingMatchingCard(c21520148.thfilter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(21520148,1)) then 
			Duel.BreakEffect()
			local thg=Duel.SelectMatchingCard(tp,c21520148.thfilter,tp,LOCATION_DECK,0,1,1,nil)
			Duel.SendtoHand(thg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,thg)
		end
--		tc:RegisterFlagEffect(21520148,RESET_EVENT+0x1fe0000,0,1,fid)
--		tc:RegisterFlagEffect(21520148,RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
--[[
	g:KeepAlive()
	--send to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetLabel(fid)
	e3:SetLabelObject(g)
	e3:SetCondition(c21520148.stgcon)
	e3:SetOperation(c21520148.stgop)
	c:RegisterEffect(e3)--]]
end
function c21520148.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsPreviousPosition(POS_FACEUP) end
	Duel.SetTargetPlayer(tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),tp,LOCATION_MZONE)
end
function c21520148.stgop(e,tp,eg,ep,ev,re,r,rp)
	local player=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(player,LOCATION_MZONE,0)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
--[[
function c21520148.stgfilter(c,rc)
--	return rc:IsHasCardTarget(c)
	return c:GetFlagEffect(21520148)~=0
--	return rc:IsRelateToCard(c)
--	return c:GetFlagEffectLabel(21520148)==rc
end
function c21520148.stgcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c21520148.stgfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c21520148.stgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c21520148.stgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetHandler())
--	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_EFFECT)

	local tc=g:GetFirst()
	while tc do
--		tc:ReleaseRelation(c)
		tc:ResetFlagEffect(21520148)
		tc=g:GetNext()
	end
end--]]
