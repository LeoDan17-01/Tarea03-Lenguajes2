{-|
Module       : Practica2
Description  : 
Copyright    :
Maintainer   : 	Hernández Islas Leonardo Daniel
        	    Olivos Noriega Danna Abigail
Stability    : experimental
Potability   : portable

-}
module Tarea03 where

--Parte 1 Monada Maybe y el operador >>=

--Ejercicio 1

obtenerSaldo :: Int -> Maybe Int
obtenerSaldo = undefined

retirar :: Int -> Int -> Maybe Int
retirar = undefined

-- procesarRetiro :: Int -> Int -> Maybe Int
-- procesarRetiro idCuenta cantidad =
--     case obtenerSaldo idCuenta of
--         Nothing -> Nothing
--         Just saldo ->
--             case retirar saldo cantidad of
--                 Nothing -> Nothing
--                 Just nuevoSaldo -> Just nuevoSaldo

procesarRetiro :: Int -> Int -> Maybe Int
procesarRetiro idCuenta cantidad =
    obtenerSaldo idCuenta >>= \saldo ->
    retirar saldo cantidad

-- calcularInteres :: Int -> Maybe Int
-- calcularInteres idCuenta = do
--     saldo <- obtenerSaldo idCuenta
--     let interes = saldo `div` 10
--     return (saldo + interes) 

calcularInteres :: Int -> Maybe Int
calcularInteres idCuenta = 
    obtenerSaldo idCuenta >>= \saldo ->
    let interes = saldo `div` 10
    in return (saldo + interes)

--Ejercicio 2

sumarSaldos :: Maybe Int -> Maybe Int -> Maybe Int
sumarSaldos mx my = undefined--aqui va codiguin

--Parte II: Generacion de diccionarios

--Ejercicio 3 
-- 1. Definir los records
data EqDict a = EqDict 
    { eq :: a -> a -> Bool 
    }
    -- Agregar campos aquí

data OrdDict a = OrdDict 
    { leq :: a -> a -> Bool
    , eqDict :: EqDict a
    }
    -- Agregar campos aquí

-- 2. Reescribir minimum y estaOrdenada
minimum' :: OrdDict a -> [a] -> a
minimum' dict xs = undefined

estaOrdenada :: OrdDict a -> [a] -> Bool
estaOrdenada dict xs = undefined

-- 3. Construir manualmente ordIntDict
-- Funciones primitivas (asumir que existen)
integerEq :: Int -> Int -> Bool
integerEq = undefined

integerLe :: Int -> Int -> Bool
integerLe = undefined

eqIntDict :: EqDict Int
eqIntDict = undefined

ordIntDict :: OrdDict Int
ordIntDict = undefined

-- Ejercicio 4

-- 1. Definir el record HashableDict
data HashableDict a = HashableDict 
    { hash :: a -> Int
    , eqDictH :: EqDict a
    }
    -- Agregar campos aquí

-- Type aliases para HashMap
type Bucket k v = [(k, v)]
type HashMap k v = [Bucket k v] -- lista de 7 cubetas (índices 0..6)

-- Crea un HashMap vacío con 7 cubetas
emptyMap :: HashMap k v
emptyMap = replicate 7 []

-- 2. Traducir insert y lookup'
insert :: HashableDict k -> k -> v -> HashMap k v -> HashMap k v
insert dict k v m = undefined

lookup' :: HashableDict k -> k -> HashMap k v -> Maybe v
lookup' dict k m = undefined

-- 3. Construir manualmente hashableIntDict
hashableIntDict :: HashableDict Int
hashableIntDict = undefined