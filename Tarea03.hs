module Tarea03 where

--Parte 1 Monada Maybe y el operador >>=

obtenerSaldo :: Int -> Maybe Int
obtenerSaldo = undefined

retirar :: Int -> Int -> Maybe Int
retirar = undefined

procesarRetiro :: Int -> Int -> Maybe Int
procesarRetiro idCuenta cantidad =
    case obtenerSaldo idCuenta of
        Nothing -> Nothing
        Just saldo ->
            case retirar saldo cantidad of
                Nothing -> Nothing
                Just nuevoSaldo -> Just nuevoSaldo

calcularInteres :: Int -> Maybe Int
calcularInteres idCuenta = do
    saldo <- obtenerSaldo idCuenta
    let interes = saldo `div ` 10
    return (saldo + interes) 