//
//  LSDatePickerView.m
//  lishu
//
//  Created by xueping on 2021/12/11.
//

#import "LSDatePickerView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSDate.h"


@interface LSDatePickerView ()

@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *defineButton;

@property(nonatomic,strong)NSDate *selectDate;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)UIView *navView;

@end

@implementation LSDatePickerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor  = UIColorFromRGB(cellbackGroundColor);
        [self addSubview:self.datePicker];
        [self addSubview:self.navView];
        [self.navView addSubview:self.cancelButton];
        [self.navView addSubview:self.defineButton];
        
        [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@44);
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@64);
            make.height.equalTo(@44);
        }];
        
        [self.defineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self);
            make.width.equalTo(@64);
            make.height.equalTo(@44);
        }];
        
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self).offset(44);
        }];
        
        
        
        
        
    }
    return self;
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = UIColorFromRGB(navColor);
    }
    return _navView;
}


- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker  =[[UIDatePicker alloc] init];
        _datePicker.datePickerMode  = UIDatePickerModeDate;
        
        if (@available(iOS 13.4, *)) {
//                _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//新发现这里不会根据系统的语言变了
                _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
                        // Fallback on earlier versions
            }
        
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _datePicker;
}

- (void)dateChanged:(UIDatePicker *)picker{
    
    self.selectDate  = picker.date;
    
    
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds =  CGRectMake(0, 0, 44, 44);
//        UIImage *image = [UIImage imageNamed:<#imagename#>];
//        [button setImage:image forState:UIControlStateNormal];
        NSDictionary *attrsdict  =@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                    NSForegroundColorAttributeName:UIColorFromRGB(0x666666)
        };
        NSAttributedString *attrs  =[[NSAttributedString alloc] initWithString:NSLocalizedString(@"cancel", nil) attributes:attrsdict];
        [button addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setAttributedTitle:attrs forState:UIControlStateNormal];
        _cancelButton = button;
    }
    return _cancelButton;
}


- (void)cancelButtonClick:(UIButton *)button {
    self.delegate  =nil;
    [self removeFromSuperview];
}

- (UIButton *)defineButton {
    if (!_defineButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds =  CGRectMake(0, 0, 44, 44);
        NSDictionary *attrsdict  =@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                    NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor)
        };
        NSAttributedString *attrs  =[[NSAttributedString alloc] initWithString:NSLocalizedString(@"define", nil) attributes:attrsdict];
        [button setAttributedTitle:attrs forState:UIControlStateNormal];
  
        [button addTarget:self action:@selector(defineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _defineButton = button;
    }
    return _defineButton;
}

- (void)defineButtonClick:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewSelectDate:)]) {
        [self.delegate datePickerViewSelectDate:self.selectDate];
    }
    [self removeFromSuperview];
}


+ (void)showInView:(UIView *)view delegate:(id<LSDatePickerViewDelegate>)delegate date:(NSDate *)date {
    
//    if ([MLTool hasKindofSubview:[MLDatePickerView class] inView:view ]) {
//        return;
//    }
    
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[LSDatePickerView class]]) {
            return;
        }
    }
    
    
    LSDatePickerView *pickerview  = [[LSDatePickerView alloc] init];
    [view addSubview:pickerview ];
    pickerview.delegate  =delegate;
    CGFloat bottomheight  =0;
    [pickerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.bottom.equalTo(view).offset(-bottomheight);
        make.height.equalTo(@256);
    }];
    
    [pickerview.datePicker setDate:date];
    pickerview.selectDate  =date;
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
