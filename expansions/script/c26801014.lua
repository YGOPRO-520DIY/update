--Future MUSiC
function c26801014.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,26801012,26801013,true,true)
	aux.AddContactFusionProcedure(c,c26801014.cfilter,LOCATION_ONFIELD+LOCATION_GRAVE,0,Duel.Remove,POS_FACEUP,REASON_COST)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c26801014.splimit)
	c:RegisterEffect(e1)
	--attribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_ADD_ATTRIBUTE)
	e2:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e2)
	--Pos Change
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_POSITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c26801014.target)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e3)
	--Prevent Activation
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(0,1)
	e4:SetValue(c26801014.aclimit)
	c:RegisterEffect(e4)
	--disable spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_CANNOT_SUMMON)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(0,1)
	e5:SetTarget(c26801014.target)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e7)
	if not c26801014.global_flag then
		c26801014.global_flag=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c26801014.regop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c26801014.regop(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		if tc:IsCode(26801012) and tc:IsSummonType(SUMMON_TYPE_FUSION) then
			Duel.RegisterFlagEffect(tc:GetSummonPlayer(),26801014,0,0,0)
		elseif tc:IsCode(26801013) and tc:IsSummonType(SUMMON_TYPE_FUSION) then
			Duel.RegisterFlagEffect(tc:GetSummonPlayer(),26809928,0,0,0)
		end
	end
end
function c26801014.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c26801014.cfilter(c,fc)
	local tp=fc:GetControler()
	return c:IsFusionCode(26801012,26801013) and c:IsAbleToRemoveAsCost() and Duel.GetFlagEffect(tp,26801014)>0 and Duel.GetFlagEffect(tp,26809928)>0
end
function c26801014.target(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK) or c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c26801014.aclimit(e,re,tp)
	return (re:GetHandler():IsAttribute(ATTRIBUTE_DARK) or re:GetHandler():IsAttribute(ATTRIBUTE_LIGHT)) and re:IsActiveType(TYPE_MONSTER)
end
