--神装-幻想血统
local m=2052
local cm=_G["c"..m]
function cm.initial_effect(c)
	rsfv.GraveRemovefun(c)
	rsfv.EquipFun(c)
	--dice2
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return e:GetHandler():GetEquipTarget() and Duel.IsExistingMatchingCard(cm.cfilter,tp,LOCATION_EXTRA,0,1,nil) end)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)	 
end
function cm.cfilter(c)
	return c:IsSetCard(0x299) and c:IsType(TYPE_FUSION)
end
function cm.operation(e,tp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) or not ec or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local d=Duel.TossDice(tp,1)
	local g=Duel.GetMatchingGroup(cm.cfilter,tp,LOCATION_EXTRA,0,nil)
	if d>#g then return end 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tg=g:Select(tp,d,d,nil)
	Duel.ConfirmCards(1-tp,tg)
	if #tg>1 then
		tg=tg:RandomSelect(tp,1)
		Duel.ConfirmCards(1-tp,tg)
	end
	local tc=tg:GetFirst()
	local code=rsfv.codelist[tc:GetOriginalCode()]
	local cid=ec:CopyEffect(code,RESET_EVENT+RESETS_STANDARD)
	ec:SetHint(HINT_CARD,code)
	Duel.BreakEffect()
	if not Duel.Equip(tp,tc,ec,true) then return end
	local e1=Effect.CreateEffect(ec)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(cm.eqlimit)
	tc:RegisterEffect(e1)
	Duel.BreakEffect()
	Duel.Destroy(c,REASON_EFFECT)
end
function cm.eqlimit(e,c)
	return e:GetOwner()==c
end
