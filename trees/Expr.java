import java.util.*;



abstract public class Expr
{
    abstract int eval(Env env);

    public static void main(String[] args)
    {
        Env env = new Env();
        env.add("x",1);
        env.add("y",2);
        env.add("z",3);
        System.out.println(env.lookup("x"));
    }
}

class Lit extends Expr
{
    int _i;

    public Lit(int i)
    {
        _i = i;
    }

    public int eval(Env env)
    {
        return _i;
    }

    String toString()
    {
        return _i;
    }
}

//class Add extends Expr {}
//class Sub extends Expr {}
//class Mul extends Expr {}
//class Div extends Expr {}
//class Var extends Expr {}
//class Let extends Expr {}
//class IFZ extends Expr {}


///////////////////////////////////////////////////////////////////////////////////
//
// Env class:
// Env has a constructor and 3 relavent methods
//
// add(String,int) adds a name/value pair to the environment
// pop() removes the last name/value pair added
// lookup(String) looks up the value associated with name in the environment
//
// This class is not meant to be efficient
//
///////////////////////////////////////////////////////////////////////////////////

class Env
{
    // because Java doesn't have tuples
    private class EnvPair
    {
        public String _name;
        public int _val;
        public EnvPair(String name, int val)
        {
            _name = name;
            _val = val;
        }
    }

    private Stack<EnvPair> _pairs;

    public Env()
    {
        _pairs = new Stack<EnvPair>();
    }

    public void add(String name, int val)
    {
        _pairs.push(new EnvPair(name,val));
    }

    public void pop()
    {
        _pairs.pop();
    }

    public int lookup(String name)
    {
        for(int i = _pairs.size()-1; i >= 0; i--)
        {
            if(_pairs.elementAt(i)._name == name)
            {
                return _pairs.elementAt(i)._val;
            }
        }
        return 0;
    }

    public String toString()
    {
        String s = "[ ";
        for(EnvPair p : _pairs)
        {
            s += "("+p._name+","+p._val+") ";
        }
        return s + "]";
    }
}
