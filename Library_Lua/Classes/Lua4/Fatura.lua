Fatura = settag({}, newtag())

settagmethod(tag(Fatura), "gettable", 
	function(t,k)
		if rawget(%Fatura,k) then
			return rawget(%Fatura,k)
		else
			return rawget(t,k)
		end
	end 
)

function Fatura:new(codigoDeBarras, valorFatura, vencimentoFatura)	

	codigoDeBarras   = codigoDeBarras   or ""
	valorFatura      = valorFatura      or ""
	vencimentoFatura = vencimentoFatura or ""


	local t = {
		codigoDeBarras  = codigoDeBarras,  valorFatura   = valorFatura, 
		vencimentoFatura = vencimentoFatura, fechouAcordo  = "false", statusClient = "INI", 
	}
	
	settag(t, tag(Fatura))
	
	return t

end

-------------------------
-------- SETTERS --------
-------------------------

-- @method: setCodigoDeBarras
-- @description: atualiza o valor do codigo de barras do cliente
function Fatura:setCodigoDeBarras(codigoDeBarras)
	self.codigoDeBarras = codigoDeBarras
end

-- @method: setValorFatura
-- @description: atualiza o valor monetário da fatura do cliente
unction Fatura:setValorFatura(valorFatura)
	self.valorFatura = valorFatura
end

-- @method: setVencimentoFatura
-- @description: atualiza a data de vencimento do cliente do cliente.
--              Todo o tramanto de formato de data válido deve ser feito
--              fora desta classe.
--              O padrão esperado é dd/mm/yyyy
function Fatura:setVencimentoFatura(vencimentoFatura)
	self.vencimentoFatura = vencimentoFatura

    local day, month, year = strfind(vencimentoFatura, "(%d+)/(%d+)/(%d+)")

    self.setDiaVencimento(day)
    self.setMesVencimento(month)
    self.setAnoVencimento(year)

end

-- @method: setDiaVencimento
-- @description: atualiza o dia de vencimento da fatura do cliente
function Fatura:setDiaVencimento(diaVencimento)
	self.diaVencimento = diaVencimento
end

-- @method: setMesVencimento
-- @description: atualiza o mês de vencimento da fatura do cliente
function Fatura:setMesVencimento(mesVencimento)
	self.mesVencimento = mesVencimento
end

-- @method: setAnoVencimento
-- @description: atualiza o ano de vencimento da fatura do cliente
function Fatura:setAnoVencimento(anoVencimento)
	self.anoVencimento = anoVencimento
end

-- @method: setStatusClient
-- @description: atualiza o status da fatura
function Fatura:setStatusClient(statusClient)
	self.statusClient = statusClient
end

-------------------------
-------- GETTERS --------
-------------------------

-- @method: getCodigoDeBarras
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getCodigoDeBarras()
	return self.codigoDeBarras
end

-- @method: getValorFatura
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getValorFatura()
	return self.valorFatura
end

-- @method: getVencimentoFatura
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getVencimentoFatura()
	return self.vencimentoFatura
end

-- @method: getDiaVencimento
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getDiaVencimento()
	return self.diaVencimento
end

-- @method: getMesVencimento
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getMesVencimento()
	return self.mesVencimento
end

-- @method: getAnoVencimento
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getAnoVencimento()
	return self.anoVencimento
end

-- @method: getStatusClient
-- @description: retorna o valor do codigo de barras do cliente
function Fatura:getStatusClient()
	return self.statusClient
end

-------------------------
-------- LIBRARY --------
-------------------------

function Fatura:diasEmAtraso()
	local anoAtual = Date("%Y")
	local mesAtual = Date("%m")
	local diaAtual = Date("%d")
    local diasAtraso = ""
end