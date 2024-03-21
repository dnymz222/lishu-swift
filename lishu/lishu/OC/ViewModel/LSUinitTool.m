//
//  LSUinitTool.m
//  lishu
//
//  Created by xueping on 2021/10/14.
//

#import "LSUinitTool.h"

@implementation LSUinitTool


double nieshifromhuashi(double F){
    double nieshi = 5/9.f*(F-32.f);
    return nieshi;
}


+ (NSString *)temperatureFormFahrenheit:(double)F isMertic:(BOOL)isMetric {
    if (isMetric) {
            double C = nieshifromhuashi(F);
           NSString *string = [NSString stringWithFormat:@"%0.1f%@",C,@"°C"];
           return string;
       } else {
         
           NSString *string = [NSString stringWithFormat:@"%0.1f%@",F,@"°F"];
           return string;
       }
}


+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, height, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end
