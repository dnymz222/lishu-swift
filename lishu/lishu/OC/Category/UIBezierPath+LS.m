//
//  UIBezierPath+LS.m
//  lishu
//
//  Created by xueping on 2021/5/18.
//

#import "UIBezierPath+LS.h"

@implementation UIBezierPath (LS)

- (void)ls_drawMoonPhaseArcPoint:(CGPoint)arcCenter radius:(CGFloat)radius lineSegmentC:(CGFloat)lineSegmentC firstArc: (BOOL)firstArc {
    
    if (lineSegmentC == 0.0) {
        return  ;// to avoid the divide by zero error and draw a straight line which we want anyway
    }
    
    BOOL clockwise = lineSegmentC > 0.0;
    
    BOOL direction = firstArc ? clockwise : !clockwise;
    
    float lineSegmentA = radius;
    
     float lineSegmentB = radius;
    
    float lineSegmentD = lineSegmentA * lineSegmentB / lineSegmentC;
    
    CGFloat bigRadius = fabs(lineSegmentC + lineSegmentD) / 2.0;
    
    CGFloat bigCirclePosition = (bigRadius - fabs(lineSegmentC)) * (direction ? 1:-1 );
    
    CGPoint dCenter = CGPointMake(arcCenter.x - bigCirclePosition, arcCenter.y);
    
    CGFloat aDegrees = direction ? 0:180.0;
    
    CGFloat angle1 =[self degreesToRadians:aDegrees] - (asin(radius/bigRadius) * (clockwise ? 1 : -1));
    
    CGFloat angle2 = [self degreesToRadians:aDegrees] + (asin(radius/bigRadius) * (clockwise ? 1 : -1));
    
//    self.addArc(withCenter: dCenter, radius: bigRadius, startAngle: angle1, endAngle: angle2, clockwise: clockwise )
    [self addArcWithCenter:dCenter radius:bigRadius startAngle:angle1 endAngle:angle2 clockwise:clockwise];
   
    
}

- (CGFloat)degreesToRadians:(CGFloat)degrees {
    return (M_PI * degrees) / 180.0;
}

@end
