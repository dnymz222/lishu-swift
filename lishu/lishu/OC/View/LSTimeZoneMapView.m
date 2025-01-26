//
//  LSTimeZoneMapView.m
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import "LSTimeZoneMapView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"



@interface LSTimeZoneMapView ()


@property(nonatomic,strong)UIImageView *mapView;




@property(nonatomic,assign)NSInteger check;//0:1:2


@property(nonatomic,weak)CAShapeLayer *risesetLayer;
@property(nonatomic,weak)CAShapeLayer *twilightLayer;





@end


@implementation LSTimeZoneMapView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self   =[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.mapView];
        [self addSubview:self.overlayView];
        
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        [self.overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (UIImageView *)mapView {
    if (!_mapView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"World-map-time-zones"];
        [imageview setImage:image];
        _mapView =  imageview;
    }
    return _mapView;
}


- (UIImageView *)overlayView {
    if (!_overlayView) {
        _overlayView  = [[UIImageView alloc] init];
        _overlayView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _overlayView;
}

//- (void)configLocationArray:(NSArray *)locations scale:(double)scale fix:(int)fix {
//    
//    if (self.risesetLayer) {
//        [self.risesetLayer removeFromSuperlayer];
//    }
//    int n  = locations.count;
//    self.check  = 0;
//    CAShapeLayer *shapelayer = [CAShapeLayer layer];
//    shapelayer.frame  = self.bounds;
//    
//    
//    shapelayer.fillColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.2].CGColor;
//    
//    shapelayer.lineWidth = 1.0;
//      // 设置线的颜色
//    shapelayer.strokeColor =[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.2].CGColor;
//    
//    UIBezierPath *path   =[UIBezierPath bezierPath];
//    
//    if (fix == -1) {
//        [path moveToPoint:CGPointZero];
//    } else {
//        [path moveToPoint:CGPointMake(0, 1195/scale)];
//    }
//    
//    
//
//    
//    for (int i = 0; i < n-1; i ++) {
//        
//        LSTimeZoneMapLocation *location  = locations[i];
//        if (  0 == i) {
//            [path addLineToPoint:CGPointMake(location.x/scale, location.y/scale)];
//        } else {
//            
//            [path addLineToPoint:CGPointMake(location.x/scale, location.y/scale)];
////            LSTimeZoneMapLocation *location1  = locations[i-1];
////            LSTimeZoneMapLocation *location2  = locations[i+1];
////            [self path:path pointbegin:CGPointMake(location1.x/scale, location1.y/scale) pointcenter:CGPointMake(location.x/scale, location.y/scale) pointend:CGPointMake(location2.x/scale, location2.y/scale)];
//            
//            
////            [path addLineToPoint:CGPointMake(location.x/scale, location.y/scale)];
//        }
//        
//        
////        NSLog(@"%d,long:%0.1f,lat:%0.1f",i,location.location.coordinate.longitude,location.location.coordinate.latitude);
//      
//        
//        
//        
//    }
//    
//    
//    LSTimeZoneMapLocation *lastlocation  = locations[n-1];
//    
//    [path addLineToPoint:CGPointMake(lastlocation.x/scale, lastlocation.y/scale)];
//    
//    
//    if (-1 == fix) {
//        [path addLineToPoint:CGPointMake(2004/scale, 0)];
//        [path addLineToPoint:CGPointZero];
//    } else {
//        [path addLineToPoint:CGPointMake(2004/scale, 1195/scale)];
//        [path addLineToPoint:CGPointMake(0, 1195/scale)];
//        
//    }
//    
//   
//    
//    shapelayer.path = path.CGPath;
//    
//    [self.layer addSublayer:shapelayer];
//    
//    self.risesetLayer   = shapelayer ;
//    
//    
////    [self.overlayView configLocationArray:locations ];
//}



//- (void)configTwilightLocationArray:(NSArray *)locations scale:(double)scale fix:(int)fix  {
//    
//    if (self.twilightLayer) {
//        [self.twilightLayer removeFromSuperlayer];
//    }
//    
//    int n  = locations.count;
//    self.check  = 0;
//    CAShapeLayer *shapelayer = [CAShapeLayer layer];
//    shapelayer.frame  = self.bounds;
//    shapelayer.fillColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5].CGColor;
//    
//    shapelayer.lineWidth = 1.0;
//      // 设置线的颜色
//    shapelayer.strokeColor =[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5].CGColor;
//    
//    UIBezierPath *path   =[UIBezierPath bezierPath];
//    
//    if (fix == -1) {
//        [path moveToPoint:CGPointZero];
//    } else {
//        [path moveToPoint:CGPointMake(0, 1195/scale)];
//    }
//    
//    
//
//    
//    for (int i = 0; i < n; i ++) {
//        
//        LSTimeZoneMapLocation *location  = locations[i];
////        NSLog(@"%d,long:%0.1f,lat:%0.1f",i,location.location.coordinate.longitude,location.location.coordinate.latitude);
//      
//        
//        [path addLineToPoint:CGPointMake(location.x/scale, location.y/scale)];
//        
//    }
//    
//    if (-1 == fix) {
//        [path addLineToPoint:CGPointMake(2004/scale, 0)];
//        [path addLineToPoint:CGPointZero];
//    } else {
//        [path addLineToPoint:CGPointMake(2004/scale, 1195/scale)];
//        [path addLineToPoint:CGPointMake(0, 1195/scale)];
//        
//    }
//    
//    path.lineCapStyle  =  kCGLineCapRound;
//   
//    
//    shapelayer.path = path.CGPath;
//    
//    [self.layer addSublayer:shapelayer];
//    
//    self.twilightLayer   =  shapelayer;
//    
//    
//}
//
//
//- (void)path:(UIBezierPath *)path pointbegin:(CGPoint)point1 pointcenter:(CGPoint)point2  pointend:(CGPoint)point3 {
//    
//    [path moveToPoint:point1];
//    [path addQuadCurveToPoint:point3 controlPoint:point2];
//    
//    
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
