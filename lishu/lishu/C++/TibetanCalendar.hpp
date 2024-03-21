//
//  TibetanCalendar.hpp
//  lishu
//
//  Created by xueping on 2022/1/7.
//

#ifndef TibetanCalendar_hpp
#define TibetanCalendar_hpp

#include <stdio.h>



class TibetanCalendar {
    
    int year;
    int month;
    int day;
    bool monthIsLeap;
    bool dayIsLeap;
    
    TibetanCalendar (double gmtzerotz);
    
    static double combine( int x, int n,  int p,   int r, int  fr1, int  div1,  int fr2,  int div2);
    
    static double truncatingRemainder(double x, double y);
    
    static   int*  breakup(double x,  int div1, int  div2);
    
    static  int*  trueMonth(int m);
    
    static double gzaDag(int m, int d);
    
    
    
};






#endif /* TibetanCalendar_hpp */
