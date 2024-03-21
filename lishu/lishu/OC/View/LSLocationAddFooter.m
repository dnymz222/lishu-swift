//
//  LSLocationAddFooter.m
//  lishu
//
//  Created by xueping on 2021/4/4.
//

#import "LSLocationAddFooter.h"
#import <Masonry/Masonry.h>


@interface LSLocationAddFooter ()

@property(nonatomic,strong)UIButton *addButton;

@end

@implementation LSLocationAddFooter


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self  = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(@60);
        }];
        
    }
    return self;
}


-(UIButton *)addButton {
    if (!_addButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"add"];;
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _addButton  = button;
    }
    return _addButton    ;
}

- (void)addButtonClick:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationAddFooterViewClick:)]) {
        [self.delegate locationAddFooterViewClick:self];
    }
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
