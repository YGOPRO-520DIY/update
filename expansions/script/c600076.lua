--电子暗黑枪管龙
function c600076.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkAttribute,ATTRIBUTE_DARK),2,2)
	c:EnableReviveLimit()
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c600076.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c600076.splimit)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(600076,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,600076)
	e3:SetTarget(c600076.target)
	e3:SetOperation(c600076.operation)
	c:RegisterEffect(e3)
	--spsummon2
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(600076,1))
	e4:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(aux.exccon)
	e4:SetCountLimit(1,6000076)
	e4:SetCost(c600076.spcost)
	e4:SetTarget(c600076.sptg)
	e4:SetOperation(c600076.spop)
	c:RegisterEffect(e4) 
	if not c600076.global_check then
		c600076.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c600076.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c600076.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if not tc:IsAttribute(ATTRIBUTE_DARK) then
			if tc:GetSummonPlayer()==0 then p1=true else p2=true end
		end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(0,600076,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(1,600076,RESET_PHASE+PHASE_END,0,1) end
end
function c600076.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c600076.sumlimit)
	Duel.RegisterEffect(e1,tp)
end
function c600076.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsAttribute(ATTRIBUTE_DARK)
end
function c600076.splimit(e,se,sp,st,spos,tgp)
	return bit.band(st,SUMMON_TYPE_SPECIAL)~=SUMMON_TYPE_SPECIAL or Duel.GetFlagEffect(tgp,600076)==0
end
function c600076.filter(c,e,tp)
	return (c:IsRace(RACE_MACHINE) and c:IsSetCard(0x4093)) or c:IsSetCard(0x10f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(600076)
end
function c600076.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c600076.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c600076.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c600076.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local c=e:GetHandler()
		local tc=g:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		Duel.Equip(tp,c,tc,true)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c600076.eqlimit)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
		--atkup
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(1600)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
	end
end
function c600076.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c600076.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and Duel.GetMZoneCount(tp,c)>0
end
function c600076.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c600076.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c600076.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c600076.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c600076.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then 
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
