//
//  LSNightDayTool.m
//  lishu
//
//  Created by xueping wang on 2025/1/26.
//

#import "LSNightDayTool.h"
#import "LSSun.h"
#import <CoreGraphics/CoreGraphics.h>


@interface LSNightDayTool ()

@property(nonatomic, strong)NSDate *date;
@property(nonatomic,strong)LSSun *sun;

@property(nonatomic,assign)double zpow;
@property(nonatomic,assign)double startY;
@property(nonatomic,assign)double endY;

@end

@implementation LSNightDayTool

- (instancetype)initWihDate:(NSDate *)date {
    self = [super init];
    if (self) {
        self.date = date;
        self.sun = [[LSSun alloc] initWithDate:date];
        [self.sun calculateSun];
        self.zpow = [self zpow_v:6];
        self.startY = [self latitude_to_tile:70.81210731201662 zpow:self.zpow];
        self.endY = [self latitude_to_tile:-55.74400303667873 zpow:self.zpow];
    }
    return  self;
}


- (int)zpow_v: (int) z  {
    
    int a = 1;
    for(int i = 0; i < z; i ++){

        a = a * 2;
    }
    return a;
}

- (double) tileToLongitude:(double) x  zpow: (double)zpow  {
    double lng = x / zpow * 360 - 180;
   return lng;
}

- (double) tileToLatitde: (double)y  zpow: (double)zpow  {
    double p = zpow;
    double q = 2 * M_PI * y;
    double n = M_PI - q /  p;
    double latitude = 180.0 / M_PI * atan(0.5 * (exp(n) - exp(-n)));
    return latitude;
}

- (double) latitude_to_tile:(double)latitude  zpow: (double )zpow{
    double  lat_rad = latitude / 180.0 * M_PI;
  
    double ytile = zpow * (1 - (log(tan(lat_rad) +  1/cos(lat_rad)) / M_PI)) / 2;
    
    return ytile;
}


-(double)screenXtoLongitude: (int) x  scale:(int)scale{
    
    return  -180 + x / (720.0 *scale)  * 360;
}

-(double) screenYtoLatitude:(int) y scale:(int)scale {
    
    double tile = self.startY  + y / (338.0 * scale) * (self.endY - self.startY);
    
    return [self tileToLatitde:tile zpow:self.zpow];
    
}


- ( UIImage*)generateImage:(int)scale {
    
    int rows = 338 * scale;
    int cols = 720 * scale;
    
    int arrayLen = rows *cols;
    
    uint indexOrigin=0;
       unsigned char *rgba = (unsigned char *)calloc(arrayLen * 4, sizeof(unsigned char));
 

    
    
    
    
    

    
    for (int i = 0; i < rows;  i++) {
        for (int j= 0; j < cols; j ++) {
            
            double longitude = [self screenXtoLongitude:j scale:scale];
            double latitude = [self screenYtoLatitude:i scale:scale];
            
            double h = [self.sun calculateSunHeightWithLatitude:latitude longitude:longitude];
            
            indexOrigin = 4 * (i*cols + j);
            
            
 
            
          if (h > -0.833 ) {
                rgba[indexOrigin] = 0x00;
                rgba[indexOrigin + 1] = 0x00;
                rgba[indexOrigin + 2] = 0x00;
                rgba[indexOrigin + 3] = 0x00;
                
            } else if(h > -6){
                rgba[indexOrigin] = 0x33;
                rgba[indexOrigin + 1] = 0x33;
                rgba[indexOrigin + 2] = 0x33;
                rgba[indexOrigin + 3] = 0x66;
                
            } else {
                rgba[indexOrigin] = 0x33;
                rgba[indexOrigin + 1] = 0x33;
                rgba[indexOrigin + 2] = 0x33;
                rgba[indexOrigin + 3] = 0x88;
            }
            
        }
        
        
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(rgba,
                                                       cols,
                                                       rows,
                                                       8, // bitsPerComponent
                                                       4 * cols, // bytesPerRow
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault);


    CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *img = [UIImage imageWithCGImage:cgImage];
    CFRelease(cgImage);
    CFRelease(bitmapContext);
    CFRelease(colorSpace);
    free(rgba);
    
    return img;
    
}




@end
