import java.util.*;

public class RoseTree<T>
{
    private T _val;
    private List<RoseTree<T>> _children;

    public T getVal(T val) {return _val; }
    public void setVal(T val) { _val = val; }

    public void add(RoseTree<T> child)
    {
        _children.add(child);
    }

    public RoseTree()
    {
        _children = new ArrayList<RoseTree<T>>();
    }

    public RoseTree(T val)
    {
        this();
        _val = val;
    }
    public RoseTree(T val, List<RoseTree<T>> children)
    {
        _val = val;
        _children = children;
    }


    public static void main(String[] args)
    {
        List<RoseTree<Integer>> children = new ArrayList<RoseTree<Integer>>();
        children.add(new RoseTree<Integer>(1));
        children.add(new RoseTree<Integer>(2));
        children.add(new RoseTree<Integer>(3));
        children.add(new RoseTree<Integer>(4));
        children.add(new RoseTree<Integer>(5));
        RoseTree<Integer> r = new RoseTree<Integer>(10, children);
    }


    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Methods to add
    //
    /////////////////////////////////////////////////////////////////////////////////////

    int count()
    {
        return 0;
    }

    int depth()
    {
        return 0;
    }

    String toString()
    {
        return "";
    }

    /////////////////////////////////////////////////////////////////////////////////////
    //
    // Read method
    //
    /////////////////////////////////////////////////////////////////////////////////////


    /**
     * Reads a srting into a Rose Tree.
     * The format is the same as the qtree fromat from latex.
     *
     * [.name subtree subtree ... subtree ]
     * where a subtree can be another tree, or it can be a child.
     * So, read("[.1 [.2 3 4 ] [.5 6 7 ] ]", r, 0);
     * will  read the tree
     *             1
     *            / \
     *           /   \
     *          2     5
     *         / \   / \
     *        3   4 6   7
     *
     * @param s the string to read
     * @param r an empty RoseTree that we will fill in
     * @param i our current position in the string (usually 0).
     *
     * @return the position in the string after we read the tree.  This should be s.length()
     */
    public static int read(String s, RoseTree<String> r, int i) throws Exception
    {
        // read opening "[." if that's not there, then it's an error
        if(!s.substring(i,i+2).equals("[.")) throw new Exception("Error: no node name");

        //read the name of the node
        String name = readName(s,i+2);
        r.setVal(name);
        i += name.length() + 2;

        i = skipSpace(s,i);

        // read until the closing node
        while(s.charAt(i) != ']')
        {
            //we're starting a new child tree
            if(s.charAt(i) == '[')
            {
                RoseTree<String> c = new RoseTree<String>();
                i = read(s, c, i);
                r.add(c);
            }
            //we're adding a leaf
            else
            {
                name = readName(s,i);
                i += name.length();
                r.add(new RoseTree<String>(name));
            }
            i = skipSpace(s,i);
        }
        //return the NEXT character
        return i+1;
    }

    /**
     * set i equal to the position of the next non-space character.
     */
    private static int skipSpace(String s, int i)
    {
        while(s.charAt(i) == ' ' && i < s.length()) {i++;}
        return i;
    }

    /**
     * read a name for the tree.
     * A name is just a string with no spaces
     */
    private static String readName(String s, int i)
    {
        String name = "";
        while(s.charAt(i) != ' ' && i < s.length())
        {
            name += s.charAt(i++);
        }
        return name;
    }
}
