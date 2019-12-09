--灵魂鸟-重明鸟
function c600067.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)	
	--summon with s & t
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(600067,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c600067.otcon)
	e2:SetOperation(c600067.otop)
	e2:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e2) 
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e7:SetCondition(c600067.dircon)
	c:RegisterEffect(e7)
	--summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(600067,2))
	e4:SetCategory(CATEGORY_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c600067.sumcon)
	e4:SetTarget(c600067.sumtg)
	e4:SetOperation(c600067.sumop)
	c:RegisterEffect(e4)
end
function c600067.otfilter(c)
	return c:IsType(TYPE_SPIRIT) and c:IsAttribute(ATTRIBUTE_WIND) and c:IsRace(RACE_WINDBEAST) and c:GetLevel()==4 and c:IsReleasable()
end
function c600067.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c600067.otfilter,tp,LOCATION_DECK,0,nil)
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg:GetCount()>=2)
		or (Duel.CheckTribute(c,1) and mg:GetCount()>=1)
end
function c600067.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c600067.otfilter,tp,LOCATION_DECK,0,nil)
	local ct=2
	local g=Group.CreateGroup()
	if Duel.GetTributeCount(c)<ct then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=mg:Select(tp,ct-Duel.GetTributeCount(c),ct-Duel.GetTributeCount(c),nil)
		g:Merge(g2)
		mg:Sub(g2)
		ct=ct-g2:GetCount()
	end
	if ct>0 and Duel.GetTributeCount(c)>=ct and mg:GetCount()>0
		and (g:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(600067,1))) then
		local ect=ct
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then ect=ect-1 end
		ect=math.min(mg:GetCount(),ect)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g3=mg:Select(tp,1,ect,nil)
		g:Merge(g3)
		ct=ct-g3:GetCount()
	end
	if ct>0 then
		local g4=Duel.SelectTribute(tp,c,ct,ct)
		g:Merge(g4)
	end
	c:SetMaterial(g)
	Duel.Remove(g,POS_FACEUP,REASON_SUMMON+REASON_MATERIAL)
end
function c600067.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c600067.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsSummonable(true,nil,1) or c:IsMSetable(true,nil,1) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,c,1,0,0)
end
function c600067.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local pos=0
	if c:IsSummonable(true,nil,1) then pos=pos+POS_FACEUP_ATTACK end
	if c:IsMSetable(true,nil,1) then pos=pos+POS_FACEDOWN_DEFENCE end
	if pos==0 then return end
	if Duel.SelectPosition(tp,c,pos)==POS_FACEUP_ATTACK then
		Duel.Summon(tp,c,true,nil,1)
	else
		Duel.MSet(tp,c,true,nil,1)
	end
end
function c600067.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end