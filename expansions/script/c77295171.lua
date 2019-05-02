--百绘罗衣·式神 数珠
local m=77295171
local set=0xee7
local cm=_G["c"..m]
function cm.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,m)
	e1:SetCost(cm.lvcost)
	e1:SetTarget(cm.lvtg)
	e1:SetOperation(cm.lvop)
	c:RegisterEffect(e1)
   --spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,77295172)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.activate)
	c:RegisterEffect(e2)
end
	--lv change
function cm.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function cm.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xee7) and c:GetLevel()>0
end
function cm.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and cm.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(cm.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,cm.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local lv=g:GetFirst():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	e:SetLabel(Duel.AnnounceLevel(tp,1,8,lv))
end
function cm.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
   --spsummon
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>1 and Duel.CheckChainUniqueness()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,1000)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		Duel.Damage(tp,1000,REASON_EFFECT,true)
		Duel.Damage(1-tp,1000,REASON_EFFECT,true)
		Duel.RDComplete()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_DECKSHF)
		c:RegisterEffect(e1,true)
	end
end