--星曜圣装
function c21520155.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21520155,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c21520155.target)
	e1:SetOperation(c21520155.operation)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21520155,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCountLimit(1)
	e2:SetCondition(c21520155.thcon)
	e2:SetTarget(c21520155.thtg)
	e2:SetOperation(c21520155.thop)
	c:RegisterEffect(e2)
end
function c21520155.rfilter(c,e,tp)
	return c:IsAbleToRemove() and c:IsSetCard(0x491) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(8) 
		and Duel.IsExistingMatchingCard(c21520155.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,c,e,tp)
end
function c21520155.spfilter(c,rc,e,tp)
	if c:IsLocation(LOCATION_EXTRA) then 
		return aux.IsCodeListed(c,rc:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0xa491) and Duel.GetLocationCountFromEx(tp)>0 
	elseif c:IsLocation(LOCATION_GRAVE) then 
		return aux.IsCodeListed(c,rc:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0xa491) and Duel.GetMZoneCount(tp,lc)>0 end
end
function c21520155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_NUMBER)
	local ac=Duel.AnnounceLevel(tp,1,math.min(8,Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)))
	e:SetLabel(ac)
--	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c21520155.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=e:GetLabel()
	local dct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local ct=math.min(ac,dct)
	local g=Duel.GetDecktopGroup(tp,ct)
	Duel.ConfirmDecktop(tp,ct)
	if g:IsExists(c21520155.rfilter,1,nil,e,tp) then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=g:FilterSelect(tp,c21520155.rfilter,1,1,nil,e,tp)
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		local exg=Duel.GetMatchingGroup(c21520155.spfilter,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,nil,rg:GetFirst(),e,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=exg:Select(tp,1,1,nil)
		if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)>0 then 
			sg:GetFirst():CompleteProcedure()
			Duel.ShuffleDeck(tp)
		else 
			Duel.Damage(tp,ac*1000,REASON_RULE)
		end
	else 
		Duel.Damage(tp,ac*1000,REASON_RULE)
	end
end
function c21520155.effectfilter(c)
	return c:IsCode(21520133) and c:IsFaceup() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c21520155.thfilter(c)
	return c:IsSetCard(0xa491) and c:IsType(TYPE_MONSTER)
end
function c21520155.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21520155.effectfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
		and eg:IsExists(c21520155.thfilter,1,nil)
end
function c21520155.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c21520155.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then 
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
