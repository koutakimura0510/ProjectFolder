double sinc(double x)
{
  double y;
  
  if (x == 0.0)
  {
    y = 1.0;
  }
  else
  {
    y = sin(x) / x;
  }
  
  return y;
}
