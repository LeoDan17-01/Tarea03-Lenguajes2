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
sumarSaldos mx my = mx >>= \x -> my >>= \y -> return (x + y)

--Parte II: Generacion de diccionarios

--Ejercicio 3 

-- 1. Definir los records
data EqDict a = EqDict 
    { eq :: a -> a -> Bool 
    }

data OrdDict a = OrdDict 
    { leq :: a -> a -> Bool
    , eqDict :: EqDict a
    }

-- 2. Reescribir minimum y estaOrdenada
minimum' :: OrdDict a -> [a] -> a
minimum' x [] = error "No hay minimo"
minimum' _ [x] = x
minimum' dict (x:y:xs) 
                    | leq dict x y = minimum' dict (x:xs)
                    | True = minimum' dict (y:xs)

estaOrdenada :: OrdDict a -> [a] -> Bool
estaOrdenada _ [] = True
estaOrdenada _ [_] = True 
--Nota habia puesto _ _ lo que daba siempre True 
estaOrdenada dict (x:y:xs)
                    | leq dict x y = estaOrdenada dict (y:xs)
                    | True = False 

-- 3. Construir manualmente ordIntDict
-- Funciones primitivas (asumir que existen)
integerEq :: Int -> Int -> Bool
integerEq = (==)

integerLe :: Int -> Int -> Bool
integerLe = (<=)

eqIntDict :: EqDict Int
eqIntDict = EqDict {
    eq = integerEq
}

ordIntDict :: OrdDict Int
ordIntDict = OrdDict {
    leq = integerLe
    , eqDict = eqIntDict
}

--Ejercicio 4

--1. Definir el record HashableDict
data HashableDict a = HashableDict 
    { hashH :: a -> Int
    , eqDictH :: EqDict a
    }

-- Type aliases para HashMap
type Bucket k v = [(k, v)]
type HashMap k v = [Bucket k v] -- lista de 7 cubetas (índices 0..6)

-- Crea un HashMap vacío con 7 cubetas
emptyMap :: HashMap k v
emptyMap = replicate 7 []

-- 2. Traducir insert y lookup'
insert :: HashableDict k -> k -> v -> HashMap k v -> HashMap k v
insert dict k v m = 
    let idx = (hashH dict k) `mod` 7
        bucket = m !! idx
        bucket' = removeKey (eqDictH dict) k bucket
    in take idx m ++ [(k, v) : bucket'] ++ drop (idx + 1) m
  where
    removeKey :: EqDict k -> k -> Bucket k v -> Bucket k v
    removeKey _ _ [] = []
    removeKey eqDict' key ((k', v'):bs)
        | eq eqDict' key k' = bs
        | otherwise = (k', v') : removeKey eqDict' key bs

lookup' :: HashableDict k -> k -> HashMap k v -> Maybe v
lookup' dict k m = 
    let idx = (hashH dict k) `mod` 7
        bucket = m !! idx
    in findKey (eqDictH dict) k bucket
  where
    findKey :: EqDict k -> k -> Bucket k v -> Maybe v
    findKey _ _ [] = Nothing
    findKey eqDict' key ((k', v'):bs)
        | eq eqDict' key k' = Just v'
        | otherwise = findKey eqDict' key bs
-- 3. Construir manualmente hashableIntDict
integerMod :: Int -> Int
integerMod x = x `mod` 7

hashableIntDict :: HashableDict Int
hashableIntDict = HashableDict {
    hashH = integerMod,
    eqDictH = eqIntDict
}

-- 4. Verificar que funciona
testHashMap :: Maybe String
testHashMap = 
    let m = emptyMap :: HashMap Int String
        m' = insert hashableIntDict 42 "cuarenta y dos" m
    in lookup' hashableIntDict 42 m'