local palavra = {
    x = 100,
    y = 0,
    texto = "hello",
    controleTexto = {0, 0, 0, 0, 0},
    posicaoTextoValida = 1
}

function love.update()
    palavra.y = palavra.y + 1
    if palavra.y == 600 then
        palavra.y = 0
    end
end

function love.draw()
    for i = 1, string.len( palavra.texto ) do
        love.graphics.setColor(255,255,255)
        if(palavra.controleTexto[i] == 1) then
            love.graphics.setColor(255,0,0)
        end
        love.graphics.print(string.upper(string.sub(palavra.texto, i, i)), palavra.x + (i * 20), palavra.y,0,2)
    end
end

function love.keypressed(key)
    if key == string.sub(palavra.texto, palavra.posicaoTextoValida, palavra.posicaoTextoValida) then
        palavra.controleTexto[palavra.posicaoTextoValida] = 1
        palavra.posicaoTextoValida = palavra.posicaoTextoValida + 1
    end
end