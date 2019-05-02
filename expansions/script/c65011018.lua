--双生之米勒拉米斯
function c65011018.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c65011018.tfilter,aux.NonTuner(nil),1,1)
	c:EnableReviveLimit()
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c65011018.sprcon)
	e0:SetOperation(c65011018.sprop)
	c:RegisterEffect(e0)
	--reg
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c65011018.regops)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c65011018.regopns)
	c:RegisterEffect(e2)
	--change atk and def
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c65011018.cgcon1)
	e3:SetTarget(c65011018.cgtg11)
	e3:SetOperation(c65011018.cgop11)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetTarget(c65011018.cgtg12)
	e4:SetOperation(c65011018.cgop12)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCondition(c65011018.cgcon2)
	e5:SetTarget(c65011018.cgtg21)
	e5:SetOperation(c65011018.cgop21)
	c:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetCondition(c65011018.cgcon2)
	e6:SetTarget(c65011018.cgtg22)
	e6:SetOperation(c65011018.cgop22)
	c:RegisterEffect(e6)
	--toextra
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetOperation(c65011018.teop)
	c:RegisterEffect(e7)
end

function c65011018.teop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
end

function c65011018.cgcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(65011018)~=0
end
function c65011018.cgcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(89914522)~=0
end
function c65011018.cgfil11(c,tp,ep)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
		and ep==tp
end
function c65011018.cgfil21(c,tp,ep)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()
		and ep~=tp
end
function c65011018.cgtg11(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return c65011018.cgfil11(tc,tp,ep) end
	Duel.SetTargetCard(eg)
end
function c65011018.cgtg21(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return c65011018.cgfil21(tc,tp,ep) end
	Duel.SetTargetCard(eg)
end
function c65011018.cgop11(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsType(TYPE_LINK) then
		local atk=tc:GetAttack()
		if atk<tc:GetDefense() then atk=tc:GetDefense() end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
	end
end
function c65011018.cgop21(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsType(TYPE_LINK) then
		local atk=tc:GetAttack()
		if atk>tc:GetDefense() then atk=tc:GetDefense() end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
	end
end
function c65011018.cgfil12(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()and c:GetSummonPlayer()==tp
end
function c65011018.cgtg12(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c65011018.cgfil12,1,nil,tp) end
	Duel.SetTargetCard(eg)
end
function c65011018.cgfil22(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup()and c:GetSummonPlayer()~=tp
end
function c65011018.cgtg22(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c65011018.cgfil22,1,nil,tp) end
	Duel.SetTargetCard(eg)
end
function c65011018.cgop12(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local c=e:GetHandler()
	if tc and tc:IsFaceup() and not tc:IsType(TYPE_LINK) then
		while tc do
			local atk=tc:GetAttack()
		if atk<tc:GetDefense() then atk=tc:GetDefense() end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
		tc=eg:GetNext()
		end
	end
end
function c65011018.cgop22(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local c=e:GetHandler()
	if tc and tc:IsFaceup() and not tc:IsType(TYPE_LINK) then
		while tc do
			local atk=tc:GetAttack()
		if atk>tc:GetDefense() then atk=tc:GetDefense() end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
		tc=eg:GetNext()
		end
	end
end
function c65011018.regops(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetSummonType()==SUMMON_TYPE_SYNCHRO then
		c:RegisterFlagEffect(65011018,RESET_EVENT+0x1ec0000,0,1)
		c:RegisterFlagEffect(0,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(65011018,0))
	end
end
function c65011018.regopns(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetSummonType()~=SUMMON_TYPE_SYNCHRO and c:GetSummonLocation()==LOCATION_EXTRA then
		c:RegisterFlagEffect(89914522,RESET_EVENT+0x1ec0000,0,1)
		c:RegisterFlagEffect(0,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(65011018,1))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(5)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e2:SetValue(ATTRIBUTE_DARK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end

function c65011018.tfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c65011018.sprfilter(c)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c65011018.sprfilter1(c,tp,g,sc)
	local lv=c:GetLevel()
	return c:IsType(TYPE_TUNER) and c:IsAttribute(ATTRIBUTE_DARK) and g:IsExists(c65011018.sprfilter2,1,c,tp,c,sc,lv)
end
function c65011018.sprfilter2(c,tp,mc,sc,lv)
	local sg=Group.FromCards(c,mc)
	return c:GetLevel()==lv-5 and c:GetOriginalLevel()>0 and not c:IsType(TYPE_TUNER)
		and Duel.GetLocationCountFromEx(tp,tp,sg,sc)>0
end
function c65011018.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c65011018.sprfilter,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c65011018.sprfilter1,1,nil,tp,g,c)
end
function c65011018.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c65011018.sprfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=g:FilterSelect(tp,c65011018.sprfilter1,1,1,nil,tp,g,c)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=g:FilterSelect(tp,c65011018.sprfilter2,1,1,mc,tp,mc,c,mc:GetLevel())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST)
end