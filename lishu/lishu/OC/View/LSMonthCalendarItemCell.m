//
//  LSMonthCalendarItemCell.m
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import "LSMonthCalendarItemCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSUinitTool.h"

@interface LSMonthCalendarItemCell ()

@property(nonatomic,strong)UILabel *numberButton;
@property(nonatomic,strong)UILabel *calendarLabel;
@property(nonatomic,strong)UILabel *holidayLabel;
@property(nonatomic,strong)UIButton *xiujiaButton;

@end

@implementation LSMonthCalendarItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self   =[super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        
        
        [self.contentView addSubview:self.numberButton];
        [self.contentView addSubview:self.calendarLabel];
        [self.contentView addSubview:self.holidayLabel];
        
        [self.contentView addSubview:self.xiujiaButton];
        
        [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(1);
            make.width.equalTo(@36);
            make.height.equalTo(@16);
            make.centerX.equalTo(self.contentView);
        }];
        
        [self.calendarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.numberButton.mas_bottom).offset(1);
            make.height.equalTo(@25);
            
        }];
        
        [self.holidayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.calendarLabel.mas_bottom).offset(1);
            make.height.equalTo(@25);
            
        }];
        
        [self.xiujiaButton   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-2);
            make.top.equalTo(self.contentView).offset(2);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
        
    }
    return self;
}

-(UILabel *)numberButton {
    if (!_numberButton) {
//        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, 44, 44);
//        button.userInteractionEnabled =  NO;
//        NSDictionary *attrsDict = @{NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor),
//                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f]
//        };
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:16.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        
//        NSAttributedString *attrs = [[NSAttributedString alloc] initWithString:@"20" attributes:attrsDict];
//        [button setAttributedTitle:attrs forState:UIControlStateNormal];
//        [button addTarget:self action:<#selector#> forControlEvents:UIControlEventTouchUpInside];
        _numberButton  = label;
    }
    return _numberButton;
}


-(UIButton *)xiujiaButton {
    if (!_xiujiaButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 15, 15);
        UIImage *image   =[UIImage imageNamed:@"xiujia"];
        [button setImage:image forState:UIControlStateSelected];
        
        UIImage *normalimage = [LSUinitTool GetImageWithColor:[UIColor clearColor] andHeight:30];
        [button setImage:normalimage forState:UIControlStateNormal];
        _xiujiaButton.userInteractionEnabled = NO;
        
        _xiujiaButton  = button;
    }
    return _xiujiaButton    ;
}


- (UILabel *)calendarLabel {
    if (!_calendarLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        label.numberOfLines = 0;

        _calendarLabel = label;
    }
    return _calendarLabel;
}

- (UILabel *)holidayLabel {
    if (!_holidayLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11.f];
        label.textColor  = [UIColor blueColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.numberOfLines = 0;
        _holidayLabel = label;
    }
    return _holidayLabel;
}

- (void)configLsday:(LSDay *)day calendar:(NSInteger)calendarIndex
{
    
    if (day) {
        
        self.numberButton.text = [NSString stringWithFormat:@"%d",day.lsdate.localDay];
//        if (islocked) {
//
//            self.calendarLabel.text = @"🔐";
//
//        } else {
        
           
            LSCalendarTypeModel *calendar = day.clanedarArray[calendarIndex];
            self.calendarLabel.text = calendar.displayDayString;
            if (calendar.isFestival || calendar.isSolarTerm) {
                self.calendarLabel.textColor = [UIColor redColor];
            } else {
                self.calendarLabel.textColor = UIColorFromRGB(TextDarkColor);
            }
//        }
        
        
    } else {
        
        self.numberButton.text = @"";
        self.calendarLabel.text = @"";
    }
    
    
    
}



- (void)configWorkingDayModel:(LSWorkingdayModel *)workingDayModel  {
    if (!workingDayModel) {
        self.xiujiaButton.selected = NO;
        self.holidayLabel.text = @"";
    } else {
        
        if ([@"1"  isEqualToString:workingDayModel.working_day]) {

            self.xiujiaButton.selected = NO;
        } else{
            
            self.xiujiaButton.selected = YES;
        }
        
//        if (islocked) {
//            self.holidayLabel.text = @"🔐";
//        }else
        if ([@"1" isEqualToString:workingDayModel.public_holiday]) {
            
            self.holidayLabel.text = [[NSBundle mainBundle] localizedStringForKey:workingDayModel.public_holiday_description value:@"" table:@"lish"];
        } else {
            
            self.holidayLabel.text = @"";
        }
        
        
        
    }
}








@end
