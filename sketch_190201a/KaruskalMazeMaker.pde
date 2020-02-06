//http://weblog.jamisbuck.org/2011/1/3/maze-generation-kruskal-s-algorithm
//https://nullprogram.com/blog/2014/06/22/
class KaruskalMazeMaker
{
  ArrayList<treenode> nodes = new ArrayList<treenode>();
  ArrayList<linknode> links = new ArrayList<linknode>();
  class linknode
  {
    treenode a;
    treenode b;
  }
  class treenode
  {
    float[] pos = {0,0};
    treenode root = null;
    ArrayList<treenode> branches = new ArrayList<treenode>();
    public treenode()
    {
      root = this;
    }
    treenode getRoot()
    {
      return root;
      //if(root == null)
      //  return this;
      //else
      //  return root.getRoot();
    }
    
    void addBranch(treenode node)
    {
      if(node == null)
        return;
      node.root.setRoot(root,this);
      branches.add(node);
      node.branches.add(this);
    }
    
    void setRoot(treenode newRoot,treenode prevNode )
    {
      //if(root != null)
      //  root.setRoot(newRoot);
      root = newRoot;
      for(treenode n : branches)
      {
        if(prevNode != n)
          n.setRoot(newRoot,this);
      }
    }
    
    void draw(float w, float h)
    {
      //noStroke();
      //fill(255);
      //pushMatrix();
      //translate(pos[0],pos[1]);
      //translate(-w/2,-h/2);
      ////rect(0,0,w,h);
      //popMatrix();
      //ellipse(pos[0],pos[1],10,10);
      //pushStyle();
      //stroke(0,255,0);
      //ellipse(root.pos[0],root.pos[1],15,15);
      //popStyle();
      stroke(255);
      strokeWeight(w);
      
strokeJoin(BEVEL);
      for(treenode n : branches)
      {
        line(pos[0],pos[1],n.pos[0],n.pos[1]);
      }
    }
  }
  int w = 8;
  int h = 8;
  
  void setup(int wid, int heg)
  {
    w = wid;
    h = heg;
    nodes = new ArrayList<treenode>();
    treenode[][] nds = new treenode[w][h];
    for(int i = 0; i < w; i++)
    {
      for(int j = 0; j < h; j++)
      {
        nds[i][j] = new treenode();
        nds[i][j].pos[0] = (.5+i)*width*1.f/w;
        nds[i][j].pos[1] = (.5+j)*height*1.f/h;
        nodes.add(nds[i][j]);
      }
    }
    
    for(int i = 0; i < w; i++)
    {
      for(int j = 0; j < h; j++)
      {
        linknode link = new linknode();
        if(i < w-1)
        {
          link.a = nds[i][j];
          link.b = nds[i+1][j];       
          links.add(link);   
        }
        if(j < h-1)
        {
          link = new linknode();
          link.a = nds[i][j];
          link.b = nds[i][j+1];
          links.add(link);
        }
      }
    }
  }
  
  void step()
  {
    //get random link (with lowest weight)
    if(links == null || links.size() < 1)
      return;
    int randIndex = (int)random(links.size());  
    linknode l = links.remove(randIndex);
    if(l.a.getRoot() != l.b.getRoot())
    {
      l.a.addBranch(l.b);
    }
  }
  
  void solve(float normIndex)
  {
    while(links != null && links.size()>0)
    {
    int randIndex = (int)random(links.size());  
      linknode l = links.remove(randIndex);
      if(l.a.getRoot() != l.b.getRoot())
      {
        l.a.addBranch(l.b);
      }
    }
  }
  void solve()
  {
    int indecies[] = new int[links.size()];
    for( int i = 0; i < indecies.length; i++)
    {
      indecies[i] = i;
      indecies[i] = (int)(indecies[i]+millis()/100.f) % indecies.length; 
    }
    //do a bunch of swaps
    //for(int i = 0; i < 530; i++)
    //{
    //  int ndx1 = (int)( (indecies.length-1)*(1+ sin(i/14.f+millis()/10000.f))/2 );
    //  int ndx2 = (int)( (indecies.length-1)*(1+ sin(i/13.f+2+millis()/80001.f))/2 );
    //  int tmp = indecies[ndx1];
    //  indecies[ndx1] = indecies[ndx2];
    //  indecies[ndx2] = tmp;
    //}
    for(int i = 0; i < indecies.length; i++)
    {
      linknode l = links.get(indecies[i]);
      if(l.a.getRoot() != l.b.getRoot())
      {
        l.a.addBranch(l.b);
      }
    }
  }
  
  
  void draw()
  {
    float dw = .9*width*1.f/w;
    float dh = .9*height*1.f/h; 
    for(treenode n : nodes)
    {
      n.draw(dw,dh);
    }
  }
}
