-- ____                      _   _                           
-- | __ ) _   _ ___  ___ __ _| \ | | ___  _ __ ___   ___  ___ 
-- |  _ \| | | / __|/ __/ _` |  \| |/ _ \| '_ ` _ \ / _ \/ __|
-- | |_) | |_| \__ \ (_| (_| | |\  | (_) | | | | | |  __/\__ \
-- |____/ \__,_|___/\___\__,_|_| \_|\___/|_| |_| |_|\___||___/ v.1.0.0

-- @author: Joao Vitor Oliveira dos Santos
-- @description: Arquivo dedicado a busca de nomes homofonos, voltado a audios nomeados no padrao Nome.wav
-- @main function: findAnnouncerPrompts
-- @main parameters:    name: nome
--                      prefix: "com " ou "" (em casos de "eu falo com..." ou "É o/a...")
--                      pastaNomes: path em que os áudios se encontram





-- @function: findAnnouncerPrompts()
-- @author: Joao Vitor Oliveira
-- @dependences:
--      isVogal(): BuscaNomes.lua
--      validateFindNamePromptFile(): BuscaNomes.lua
-- @description:	
--		busca o prompt de nome a partir dos nomes homofonos (mesma pronuncia)
function findAnnouncerPrompts(name, prefix, pastaNOMES)

    local name = strlower(name)
    local fileCount = nil
    local prefix = prefix
    local prompt = ""
    local firstLetter = strsub(name, 0, 1)
    local lastLetter = strsub(name, strlen(name))
    local TNomesHomofonos = {}
    local primeiraLetraMaiuscula = "1" --1: sim | 0: não


    if(primeiraLetraMaiuscula == "1") then
        firstLetter = strupper(firstLetter)
        name = firstLetter..strsub(name, 2, strlen(name))
    end

    ----------------------------------------------------------------------

    tinsert(TNomesHomofonos, name) 

    -------------BUSCA DE AUDIOS DE NOMES HOMOFONOS------------------------
    vLog("--------------------------------------------------------")
    vLog("- BUSCA DE AUDIOS DE NOMES HOMOFONOS (mesma pronuncia) -")
    vLog("--------------------------------------------------------")

    if( isVogal(firstLetter)) then
 
	    local nameTest = "h" .. name

        tinsert(TNomesHomofonos, nameTest)
        
    end

    if(not isVogal(firstLetter) and isVogal(strsub(name, 2, 2))) then
        --adiciona um h entre a consoante e a vogal no inicio do nome

        local nameTest = firstLetter.. "h"..strsub(name, 2, strlen(name))

        tinsert(TNomesHomofonos, nameTest)

    elseif(not isVogal(firstLetter) and strsub(name, 2, 2) == "h" and isVogal(strsub(name, 3, 3))) then
        --remove o h entre a consoante e a vogal no inicio do nome

        local nameTest = firstLetter..strsub(name, 3, strlen(name))

        tinsert(TNomesHomofonos, nameTest)
    end

    if(firstLetter == "i") then
        --troca o "I" por "Y" na letra inicial e faz a busca

        local nameTest = "y"..strsub(name, 2, strlen(name))

        tinsert(TNomesHomofonos, nameTest)

    elseif(firstLetter == "y") then
        --troca o "Y" por "I" na letra inicial e faz a busca

        local nameTest = "i"..strsub(name, 2, strlen(name))

        tinsert(TNomesHomofonos, nameTest)
    end

    if(firstLetter == "k") then
        --troca o "K" por "C" na letra inicial e faz a busca

        local nameTest = "c"..strsub(name, 2, strlen(name))

        tinsert(TNomesHomofonos, nameTest)

    elseif(firstLetter == "c") then
        --troca o "C" por "K" na letra inicial e faz a busca

        local nameTest = "k"..strsub(name, 2, strlen(name))

        tinsert(TNomesHomofonos, nameTest)
    end

    if(lastLetter == "m") then
        --troca o "M" por "N" na letra final e faz a busca

        local nameTest = strsub(name, 0, strlen(name)-1).."n"

        tinsert(TNomesHomofonos, nameTest)

    elseif(lastLetter == "n") then
        --troca o "N" por "M" na letra final e faz a busca

        local nameTest = strsub(name, 0, strlen(name)-1).."m"

        tinsert(TNomesHomofonos, nameTest)
    end

    dump(TNomesHomofonos)

    for i = 1, getn(TNomesHomofonos) do 
        local path = pastaNOMES..prefix..TNomesHomofonos[i]..".wav"

		if(validateFindNamePromptFile(path) ~= "") then return path end
	end

    TScript.contPassagemPeloFinder = TScript.contPassagemPeloFinder + 1

    if(not prompt and TScript.contPassagemPeloFinder == 1) then -- RETORNA O NOME PARA A findAnnouncerPrompts(), AGORA ANALISANDO LETRAS DUPLICADAS
        nome = removerLetrasDuplicadas(valores)
        prefix = ""

        return findAnnouncerPrompts(name, prefix, pastaNOMES)

    end

    return nil

end

-- @function: validateFindNamePromptFile()
-- @author: Joao Vitor Oliveira
-- @dependences:
--      FuncaoDeBuscaArquivo
-- @description:	
--		busca apenas para audios de nomes
function validateFindNamePromptFile(prompt)
    local fileCountName = FuncaoDeBuscaArquivo(prompt) --nao implementada pois depende da linguagem compilada que o Lua esta
                                                       --se comunicando

    if(fileCountName >= 1) then
        return prompt
    end

    return ""
end

--Descição: Remove letras duplicadas de um nome
--@param nome string
--@return string
function removerLetrasDuplicadas(nome)
    local novoNome = nome
    for i = 2, strlen(nome), 1 do
        if(strsub(nome,i,i) == strsub(nome,i-1,i-1) and strsub(nome,i,i) ~= "s" and strsub(nome,i,i) ~= "r")then
            local letra = strsub(nome,i,i)
            novoNome = gsub(novoNome,(letra..letra),letra)
        end
    end
    return novoNome
    
end

function isVogal(letter)
    if( letter == "a" or 
        letter == "e" or 
        letter == "i" or 
        letter == "o" or 
        letter == "u" or 
        letter == "y") then

        return "true"
    end

    return nil
end

-- @function: verificaVariavel()
-- @author: Joao Vitor Oliveira
-- @dependences:
-- @description:	
--      Esta funnco serve para verificar se uma variavel existe dentro de uma tabela. Principalmente para os casos
-- 		em que ha tabelas dentro de tabelas ate chegar na variavel desejada
--      Entrada: primeiro parametro e a variavel do tipo tabela que possui a variavel que deseja ser verificada
--		    segundo parametro e uma string, especificando o caminho ate chegar na variavel desejada
--      Saida: 	O valor da variavel - para quando ela existe
-- 	        nil - para quando nao existe
function verificaVariavel(T, sPath)
	
	-- verifica se os parametros sao validos
	if (type(T) == "string" or type(T) == "number") then
		-- retorna 1 pois se o tipo de T for string ou number, entao ja e uma variavel valida
		return T
	elseif (type(T) ~= "table") then
		return nil
	elseif (type(sPath) ~= "string") then
		return nil
	else
	-- a partir daqui os parametros podem ser trabalhados
		sPath = gsub(sPath, "%]","") -- Remove qualquer ] para facilitar a leitura do strsplit
		sPath = gsub(sPath, "%[", ".") -- Altera qualquer [ para .
		local TCaminho = strsplit(sPath, ".")
		local tamanho = getn(TCaminho)
		local ponteiroT = T
		for i=1, tamanho do
		
			if (tonumber(TCaminho[i])) then
				ponteiroT = ponteiroT[tonumber(TCaminho[i])] or ponteiroT[TCaminho[i]]
			else
				ponteiroT = ponteiroT[TCaminho[i]]
			end
			
			if not (ponteiroT) then
				return nil
			end
		end
		-- Se chegou aqui quer dizer que todo o caminho e valido
		return ponteiroT	
	end
end

-- @function: strsplit()
-- @author: Joao Vitor Oliveira
-- @dependences:
-- @description:	
--      Divide a string 'str' em partes separadas pelo caractere 'char' e retorna uma
--      tabela com essas partes

function strsplit(str, char)
    local s = 0
    local m, e
    local t = {}
    local pat = '([^'..char..']+)'..char..'?'

    repeat
        s, e, m = strfind(str, pat, s+1)
        if (s) then
            tinsert(t, m)
        end
        s = e
    until (not s)

    return t
end