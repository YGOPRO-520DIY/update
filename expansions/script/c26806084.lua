--魔法少女·诗岸
function c26806084.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c26806084.matfilter,c26806084.mbtfilter,true)   
end
function c26806084.matfilter(c)
	return c:IsAttack(2200) and c:IsDefense(600)
end
function c26806084.mbtfilter(c)
	return c:IsAttack(3200) and c:IsFusionType(TYPE_LINK)
end