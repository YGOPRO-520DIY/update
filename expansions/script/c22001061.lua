--从者Avenger 织田信长·天下布武
function c22001060.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,4)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22001060,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c90884403.sptg)
	e1:SetOperation(c90884403.spop)
	c:RegisterEffect(e1)
end
