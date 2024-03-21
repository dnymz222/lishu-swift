//
//  UIBezierPath+LS.h
//  lishu
//
//  Created by xueping on 2021/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (LS)

- (void)ls_drawMoonPhaseArcPoint:(CGPoint)arcCenter radius:(CGFloat)radius lineSegmentC:(CGFloat)lineSegmentC firstArc: (BOOL)firstArc;

@end

NS_ASSUME_NONNULL_END
