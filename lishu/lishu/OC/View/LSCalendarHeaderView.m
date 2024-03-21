//
//  LSCalendarHeaderView.m
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import "LSCalendarHeaderView.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSCalendarHeaderView ()


//@property(nonatomic,strong)NSMutableArray *labels;


//@property(nonatomic,copy)NSArray *titles;



@end

@implementation LSCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self   =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(navColor);
        
        
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width/7.0;
//        self.labels =  [NSMutableArray array];
//        self.titles = @[ NSLocalizedString(@"week_0_s", nil),NSLocalizedString(@"week_1_s", nil),NSLocalizedString(@"week_2_s", nil),NSLocalizedString(@"week_3_s", nil),NSLocalizedString(@"week_4_s", nil),NSLocalizedString(@"week_5_s", nil),NSLocalizedString(@"week_6_s", nil)];
        for (int i = 0; i < 7; i++) {
            UILabel *label = [self label];
//            [self.labels  addObject:label];
            [self addSubview:label];
            label.frame = CGRectMake(width*i, 0, width, 30);
            NSString *title = [NSString stringWithFormat:@"week_%d_s",i];
            label.text =  [[NSBundle mainBundle] localizedStringForKey:title value:@"" table:@"lish"];
            
        }
        
    }
    return self;
}

-   (UILabel *)label {
  
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        return label;
  
}




@end
