--秘密彩恋 镜花少女
function c65050253.initial_effect(c)
	 --link summon
	aux.AddLinkProcedure(c,nil,2,2,c65050253.lcheck)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65050253,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65050254)
	e1:SetCost(c65050253.cost)
	e1:SetTarget(c65050253.target)
	e1:SetOperation(c65050253.activate)
	c:RegisterEffect(e1)
	 --flover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65050253,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050253)
	e2:SetTarget(c65050253.flvtg)
	e2:SetOperation(c65050253.flvop)
	c:RegisterEffect(e2)
end
function c65050253.costfil(c,tp)
	return c:IsReleasable() and c:GetOwner()~=tp
end
function c65050253.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050253.costfil,tp,LOCATION_MZONE,0,1,nil,tp) end
	local g=Duel.SelectMatchingCard(tp,c65050253.costfil,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c65050253.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c65050253.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c65050253.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9da9)
end
function c65050253.flvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)>0 and Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
	Duel.SetChainLimit(aux.FALSE)
end
function c65050253.flvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsPlayerCanSpecialSummon(tp) and Duel.GetMZoneCount(tp)>0 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)>0 then
	   local g=Duel.GetMatchingGroup(Card.IsCanBeSpecialSummoned,1-tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,0,tp,false,false,POS_FACEUP,tp)
	   local sg=g:Select(1-tp,1,1,nil)
			if #sg>0 then
				local tc=sg:GetFirst()
				if tc:IsFaceup() then
					Duel.HintSelection(sg)
				else
					Duel.ConfirmCards(tp,tc)
				end
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
			Duel.ShuffleDeck(1-tp)
	end
end