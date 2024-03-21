//
//  LSHandler.m
//  lishu
//
//  Created by xueping on 2021/3/30.
//

#import "LSHandler.h"
#import "ColorSizeMacro.h"
#import "LSDataBaseTool.h"
#import "KeyMacro.h"


@interface LSHandler ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LSHandler

//+ (LSHandler *)shareHandler {
//    
//    static LSHandler *handler;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        handler  =[[LSHandler alloc] init];
//    });
//    
//    return handler;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.locationArray =[LSDataBaseTool excuteLocationArray];
        [self reloadSelectData];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLocationChangeNote:) name:locationchanged_note_key object:nil];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 260) style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(navColor);
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
    
}


- (void)receiveLocationChangeNote:(NSNotification *)note {
    
    
    
    if (!self.locationArray.count) {
        
        [self reloadData];
        
        LSLocation *location = [self.locationArray firstObject];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectHandlerTableViewSelectLocation:)]) {
            [self.delegate selectHandlerTableViewSelectLocation:location];
        }
         
    } else {
        
        [self reloadData];
        
    }
    
}

- (void)reloadData {
    
    self.locationArray = [LSDataBaseTool excuteLocationArray];
    [self.tableView reloadData];
}

- (void)reloadSelectData {
    
    if (self.locationArray.count) {
        self.selectLocation = [self.locationArray firstObject];
        for (LSLocation *location in self.locationArray) {
            if (location.selected) {
                self.selectLocation =  location;
                return;
            }
        }
    } else {
        self.selectLocation = nil;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.locationArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font   = [UIFont systemFontOfSize:13.f];
        cell.textLabel.textColor    =UIColorFromRGB(0x666666);
        cell.contentView.backgroundColor   = UIColorFromRGB(navColor);
        cell.backgroundColor =  UIColorFromRGB(navColor);
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    LSLocation *location  = self.locationArray[indexPath.row];
    cell.textLabel.text  = location.LocalizedName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGPoint origin  = tableView.frame.origin;
    
    LSLocation *location  = self.locationArray[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectHandlerTableViewSelectLocation:)]) {
        [self.delegate selectHandlerTableViewSelectLocation:location];
    }
     
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        tableView.frame  = CGRectMake(origin.x, origin.y, 200, 0);
        
        
    } completion:^(BOOL finished) {
        
        [tableView removeFromSuperview];
        
    }];
    
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
