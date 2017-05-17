class CountryData implements Comparable
{
  String name = "";
  int sum2013 = 0;
  int sum2014 = 0;
  int sum2015 = 0;
  int total = 0;
  int renderColor = 0;
  boolean banned = false; 
  public int compareTo(Object obj) 
  {
    CountryData t = (CountryData)obj;
    return t.total - this.total;
  }
}

