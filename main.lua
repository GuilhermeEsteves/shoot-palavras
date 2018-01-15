function love.load()
    janelaJogo = {x = love.graphics.getWidth(), y = love.graphics.getHeight()}
    palavraAtual = 1
    palavras = {}
    jogador = {
        pontuacao = 0,
        vida = 4
    }
    carregaPalavras()
end

function love.update()
    if terminouJogo() then
        return
    end

    palavras[palavraAtual].y = palavras[palavraAtual].y + 5
    if palavras[palavraAtual].y == 600 then
        palavraAtual = palavraAtual + 1
        jogador.vida = jogador.vida - 1
        if terminouJogo() then
            return
        end
    end

    --Verifica se toda a palavra ja foi digitada e passa para a palavra seguinte
    if palavras[palavraAtual].posicaoTextoValida > string.len(palavras[palavraAtual].texto) then
        palavraAtual = palavraAtual + 1
        jogador.pontuacao = jogador.pontuacao + 1
    end
end

function love.draw()
    atualizaDadosJogador()

    if terminouJogo() then
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("***** Fim de Jogo :) *****", janelaJogo.x - 650, 275, 0, 2)
        return
    end

    for i = 1, string.len(palavras[palavraAtual].texto) do
        love.graphics.setColor(255, 255, 255)
        if (palavras[palavraAtual].controleTexto[i] == 1) then
            love.graphics.setColor(255, 0, 0)
        end
        love.graphics.print(
            string.upper(string.sub(palavras[palavraAtual].texto, i, i)),
            palavras[palavraAtual].x + (i * 20),
            palavras[palavraAtual].y,
            0,
            2
        )
    end
end

function love.keypressed(key)
    if terminouJogo() then
        return
    end

    if
        key ==
            string.sub(
                palavras[palavraAtual].texto,
                palavras[palavraAtual].posicaoTextoValida,
                palavras[palavraAtual].posicaoTextoValida
            )
     then
        palavras[palavraAtual].controleTexto[palavras[palavraAtual].posicaoTextoValida] = 1
        palavras[palavraAtual].posicaoTextoValida = palavras[palavraAtual].posicaoTextoValida + 1
    end
end

function terminouJogo()
    return palavraAtual > table.getn(palavras) or jogador.vida == 0
end

function atualizaDadosJogador()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Vida:", janelaJogo.x - 205, 10, 0, 1)

    love.graphics.setColor(255, 0, 0)
    for i = 1, jogador.vida do
        for j = 1, 4 do
            love.graphics.print("*", janelaJogo.x - 180 + (i * 10), 10, 0, 1.5)
        end
    end

    love.graphics.setColor(255, 255, 255)
    love.graphics.print(string.format("Pontuação: %s", jogador.pontuacao), janelaJogo.x - 100, 10, 0, 1)
end

function carregaPalavras()
    for palavra in love.filesystem.lines("palavras.txt") do
        p = {
            x = janelaJogo.x - 600,
            y = 0,
            texto = palavra,
            controleTexto = {},
            posicaoTextoValida = 1
        }

        for i = 1, string.len(palavra) do
            table.insert(p.controleTexto, 0)
        end

        table.insert(palavras, p)
    end
end
