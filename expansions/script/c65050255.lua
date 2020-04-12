--憧憬彩恋 雪翼少女
function c65050255.initial_effect(c)
	 --link summon
	aux.AddLinkProcedure(c,nil,2,2,c65050255.lcheck)
	c:EnableReviveLimit()
	--peffect
	 local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,65050255)
	e1:SetTarget(c65050255.ptg)
	e1:SetOperation(c65050255.pop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,65050256)
	e2:SetCondition(c65050255.spcon)
	e2:SetTarget(c65050255.sptg)
	e2:SetOperation(c65050255.spop)
	c:RegisterEffect(e2)
end
function c65050255.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9da9)
end
function c65050255.cfilter(c,tp)
	return c:IsFaceup() and c:GetOwner()~=tp and c:IsControler(tp)
end
function c65050255.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c65050255.cfilter,1,nil,tp)
end
function c65050255.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c65050255.spop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function c65050255.ptgfil(c,e,tp)
	return c:IsSetCard(0x9da9) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c65050255.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65050255.ptgfil,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c65050255.pop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c65050255.ptgfil,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end