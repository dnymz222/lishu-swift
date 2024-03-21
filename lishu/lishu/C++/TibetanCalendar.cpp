//
//  TibetanCalendar.cpp
//  lishu
//
//  Created by xueping on 2022/1/7.
//

#include "TibetanCalendar.hpp"
#include <iostream>

#include <math.h>

     TibetanCalendar::TibetanCalendar(double gmtzerotz) {
    
         double rd = round(730485.0 + gmtzerotz) + 1.0;
    
         double epoch = 725488.9819044511;
         double month_length = combine(29,  31,50,  0,  480,  707,0,0);
         int totalMonths = int(floor((rd - epoch) / month_length));
         double corr_tithi = (floor(TibetanCalendar::gzaDag(totalMonths, 1)) - floor(TibetanCalendar::gzaDag(totalMonths - 1, 30))) - 1;
        if (rd - 1 - (floor(TibetanCalendar::gzaDag(totalMonths,  1)) - corr_tithi) < 0) {
            totalMonths -= 1;
        } else if (rd - 1 - (floor(TibetanCalendar::gzaDag( totalMonths, 1)) - corr_tithi) >= 30) {
            totalMonths += 1;
        }
    
         int year;
         int month;
         bool monthIsLeap;
         int day;
         bool dayIsLeap;

    
         int * tMonth = TibetanCalendar::trueMonth( totalMonths);
         month = tMonth[0];
         monthIsLeap = (tMonth[1] == 0 ? false : true);
    
         double newMoon = TibetanCalendar::gzaDag( totalMonths - 1, 30);
         double firstDay = floor(newMoon) + 1;
         
         for (int r = 1; r < 31; r ++) {
             
             double g = TibetanCalendar::gzaDag(totalMonths, r);
             if (g < (r - 1 + firstDay)){
                 break;
             } else if (g >= (r + firstDay)){
                 firstDay += 1;
                 break;
             }
             
         }
//    for r in stride(from: 1, through: 30, by: 1) {
//        let g = TibetanCalendar.gzaDag(m: totalMonths, d: r)
//        if g < Double(r - 1) + firstDay{
//            break
//        } else if g >= Double(r) + firstDay{
//            firstDay += 1
//            break
//        }
//    }
    
         int solarDate = int(round(rd - firstDay));
         bool f = false;
        if (solarDate < 1) {
            solarDate = 1;
            f = true;
        } else if (solarDate > 30) {
            solarDate = 30;
        }
         double gzaDag = TibetanCalendar::gzaDag( totalMonths,  solarDate);
         double gzaDag0 = TibetanCalendar::gzaDag( totalMonths,  (solarDate - 1));
         double gzaDag1 = TibetanCalendar::gzaDag(totalMonths, (solarDate + 1));
        if (f  && int(floor(gzaDag)) == int(floor(gzaDag0))) {
            solarDate = 30;
            totalMonths -= 1;
            tMonth = TibetanCalendar::trueMonth( totalMonths);
            month = tMonth[0];
            monthIsLeap = (tMonth[1] == 0 ? false : true);
            gzaDag = TibetanCalendar::gzaDag(totalMonths,  solarDate);
            gzaDag0 = TibetanCalendar::gzaDag( totalMonths,  (solarDate - 1));
            gzaDag1 = TibetanCalendar::gzaDag( totalMonths,  (solarDate + 1));
        }
    
         int  d = 0;
        if (gzaDag < rd - 1) {
            d = solarDate + 1;
            if (gzaDag1 < rd - 1) {
                d += 1;
            }
            if (d > 30) {
                d -= 30;
                totalMonths += 1;
                tMonth = TibetanCalendar::trueMonth( totalMonths);
                month = tMonth[0];
                monthIsLeap = (tMonth[1] == 0 ? false : true);
            }
        } else if (gzaDag >= rd ){
            d = solarDate - 1;
            if (gzaDag0 >= rd) {
                d -= 1;
            }
            if (d < 1) {
                d += 30;
                totalMonths -= 1;
                tMonth = TibetanCalendar::trueMonth( totalMonths);
                month = tMonth[0];
                monthIsLeap = (tMonth[1] == 0 ? false : true);
            }
        } else {
            d = solarDate;
        }
         day = d;
    
    if ((int(floor(gzaDag)) -int(floor(gzaDag0)) > 1 && gzaDag >= rd - 1) || (int(floor(gzaDag1)) - int(floor(gzaDag)) > 1 && gzaDag < (rd - 2)) ) {
        dayIsLeap = true;
    } else {
        dayIsLeap = false;
    }
    
    if( d == 30 && dayIsLeap == true && floor(TibetanCalendar::gzaDag( totalMonths,  30)) - floor(TibetanCalendar::gzaDag( totalMonths,  29)) < 2) {
        dayIsLeap = false;
        day = 1;
        totalMonths += 1;
        tMonth = TibetanCalendar::trueMonth(totalMonths);
        month = tMonth[0];
        monthIsLeap = (tMonth[1] == 0 ? false : true);
    }
    
         double yc = (rd - epoch) / (365.0 + 4975.0 / 18382.0);
         double yd = floor(epoch + round(yc) * (365.0 + 4975.0 / 18382.0)) + 1.0;
         year = int(floor(yc)) + 961;
    if (rd < yd && month < 4) {
        year += 1;
    }
    
         this->year = year;
         this->month = month;
         this->monthIsLeap = monthIsLeap;
         this->day = day;
         this->dayIsLeap = dayIsLeap;
}

   int*  TibetanCalendar::trueMonth(int m)  {
       static int tMonth[] = {0, 0};
       int leapedMonths = int(floor((m - 159) / 33.5));
       if (m > 158) {
           tMonth[0] = (m - 159 - leapedMonths) % 12 + 1;
           
        if ((m - 159) % 67 == 0 || (m - 159) % 67 == 34) {
            tMonth[1] = 1;
        } else {
            tMonth[1] = 0;
        }
    } else {
        tMonth[0] = (12 + ((m - 158 - leapedMonths) % 12)) % 12;
        if (tMonth[0] == 0) {
            tMonth[0] += 12;
        }
        if ((m - 158) % 67 == -66 || (m - 158) % 67 == -32) {
            tMonth[1] = 1;
        } else {
            tMonth[1] = 0;
        }
    }
       return tMonth;
}

   double TibetanCalendar::gzaDag(int m, int d)  {
       int  sunTab[] = {0, 6, 10, 11};
       int  moonTab[] = {0, 5, 10, 15, 19, 22, 24, 25};
    
       double gzaDagRD = TibetanCalendar::combine( 29 * m,  31 * m,  50 * m,  0, 480 * m,  707,0,0) +TibetanCalendar::combine( 0,  59 * d,  3 * d, 4 * d,  16 * d,  707,0,0) +TibetanCalendar:: combine( 725488,  11,  27,  2,  332,  707,0,0);
            
      double ma = (m * (2 + 1 / 126.0) + d + (21 + 90 / 126.0));
        ma =  TibetanCalendar::truncatingRemainder(ma, 28);
      if (ma < 0) {
        ma += 28;
      }
       double sl = (combine( 2 * m, 10 * m,  58 * m,  m,  17 * m,  67,0,0) + combine( 0, 4 * d, 21 * d,  5 * d,  43 * d,  67,0,0));
       sl = truncatingRemainder(sl, 27);
     if (sl < 0) {
        sl += 27;
     }
      double sa = sl - TibetanCalendar::combine(6,  45,  0,  0,  0, 67,0,0);
        if (sa < 0) {
            sa += 27;
        }
    
       int maI = int(round(ma * 126)) / 126 % 28;
       int maS = 1;
       int maF = int(round(ma * 126)) % 126;
       int argM = maI % 7;
        if (maI % 14 >= 7) {
            argM = 7 - argM;
            maS -= 2;
        }
       int ddM = abs(moonTab[argM + maS] - moonTab[argM]);
       ddM *= maF;
        double eqM = combine( 0,ddM / 126,(ddM % 126 * 60) / 126,
                                           (ddM % 126 * 60 % 126 * 6) / 126,
                          (ddM % 126 * 60 % 126 * 6 % 126 * 707) / 126, 707,0,0) * 60 * maS;
       eqM += moonTab[argM];
        if (maI >= 14) {
            eqM *= -1;
        }
       gzaDagRD += eqM / 60;
    
       int* saX = breakup( sa,  67,0);
       int saI = (saX[0] * 60 + saX[1]) / 135;
       int saS = 1;
       int argS = saI % 3;
    if (saI % 6 >= 3) {
        argS = 3 - argS;
        saS -= 2;
    }
       int ddS = abs(sunTab[argS + saS] - sunTab[argS]);
    int saF0 = combine(0,
                                    (saX[0] * 60 + saX[1]) % 135 * ddS,
                                    saX[2] * ddS,
                                       saX[3] * ddS,
                       saX[4] * ddS, 67,0,0);
       int* saF =breakup( saF0,  67,0);
       saF[1] += saF[0] * 60;
       saF[0] = 0;
    double eqS = combine( 0,
                                      saF[1] / 135,
                                      (saF[1] % 135 * 60 + saF[2]) / 135,
                                       ((saF[1] % 135 * 60 + saF[2]) % 135 * 6 + saF[3]) / 135,
                         (((saF[1] % 135 * 60 + saF[2]) % 135 * 6 + saF[3]) % 135 * 67 + saF[4]) / 135,  67,0,0) * 60 * saS;
       eqS += sunTab[argS];
    if (saI >= 6) {
        eqS *= -1;
    }
       gzaDagRD -= (eqS / 60);
    
       return gzaDagRD;
}
 
   double  TibetanCalendar::combine( int x, int n,  int p,   int r, int  fr1, int  div1,  int fr2,  int div2)  {
     int i = x;
     int  nx = n;
     int  px = p;
     int  rx = r;
     int  f1 = 0;
     int  d1 = 1;
     int  f2 = 0;
     int  d2 = 1;
    if (div1 > 1) {
        f1 = fr1;
        d1 = div1;
        if (div2 > 1) {
            f2 = fr2;
            d2 = div2;
        }
    }
    
    if (d1 > 1) {
        if (d2 > 1) {
            f1 += f2 / d2;
            f2 = f2 % d2;
        }
        rx += f1 / d1;
        f1 = f1 % d1;
    }
     px += rx / 6;
     rx = rx % 6;
     nx += px / 60;
     px = px % 60;
     i += nx / 60;
     nx = nx % 60;
    
     return i + (nx+ (px + (rx + (f1 + f2 / d2) / d1) / 6.0) / 60.0) / 60.0;
}

 double TibetanCalendar::truncatingRemainder(double x, double y){
    
    double n = floor(x/y);
    
     return x- n*y;
    
}

int* TibetanCalendar:: breakup(double x,  int div1, int  div2){
    static int g[] = {0, 0, 0, 0, 0, 0};
    int d1 = 1;
    int  d2 = 1;
    if (div1 > 1) {
        d1 = div1;
        if (div2 > 1){
            d2 = div2;
        }
    }
    
    int i =int(round(x * 60.0 * 60.0 * 6.0 * d1 * d2));
    g[5] = i % d2;
    g[4] = (i / d2) % d1;
    g[3] = (i / (d1 * d2)) % 6;
    g[2] = (i / (6 * d1 * d2)) % 60;
    g[1] = (i / (60 * 6 * d1 * d2)) % 60;
    g[0] = i / (60 * 60 * 6 * d1 * d2);
    
    return g;
}
