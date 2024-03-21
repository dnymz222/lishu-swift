//
//  LSPhaseView.m
//  lishu
//
//  Created by xueping on 2021/5/18.
//

#import "LSPhaseView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "ColorSizeMacro.h"
#import "UIBezierPath+LS.h"

@interface LSPhaseView ()


@property(nonatomic,assign)float moomphase;

@property(nonatomic,assign)float shadowAlpha;



@property(nonatomic,strong) UIColor *shadowColor;

@end

@implementation LSPhaseView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.moomphase = 0.3;
       
        self.shadowAlpha = 1;
        self.shadowColor = UIColorFromRGB(0x222222);

//        self.layer.cornerRadius = 22.f;
//        self.layer.masksToBounds = YES;
    }
    
    return self;
}


- (void)configPhase:(float)phase  {
    
    self.moomphase  = phase;
    

    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    
    CGFloat radius = CGRectGetWidth(rect)/2;
    
    CGFloat r = 0; CGFloat g = 0; CGFloat b = 0; CGFloat a = 0;
    //shadowColor.getRed(&r, green: &g, blue: &b, alpha: &a)
    [self.shadowColor  getRed:&r green:&g blue:&b alpha:&a];
    
    UIColor *paintColor = [UIColor colorWithRed:r green:g blue:b alpha:self.shadowAlpha];
    
    [paintColor setStroke];
    [paintColor setFill];
    
//    paintColor.setStroke()
//    paintColor.setFill()
    
    CGPoint centerInBounds = CGPointMake( CGRectGetMidX(rect),CGRectGetMidY(rect));
    
    
    // new moon around 0 and 1, also protects around erroneous cases
    if (self.moomphase < 0.01 || self.moomphase > 0.99 ) {
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerInBounds radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
        [path fill];
        
//        UIBezierPath(arcCenter: centerInBounds, radius: radius, startAngle: 0.0, endAngle:.pi * 2.0, clockwise: true).fill();
//        [UIBezierPath ]
        
        return;
    } else if (fabs(self.moomphase-0.5) < 0.01){
        
        [[UIColor whiteColor] setStroke];
        
        [[UIColor whiteColor] setFill];
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerInBounds radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
        
        [path fill];
        
//        UIBezierPath(arcCenter: centerInBounds, radius: radius, startAngle: 0.0, endAngle:.pi * 2.0, clockwise: true).fill();
//        [UIBezierPath ]
        
        return;
        
    }
    
    CGFloat c1 = self.moomphase > 0.5 ? radius : -radius * (self.moomphase - 0.25 ) * 4.0;
    
    CGFloat c2 = self.moomphase < 0.50000001 ? radius :  radius * (self.moomphase- 0.75 ) * 4.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path ls_drawMoonPhaseArcPoint:centerInBounds radius:radius lineSegmentC:c1 firstArc:YES];
    [path ls_drawMoonPhaseArcPoint:centerInBounds radius:radius lineSegmentC:c2 firstArc:NO];

    
    [path fill];
    [path stroke];
    
  
    
    
}


- (CGFloat) degreesToRadians:(CGFloat)degrees  {
    return (M_PI * degrees) / 180.0;
}

- (void)rotateShadow:(CGFloat)degrees {
    self.transform = CGAffineTransformMakeRotation([self degreesToRadians:degrees]);
   
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width  =self.frame.size.width;
    self.layer.cornerRadius = width/2.0;
    self.layer.masksToBounds = YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
