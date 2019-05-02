--憧憬的舞台
function c81019011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,81019011+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c81019011.activate)
	c:RegisterEffect(e1)
	--Draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81019011,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1,81019811)
	e2:SetCondition(c81019011.drcon)
	e2:SetTarget(c81019011.drtg)
	e2:SetOperation(c81019011.drop)
	c:RegisterEffect(e2)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81019011,2))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1,81019811)
	e3:SetCondition(c81019011.drcon)
	e3:SetTarget(c81019011.drtg2)
	e3:SetOperation(c81019011.drop)
	c:RegisterEffect(e3)
	--ritural
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,81019911)
	e4:SetCondition(aux.exccon)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(c81019011.sptg)
	e4:SetOperation(c81019011.spop)
	c:RegisterEffect(e4)
end
function c81019011.thfilter(c)
	return c:IsSetCard(0xfb) and c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAbleToHand()
end
function c81019011.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c81019011.thfilter,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(81019011,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end
function c81019011.drcfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xfb)
end
function c81019011.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c81019011.drcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c81019011.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c81019011.drtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c81019011.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c81019011.spfilter(c,e,tp,m,ft)
	if not c:IsCode(81019012) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m:Filter(Card.IsCanBeRitualMaterial,c,c)
	if ft>0 then
		return mg:CheckWithSumEqual(Card.GetRitualLevel,8,1,99,c)
	else
		return mg:IsExists(c81019011.mfilterf,1,nil,tp,mg,c)
	end
end
function c81019011.mfilterf(c,tp,mg,rc)
	if c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5 then
		Duel.SetSelectedCard(c)
		return mg:CheckWithSumEqual(Card.GetRitualLevel,8,0,99,rc)
	else return false end
end
function c81019011.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp):Filter(Card.IsSetCard,nil,0xfb)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		return ft>-1 and Duel.IsExistingMatchingCard(c81019011.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,mg,ft)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c81019011.spop(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetRitualMaterial(tp):Filter(Card.IsSetCard,nil,0xfb)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81019011.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg,ft)
	local tc=g:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		local mat=nil
		if ft>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
			mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,8,1,99,tc)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
			mat=mg:FilterSelect(tp,c81019011.mfilterf,1,1,nil,tp,mg,tc)
			Duel.SetSelectedCard(mat)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
			local mat2=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,8,0,99,tc)
			mat:Merge(mat2)
		end
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
