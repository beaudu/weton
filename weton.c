#include <stdio.h>
#include <stdlib.h>

int main( int argc, char *argv[] ) {
   int d, m, y, c, w, p;
   char dow[7][9] = { "Senen", "Selasa", "Rebo", "Kemis", "Jemuwah", "Setu", "Ngahad" };
   char pasaran[5][7] = {"Pon", "Wage", "Kliwon", "Legi", "Pahing" };

   if ( argc < 4 ) {
      printf("Usage: weton DAY MONTH YEAR.\n");
      exit(1);
   }

   // following formulas based on Zeller's congruence
   // Karjanto & Beauducel (2020) for pasaran day
   d = atoi(argv[1]);
   m = atoi(argv[2]);
   y = atoi(argv[3]);
   c = y/100;
   y = y%100;

   w = (m<3?y--,m+=13:m++,d+153*m/5+15*y+y/4+19*c+c/4+5);

   printf("~ %s %s ~\n", dow[w%7], pasaran[w%5]);

   return 0;
}
