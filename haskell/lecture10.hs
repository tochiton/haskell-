import Data.Char
-- In this lecture we'll be learning about Haskell.
-- I'm a big believer in learning by doing, 
-- so we're actually going to write programs today.
-- 
-- In this lecture you'll learn
--   * what a functional program is
--   * syntax of Haskell
--   * everything's a function
--   * types in haskell
-- 
-- so, let's get started.
-- You can run this file with
-- 
-- > hugs lecture10.hs
-- 
-- Which will give you the prompt
-- 
-- __   __ __  __  ____   ___      _________________________________________
-- ||   || ||  || ||  || ||__      Hugs 98: Based on the Haskell 98 standard
-- ||___|| ||__|| ||__||  __||     Copyright (c) 1994-2005
-- ||---||         ___||           World Wide Web: http://haskell.org/hugs
-- ||   ||                         Bugs: http://hackage.haskell.org/trac/hugs
-- ||   || Version: September 2006 _________________________________________
-- 
-- Hugs mode: Restart with command line option +98 for Haskell 98 mode
-- 
-- Hugs> 
-- 
-- you can type expressions on the line
-- Hugs> 
-- 
-- Let's try writing a few expression.

test1 = 3 + 4
test2 = (2 + 2) / 4
test3 = (-3 + (sqrt (3^2 - 4*1*2))) / (2*1)

-- Syntax note:  We don't call functions with f(x)
-- we call function with
-- f x
-- If we have more than one parameter, then its
-- f x y
-- If it's not clear how the function should be called
-- f takes two parameters, and g takes 1
-- then we use parentheses to group
-- f (g x) y
-- 
-- f g x y 
-- means apply f to 3 parameters, g x and y
-- 
-- Ok, so we have a calculator.
-- That's useful, but not any better than Python.
-- What makes Haskell different?
-- 
-- Haskell is a functional programming language.
-- That means, at it's core, everything is a function.
-- 
-- sqrt is a function that takes floating point number, and returns a floating point number.
-- But, 4 is a function that takes no arguments, and returns 4.
-- The power of functional programming comes by recognizing that we can compose these functions.
-- 
-- Great, so how do we define functions?
-- We use the syntax
-- 
-- functionName param1 param2 ... = expression
-- so, the identity funciton is defined as
-- 
-- id x = x
-- 
-- Let's try defining some functions

double x = undefined
square x = undefined

-- quadfrom 1 3 2 should be the same as test3
quadFrom a b c = undefined

--Great, now I can define simple function, what can I do with them.
--Well, we can compose them.

squareDouble1 x = square (double x)

-- This idea of building up larger functions from smaller functions is the basis of functional programming.
-- 
-- Ok, but still, what makes functional programming different then python?
-- 
-- Well, there are two major differences
-- 1. we can pass a function as a parameter
-- 2. we can return a function
-- 
-- With these two ideas a function acts just like any other variable or literal.
-- So, we say that a function is a *first class value* in a functional language.
-- 
-- Ok, so let's see this in action.
-- I want a more general double function.
-- Now it should be able to multiply by any number

multiply n = \x -> n * x

--multiply takes an n, and returns a lambda function. (\ is supposed to look like lambda)
--This lambda function just multiplies its argument by n.
--We should test this out.

by3 = multiply 3
by6 = multiply 6

--Ok, so let's go back to our function composition
--we wrote squareDouble as
--
--squareDouble1 x = square (double x)
--
--What if we wanted to compose any two functions
--
--we could do something like this

compose f g = \x -> f g x

squareDouble2 = compose square double

-- Now, we have made a new function out of old ones.
-- Furthermore, we didn't even know wnything about the old functions.
-- We didn't mention any arguments, or return values.
-- We just said "compose these two functions", and it worked.
-- 
-- This idea of function composition is so important that haskell has a special operator for it.
--
-- f . g = \x -> f (g x)
--
-- So, our final version of squareDouble is

squareDouble = square . double

-- side node (Partial application):
--
-- we could have written the multiply function as
-- multiply x y = x * y
-- and it would have done the same thing right?
-- 
-- As it turns out
-- multiply x y = x * y
-- is just a more convenient way to write 
-- multiply x = \y -> x * y
--
-- In haskell every function with multiple arguments is curried like this.
--
-- In fact, we can make a new function by partially applying an old function.
-- multiply 3 is just (\y -> 3 * y)
-- 
-- We can even do the same thing with opperators
-- (3*) is also a function that multiplies it's argument by 3
--
-- as a consequence we could have written
-- compose f g x = f (g x)
-- and it would have been exactly the same
-- Generally, we use \x -> ... when we want to make it clear we're returning a fuction,
-- and not taking an extra parameter.

-------------------------------------------------------
-- control flow
-------------------------------------------------------

-- Ok, great, but we've still basically got a fancy calculator
-- How do we do any control flow with Haskell?
--
-- well, we don't have statements, or loops, but we do have if, and recursion.
-- here's a mandatory factorial example

fac1 n = if n == 0
           then 1
           else n * fac1 (n-1)

-- Well, that's not great.  I'd rather use python or C.
-- It's ok, we've got a few better ways to handle control flow in Haskell
-- This is just always something you can go back to if you're stuck.
--
--
-- Guards:
-- A guard is just more convenient notation for a condition
-- A function can have several guards, and will pick the first one that is true

fac2 n
 | n == 0    = 1
 | otherwise = n * fac2 (n-1)

-- This isn't usually as convenient as pattern matching, but it's still useful
--
-- Pattern Matching:
-- This is honestly one of the best parts of Haskell
-- If we want to write a function, we can give the function several definitions
-- each definition gives a specific value to an argument
-- for example

fac3 0 = 1
fac3 n = n * fac3 (n-1)

-- The first definition of fac defined what to do if the argument is 0
-- the other definition of fac handled every other case.
-- This is very useful for recursion, because we always have at least two cases
-- our base case, and our recursive case.
-- We'll come back to pattern matching after we've learned how to make new data types.
--
-- Higher order functions:
-- This is the most common form of control flow
-- We make a function that handles the control flow for us.
-- Then we can reuse the function any time.
--
fac4 n = foldl multiply 1 [1..n]

-- here [1..n] is the list of numbers from 1 to n (we'll come back to this)
-- and foldl is a function that will accumulate a value over a list (oh boy, will we come back to this)
-- So, this function says "take 1, and multiply it with each number in the list of 1 to n"
--
-- Ok, new we need to have a serious talk about types

-- Exercises:
-- The ackermann function is
-- int ack(int x, int y)
-- {
--     if(x == 0) return y + 1;
--     if(y == 0) return ack(x-1,1);
--     return ack(x-1, ack(x,y-1));
-- }
--
-- define the ackermann function using guards, then pattern matching

ackG = undefined

ackP = undefined
-------------------------------------------------------
-- Types and data structures
-------------------------------------------------------

-- The Haskell type system is incredibly powerful
-- We haven't looked at any types yet, but we can ask hugs for the type of a variable using :t
--
-- Main> :t fac1
-- fac1 :: Num a => a -> a
-- Main>
--
-- We can ignore the 
-- Num a =>
-- for the moment
--
-- This says 
-- fac1 :: a -> a
-- This should seem familiar
-- fac1 takes something of type a, and returns something of the same type.
-- So, What is a?
--
-- a can actually be several types (Int, Integer, Rational, Matrix, Float ...)
-- fac1 will work on all of them.
--
-- The syntax for writing types in haskell is
-- functionName :: Type
--
-- so the identity function is
-- id :: a -> a
-- id x = x
--
-- if we have more than one parameter, then we write
-- f :: a -> b -> a
-- f x y = x
--
-- Ok, but what if we have a function parameter (because we can do that)
compose2 :: (a -> a) -> (a -> a) -> (a -> a)
compose2 f g = \x -> f (g x)

-- we created a function compose2 that takes 2 arguments
-- both arguments take a parameter, and return a result
-- so they have type (a -> a)
-- but our return value is also a function, so it also has type (a -> a)
--
-- Although, this isn't how hugs would show the type of compose
-- The first difference is that we don't need parentheses around the return type
--
-- compose2 :: (a -> a) -> (a -> a) -> a -> a
--
-- This is because of currying
--
-- The second difference is that we can make the type more general.
-- Right now compose2 will let us compose two function of any type,
-- but their parameter must be the same type as their result.
-- This is needlessly restrictive, we couldn't have
-- toUpper = chr . (+32) . ord
-- as an implementation of toLower, because toAscii would change from a character to an integer
-- (Note: the functions ord and char in Data.Char convert between ascii and characters in haskell)
--
-- So, we would like to compose any type of function.
-- We do have one constraint.  The result of g must match the input of f.
-- So, the final definition of compose is
compose3 :: (b -> c) -> (a -> b) -> a -> c
compose3 f g = \x -> f (g x)

-- You'll find that :t (.) gives just this type (possibly with different names for a,b,c)
--
-- Now, onto making our own data structures.
-- We can make a new type in Haskell with the data keyword

data StopLight = Red | Yellow | Green
  deriving(Eq) -- we'll talk about this line thursday

canGo :: StopLight -> Bool
canGo x
 | x == Green = True
 | otherwise  = False

-- These are called algebraic data types
-- They look a lot like enumerations
-- But, they are way more interesting
-- Suppose we wanted a type that represents differnt employees in the CS department

type CRN = Int
data Employee = TCSS String Int CRN    -- TCSS name hours course
              | TA   String CRN        -- TA name course
              | Professor String [CRN] -- Professor Name (list of courses)

-- Now the different cases each contain different data
-- A TCSS can only work a certain number of hours,
-- while a TA has a flat rate, but only works on one course at a time,
-- and a professor might teach multiple courses at the same time.
--
-- So, how do we write a function to deal with these very different structures?
-- Simple, we use pattern matching

pay :: Employee -> Int
pay (TCSS name hours course) = hours * 10
pay (TA name course)         = 10 * 10
pay (Professor name courses) = 10 * (length courses) * 10

-- Note: none of this is accurate information.
-- I guessed on all of the pay rates
--
-- Now, imagine trying to represent this structure in C.
-- You can do it, but it'd be much more painful.
-- Even in Java this wouldn't be great.
--
-- cool, so, how about data structures?
-- can we make a linked list?
data ListInt = NilI | ConsI Int ListInt
--
-- The names Nil and Cons come from Lisp, but this is just a linked list
-- Nil is the end of a list,
-- Cons is a node with a value, and it's attached to a linked list.
--
-- How do we write list functions?
-- yup, pattern matching
lengthInt :: ListInt -> Int
lengthInt NilI = 0
lengthInt (ConsI x xs) = 1 + lengthInt xs

-- can you write a sum function?
sumL :: ListInt -> Int
sumL = undefined

-- Ok, but just being able to put Ints in my list is stupid, what if I want other values?
-- We can do that too, with a parameterized data structure

data List a = Nil | Cons a (List a)

lengthA Nil = 0
lengthA (Cons x xs) = 1 + lengthA xs

-- now I can have any type in my list
-- List Int
-- List Bool
-- List (List Float)

-- As you can guess Haskell has it's own list type
-- data [a] = [] | (:) a [a]
--
-- what does this look like?
-- [] is the Nil (or empty list)
-- (:) is Cons, so h:t is a list where the first value is h, and t is the rest of the list
--
-- Again, we can use pattern matching to write functions on lists
--
-- length []     = 0
-- length (x:xs) = 1 + length xs
--

-- We can also define other recursive data Structures
data Tree a = Leaf a 
            | Node a (Tree a) (Tree a)

-- we can define functions on Trees as well using patterns matching
numNodes :: Tree a -> Int
numNodes (Leaf _) = 1
numNodes (Node _ l r) = 1 + numNodes l + numNodes r


-- Exercise:
-- Define a function flip, which flips a tree about the root
--
-- if t is
--         1
--        / \
--       2   3
--          / \
--         4   5
--
-- (flip t) returns
--
--         1
--        / \
--       3   2
--      / \
--     4   5
flip :: Tree a -> Tree a
flip = undefined

-- We can also define Maps, graphs, and all kinds of data structures.
-- But we're not going to use those for this class.
-- so, let's go back to lists.
--
-- There's actually a lot of things you can do with lists.
-- The first is that you can transform a list
-- If I have a list of integers, and we want a list of squares I could write
squareList :: [Int] -> [Int]
squareList [] = []
squareList (x:xs) = x * x : squareList xs

-- This kind of transformation on lists is so common that we have a special function for it
-- map :: (a -> b)  -> [a] -> [b]
-- map f []     = []
-- map f (x:xs) = f x : map f xs
--
-- here f is a fuction that we apply to every element in the list.
-- so we could have written
-- squareList = map square
--
-- The other thing we tend to do with lists is accumulate a value from them.
-- For example we might sum a list
sumInt :: [Int] -> Int
sumInt []     = 0
sumInt (x:xs) = x + sum xs
--
-- we have a function for that too, but it's a little more complicated
-- foldl :: (a -> b -> a) -> a -> [b] -> a
-- foldl f acc (x:xs) = let acc' = f acc x
--                      in foldl f acc' xs
--
-- This function adds each element in the list to the accumulator
-- We start with in initial value (acc), and combine it with each element in the list
--
-- So, sumInt could have been
-- sum = foldl (+) 0
--
-- Finally, we have list comprehension
-- This is entirely syntactic sugar, but it's really convenient syntactic sugar
--
-- map f xs = [f x | x <- xs]
--
-- This means that we make a new list, and for every element in the old list, we apply f to it
-- We can do some really clever things with this
cartProduct :: [a] -> [b] -> [(a,b)]
cartProduct xs ys = [(x,y) | x <- xs, y <- ys]

-- we can even nest list comprehensions.
-- They're very powerful, but they quickly lead to unreadable code, so that's all I'm going to say about them.

------------------------------------------
-- Abstract Syntax Trees
------------------------------------------
--
-- Your next project involves writing an interpreter for a C like language.
-- I've given you the parser, and the definition of an AST
-- Let's look at the expressions
--
data Expr = Add Expr Expr | Sub Expr Expr
          | Mul Expr Expr | Div Expr Expr
          | And Expr Expr | Or  Expr Expr
          | Eq  Expr Expr | Ne  Expr Expr
          | Neg Expr      | Not Expr
          | Var String    | Val Value

data Value = Lit Integer | BTrue | BFalse

-- Ok, This is similar to what we've seen before, there's just a lot of  operators
-- Your job is to write an eval function
-- This function 

-- eval :: Env -> Expr -> Value

-- This is close to what we want, but there's a problem.
-- Now we can have type errors.
-- So, we don't want to return a value, we want to return a possible value

data Result a = OK a
              | Error String 

-- Either we return a result, or we return an error String
-- This gives a new type for eval
-- eval :: Env -> Expr -> Result Value

-- Part 1 of your project is to fill out eval
-- Part 2 will come thrusday

