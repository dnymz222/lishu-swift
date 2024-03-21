//
//  LSTimeZoneMapOverLayView.m
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import "LSTimeZoneMapOverLayView.h"
#import "LSTimeZoneMapLocation.h"

@interface LSTimeZoneMapOverLayView ()

@property(nonatomic,copy)NSArray *locationArray;

@end

@implementation LSTimeZoneMapOverLayView

- (instancetype)initWithFrame:(CGRect)frame {
    self  =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if (self.locationArray) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextClearRect(ctx, rect);
        
        CGContextBeginPath(ctx);
        
        int n = (int) self.locationArray.count;
        for (int i = 0; i < n; i ++) {
            LSTimeZoneMapLocation *location  = self.locationArray[i];
            NSLog(@"%d:x:%0.1f,y:%0.1f",i,location.location.coordinate.longitude,location.location.coordinate.latitude);
            if (0== i) {
                CGContextMoveToPoint(ctx, location.x/6, location.y/6);
            } else {
                CGContextAddLineToPoint(ctx, location.x/6, location.y/6);
            }
        }
        
        CGContextSetLineWidth(ctx, 2);
        CGContextStrokePath(ctx);
        
        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
        
        CGContextClosePath(ctx);
    }
    
    
    //1.获得图形上下文
 

    //2.拼接图形（路径）
    //设置一个起点（之所以在参数中传上下文是为了把点存到上下文中）
    
    
//    CGContextMoveToPoint（ctx，10,10）；
//    //添加一条线段到点（100,100）
//    CGContextAddLineToPoint（ctx，100,100）；
//    //再添加一条线段[会从（100,100）继续画]
//    CGContextAddLineToPoint（ctx，150,40）；
//    //3.显示所绘制的东西
//    CGContextStrokePath（ctx）；//空心
//    // CGContextFillPath（ctx）； //实心
    
    
}


- (void)configLocationArray:(NSArray *)locations {
    
    self.locationArray  = locations;
    
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
