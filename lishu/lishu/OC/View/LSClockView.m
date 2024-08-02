//
//  LSClockView.m
//  lishu
//
//  Created by xueping on 2021/2/28.
//

#import "LSClockView.h"
#import <Masonry/Masonry.h>


@interface LSClockView ()


@property(nonatomic,strong)UIImageView *lockView;

@property(nonatomic,strong)UIView *hourbackView;
@property(nonatomic,strong)UIView *minutebackView;
@property(nonatomic,strong)UIView *secondbackView;
@property(nonatomic,strong)UIImageView *secondView;
@property(nonatomic,strong)UIImageView *hourView;
@property(nonatomic,strong)UIImageView *minuteView;

@end

@implementation LSClockView


- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
//        
//        self.backgroundColor  = [UIColor whiteColor];
        
        [self addSubview:self.lockView];
        
        [self addSubview:self.hourbackView];
        [self addSubview:self.minutebackView];
        [self addSubview:self.secondbackView];
        [self.hourbackView addSubview:self.hourView];
        [self.minutebackView addSubview:self.minuteView];
        [self.secondbackView addSubview:self.secondView];
        
        [self.lockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
        
        [self.hourbackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
        
        [self.minutebackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
        
        [self.secondbackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
        
        
        
        
        
        
        [self.hourView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hourbackView).offset(18);
            make.height.equalTo(@32);
            make.centerX.equalTo(self.hourbackView);
            make.width.equalTo(@8);
        }];
        
        [self.minuteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.minutebackView).offset(12.8);
            make.height.equalTo(@40);
            make.centerX.equalTo(self.minutebackView);
            make.width.equalTo(@8);
        }];
        [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondbackView).offset(12.8);
            make.height.equalTo(@40);
            make.centerX.equalTo(self.secondbackView);
            make.width.equalTo(@8);
        }];
       
        
        
    }
    return self;
}

- (UIView *)hourbackView {
    if (!_hourbackView) {
        _hourbackView = [[UIView alloc] init];
    }
    return _hourbackView;
}

- (UIView *)minutebackView {
    if (!_minutebackView) {
        _minutebackView  = [[UIView alloc] init];
    }
    return _minutebackView;
}

- (UIView *)secondbackView {
    if (!_secondbackView) {
        _secondbackView = [[UIView alloc] init];
    }
    return _secondbackView;
}

- (UIImageView *)lockView {
    if (!_lockView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"clock"];
        [imageview setImage:image];
        _lockView =  imageview;
    }
    return _lockView;
}

- (UIImageView *)secondView {
    if (!_secondView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"second"];
        [imageview setImage:image];
        _secondView =  imageview;
    }
    return _secondView;
}

- (UIImageView *)minuteView {
    if (!_minuteView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"minute"];
        [imageview setImage:image];
        _minuteView =  imageview;
    }
    return _minuteView;
}

- (UIImageView *)hourView {
    if (!_hourView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"hour"];
        [imageview setImage:image];
        _hourView =  imageview;
    }
    return _hourView;
}

- (void)configHour:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        float secondddelta  = seconds/60.0*M_PI *2;
        
       
        self.secondbackView.transform = CGAffineTransformMakeRotation(secondddelta);
        
        float minutesdelta  = (minutes+seconds/60.0)/60.0*M_PI *2;
        
       
        self.minutebackView.transform = CGAffineTransformMakeRotation(minutesdelta);
        
        float hourdelta = (hours%12 +minutes/60.0+ seconds/3600)/12*M_PI*2;
        
        self.hourbackView.transform  =CGAffineTransformMakeRotation(hourdelta);
        
        
    });
    
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
