local m=15000008
local cm=_G["c"..m]
cm.name="人间异物爆炸·砰头小丑"
function cm.initial_effect(c)
	--link summon  
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xf30),2,2)  
	c:EnableReviveLimit()
	--move
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,15000008)
	e1:SetTarget(c15000008.seqtg)
	e1:SetOperation(c15000008.seqop)
	c:RegisterEffect(e1)
	--active
	local e0=Effect.CreateEffect(c)  
	e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)  
	e0:SetCode(EVENT_CHAINING)  
	e0:SetRange(LOCATION_MZONE)  
	e0:SetOperation(aux.chainreg)  
	c:RegisterEffect(e0)  
	local e3=Effect.CreateEffect(c)  
	e3:SetDescription(aux.Stringid(15000008,1))  
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)  
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)  
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)  
	e3:SetCode(EVENT_CHAIN_SOLVING)  
	e3:SetRange(LOCATION_MZONE)  
	e3:SetCountLimit(1,15010008)
	e3:SetTarget(c15000008.tgtg)
	e3:SetCondition(c15000008.lvcon)  
	e3:SetOperation(c15000008.lvop)  
	c:RegisterEffect(e3)
	--atk/def  
	local e4=Effect.CreateEffect(c)  
	e4:SetType(EFFECT_TYPE_FIELD)  
	e4:SetCode(EFFECT_UPDATE_ATTACK)  
	e4:SetRange(LOCATION_MZONE)  
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)  
	e4:SetTarget(c15000008.indtg)  
	e4:SetValue(500)  
	c:RegisterEffect(e4)  
	local e5=e4:Clone()  
	e5:SetCode(EFFECT_UPDATE_DEFENSE)  
	c:RegisterEffect(e5)
end
function c15000008.indtg(e,c)  
	return e:GetHandler():GetLinkedGroup():IsContains(c)  
end
function c15000008.seqfilter(c)  
	local tp=c:GetControler()  
	return c:GetSequence()<5 and c:IsSetCard(0xf30) and Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0  
end  
function c15000008.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)  
	local c=e:GetHandler()  
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c15000008.seqfilter(chkc) end  
	if chk==0 then return Duel.IsExistingTarget(c15000008.seqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end  
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(15000008,1))  
	Duel.SelectTarget(tp,c15000008.seqfilter,tp,LOCATION_MZONE,0,1,1,nil) 
end  
function c15000008.seqop(e,tp,eg,ep,ev,re,r,rp)  
	local tc=Duel.GetFirstTarget()  
	local ttp=tc:GetControler()  
	if not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) or Duel.GetLocationCount(ttp,LOCATION_MZONE,ttp,LOCATION_REASON_CONTROL)<=0 then return end  
	local p1,p2  
	if tc:IsControler(tp) then  
		p1=LOCATION_MZONE  
		p2=0  
	else  
		p1=0  
		p2=LOCATION_MZONE  
	end  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)  
	local seq=math.log(Duel.SelectDisableField(tp,1,p1,p2,0),2)  
	if tc:IsControler(1-tp) then seq=seq-16 end  
	Duel.MoveSequence(tc,seq)  
end
function c15000008.lvcon(e,tp,eg,ep,ev,re,r,rp)  
	return re:IsActiveType(TYPE_FLIP)
end  
function c15000008.spfilter(c,e,tp,zone)  
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE,tp,zone) and c:IsLevelBelow(4)
end
function c15000008.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)  
	local zone=e:GetHandler():GetLinkedZone(tp)  
	if chk==0 then return Duel.IsExistingMatchingCard(c15000008.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,zone) end   
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)  
end
function c15000008.lvop(e,tp,eg,ep,ev,re,r,rp)  
	local zone=e:GetHandler():GetLinkedZone(tp)  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)  
	local sg=Duel.SelectMatchingCard(tp,c15000008.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,zone)  
	if zone~=0 and sg:GetCount()>0 then  
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE,zone)  
		Duel.ConfirmCards(1-tp,sg)  
	end  
end