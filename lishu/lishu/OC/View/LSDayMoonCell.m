//
//  LSDayMoonCell.m
//  lishu
//
//  Created by xueping on 2021/5/18.
//

#import "LSDayMoonCell.h"
#import "LSPhaseView.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>




@interface LSDayMoonCell ()


@property(nonatomic,strong)UIImageView *phaseView;

@property(nonatomic,strong)UILabel *riseLabel;
@property(nonatomic,strong)UILabel *otherLabel;

@end

@implementation LSDayMoonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        
        [self.contentView addSubview:self.phaseView];
        [self.contentView addSubview:self.riseLabel];
        [self.contentView addSubview:self.otherLabel];
        [self.phaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@56);
            make.height.equalTo(@56);
        }];
        
        [self.riseLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phaseView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.otherLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.phaseView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_centerY);
        }];
        
        
    }
    return self;
}

- (UIImageView   *)phaseView {
    if (!_phaseView) {
        _phaseView = [[UIImageView alloc] init];
        _phaseView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _phaseView;
}

- (UILabel *)riseLabel {
    if (!_riseLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _riseLabel= label;
    }
    return _riseLabel;
}


- (UILabel *)otherLabel {
    if (!_otherLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _otherLabel = label;
    }
    return _otherLabel;
}

//- (void)cinfigFaseView{
//    __block NSInteger i =  [[NSUserDefaults standardUserDefaults] integerForKey:@"big3fase"]?:0;
//
//    [_phaseView configPhase:i*12/360.0];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          [self saveImageWithIndex:i];
//            i=  i +1;
//        [[NSUserDefaults standardUserDefaults] setInteger:i forKey:@"big3fase"];
//                     }
//                   );
    
    
    
    
    
    
//}

//- (void)saveImageWithIndex:(NSInteger)index
//{
//
//
//    UIGraphicsBeginImageContext(_phaseView.frame.size);
//    [_phaseView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
//
//
//
//    UIGraphicsEndImageContext();
//
//
//
//
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
//
//    NSString *imagename = [NSString stringWithFormat:@"big_moon_%02ld@3x.png",index];
//
//    path = [path stringByAppendingPathComponent:imagename];
//
//    NSLog(@"imagename:%@",path);
//
//    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
//
//
//
//
//}


- (void)configDay:(LSDay *)day {
    
    
    int phase = ((int)((day.phase_delta/12)+0.5))%30;
    NSString *imagename = [NSString stringWithFormat:@"big_moon_%02d",phase];
    [self.phaseView setImage:[UIImage imageNamed:imagename   ]];
    
    self.riseLabel.text = [NSString stringWithFormat:@"%@:%@ %@:%@%@",NSLocalizedString(@"moon_rise", nil),[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.moon.moonRiseJD],NSLocalizedString(@"moon_set", nil),[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.moon.moonSetJD],day.moon.moonnextDay?@"(+1d)":@""];
    
    self.otherLabel.text = [NSString stringWithFormat:@"%@:%0.1f%@ %@:%0.1f%@",NSLocalizedString(@"moon_age", nil),day.moon.moonage,NSLocalizedString(@"days", nil),NSLocalizedString(@"illumination", nil),day.moon.moonillumation*100,@"%"];
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
