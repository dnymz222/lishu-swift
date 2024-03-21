//
//  ThaiCalendar.cpp
//  lishu
//
//  Created by xueping on 2022/1/7.
//

#include "ThaiCalendar.hpp"
#include <iostream>

#include <math.h>



ThaiCalendar::ThaiCalendar(double gmtzerotz) {
    
      double rD = round(730485.0 + gmtzerotz);
    
     int y_t = int(floor((rD - 232742.490489) / 365.25875 + 0.25));
    int d = int(floor(365.25875 * y_t + 1.490489));
    int s = (d + (11 * d + 650) / 692) % 30;
    if (s < 0) {
        s += 30;
    }
    
    int m_common[] = {29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29};
    int  m_leap[] = {29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 30, 29, 30, 29};
    
    int d1 = int(floor(365.25875 *(y_t + 1) + 1.490489));
    int s1 = (d1 + (11 * d1 + 650) / 692) % 30;
    if (s1 < 0) {
        s1 += 30;
    }
    if (s1 < 8) {
        s1 += 30;
    }
    int s0 = s;
    if (s0 < 8) {
        s0 += 30;
    }
    
    bool leapFlag = false;
    if (s1 < s0) {
        leapFlag = true;
    }
    
    if ((d1 - (s1 - 1)) - (d - (s - 1)) >= 355 && (!leapFlag) ) {
        m_common[8] += 1;
        m_leap[8] += 1;
    } else if ((d1 - (s1 - 1)) - (d - (s - 1)) >= 385 && leapFlag)  {
        m_common[8] += 1;
        m_leap[8] += 1;
    }
    
    int songkran = s;
    if (songkran >= 8) {
        songkran -= 30;
    }
    int m7th = int(d) - songkran;
    int de = int(rD) - 232741 - m7th;
    int year = 0; int month = 0;  int day = 0;
    bool leap= false;
    
    
    if (int(rD) - 232741 >= m7th ){
        if (leapFlag ) {
            for (int i = 1; i < 14; i ++) {
                
                de -= m_leap[(i + 6) % 13];
                if (de < 0) {
                    de += m_leap[(i + 6) % 13];
                    month = i + 6;
                    if (month > 9) {
                        if (month == 10) {
                            leap = true;
                        }
                        month -= 1;
                    }
                    month = month % 12;
                    if (month <= 0) {
                        month += 12;
                    }
                    break;
                }
                
            }
            
//            for i in stride(from: 1, to: 14, by: 1) {
//                de -= m_leap[(i + 6) % 13]
//                if de < 0 {
//                    de += m_leap[(i + 6) % 13]
//                    month = i + 6
//                    if month > 9 {
//                        if month == 10 {
//                            leap = true
//                        }
//                        month -= 1
//                    }
//                    month = month % 12
//                    if month <= 0 {
//                        month += 12
//                    }
//                    break
//                }
//            }
            day = de + 1;
        } else {
            
            for (int i = 1; i < 13; i++) {
                
                de -= m_common[(i + 6) % 12];
                if (de < 0) {
                    de += m_common[(i + 6) % 12];
                    month = (i + 6) % 12;
                    if (month <= 0) {
                        month += 12;
                    }
                    break;
                }
                
            }
            
//            for i in stride(from: 1, to: 13, by: 1) {
//                de -= m_common[(i + 6) % 12]
//                if de < 0 {
//                    de += m_common[(i + 6) % 12]
//                    month = (i + 6) % 12
//                    if month <= 0 {
//                        month += 12
//                    }
//                    break
//                }
//            }
            day = de + 1;
        }
    } else {
        
        for (int i = 12; i > 0; i--) {
            
            int zm = i - 6;
            if (zm <= 0) {
                zm += 12;
            }
            de += m_common[zm];
            if (de >= 0) {
                de -= m_common[zm];
                month = zm;
                break;
            }
            
        }
        
//        for i in stride(from: 12, to: 0, by: -1) {
//            var zm = i - 6
//            if zm <= 0 {
//                zm += 12
//            }
//            de += m_common[zm]
//            if de >= 0 {
//                de -= m_common[zm]
//                month = zm
//                break
//            }
//        }
        day = m_common[month] + de + 1;
    }
    
    year = y_t;
    if (int(rD) - 232741 < int(d)) {
        year -= 1;
    }
    
    this->year = year;
    this->leap = leap;
    this->month = month;
    this->day = day;
    
    
}




