//
//  maptrans.cpp
//  lishu
//
//  Created by xueping on 2021/3/7.
//

#include "maptrans.hpp"
#include <math.h>
#include <iostream>
using namespace std;
//#define M_PI       3.14159265358979323846
 
double* MillierConvertion(double lat, double lon)
{
    double L = 6381372 * M_PI * 2;//地球周长
    double W = L;// 平面展开后，x轴等于周长
    double H = L / 2;// y轴约等于周长一半
    double mill = 2.3;// 米勒投影中的一个常数，范围大约在正负2.3之间
    double x = lon * M_PI / 180;// 将经度从度数转换为弧度
    double y = lat * M_PI / 180;// 将纬度从度数转换为弧度
    y = 1.25 * log(tan(0.25 * M_PI + 0.4 * y));// 米勒投影的转换
    // 弧度转为实际距离
    x = (W / 2) + (W / (2 * M_PI)) * x;
    y = (H / 2) - (H / (2 * mill)) * y;
    double* result = new double[2];
    result[0] = x;
    result[1] = y;
    return result;
}
 
double* MillierConvertion1(double x, double y)
{
        double L = 6381372 * M_PI * 2;//地球周长
    double W = L;// 平面展开后，x轴等于周长
    double H = L / 2;// y轴约等于周长一半
    double mill = 2.3;// 米勒投影中的一个常数，范围大约在正负2.3之间
    double lat;
    lat = ((H / 2 - y) * 2 * mill) / (1.25 * H);
    lat = ((atan(exp(lat)) - 0.25 * M_PI) * 180) / (0.4 * M_PI);
    double lon;
    lon = (x - W / 2) * 360 / W;
    double* result = new double[2];
    result[0] = lon;
    result[1] = lat;
    return result;
}
 
 
//void main()
//{
//    double a, b;
//    double *test;
//    double *tet;
//    a = 0;
//    b = 0;
//    tet = MillierConvertion(a, b);
//    cout << tet[0] << endl << tet[1];
//    cout << endl;
//    test = MillierConvertion1(tet[0], tet[1]);
//    cout << test[0] << endl << test[1];
//}


