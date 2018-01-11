local palavraAtual = 1
local palavras = {
    {
        x = 150,
        y = 0,
        texto = "hello",
        controleTexto = {0, 0, 0, 0, 0},
        posicaoTextoValida = 1
    },
    {
        x = 150,
        y = 0,
        texto = "camelo",
        controleTexto = {0, 0, 0, 0, 0, 0},
        posicaoTextoValida = 1
    },
    {
        x = 150,
        y = 0,
        texto = "laranja",
        controleTexto = {0, 0, 0, 0, 0, 0, 0},
        posicaoTextoValida = 1
    },
    {
        x = 150,
        y = 0,
        texto = "melancia",
        controleTexto = {0, 0, 0, 0, 0, 0, 0, 0},
        posicaoTextoValida = 1
    }
}

function love.update()
    if terminouJogo() then
        return
    end

    palavras[palavraAtual].y = palavras[palavraAtual].y + 1
    if palavras[palavraAtual].y == 600 then
        palavras[palavraAtual].y = 0
    end

    --Verifica se toda a palavra ja foi digitada e passa para a palavra seguinte
    if palavras[palavraAtual].posicaoTextoValida > string.len(palavras[palavraAtual].texto) then
        palavraAtual = palavraAtual + 1
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(string.format("Pontuação: %s", palavraAtual - 1), 700, 550, 0, 1)

    if terminouJogo() then
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("***** Fim de Jogo :) *****", 250, 275, 0, 2)
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
    return palavraAtual > table.getn(palavras)
end