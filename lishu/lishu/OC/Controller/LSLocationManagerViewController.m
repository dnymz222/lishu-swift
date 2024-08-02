//
//  LSLocationManagerViewController.m
//  lishu
//
//  Created by xueping on 2021/3/27.
//

#import "LSLocationManagerViewController.h"
#import "ColorSizeMacro.h"
#import "LSLocationAddFooter.h"
#import "LSLocationViewController.h"
#import <Masonry/Masonry.h>
#import "LSDataBaseTool.h"
#import "LSLocationManagerCell.h"
#import "KeyMacro.h"
//#import "LSInAppPurchaseViewController.h"
#import "ProgressHUD.h"


@interface LSLocationManagerViewController ()<UITableViewDelegate,UITableViewDataSource,LSLocationAddFooterDelegate,LSLocationViewControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *dataArray;




@end

@implementation LSLocationManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
    self.navigationItem.title = NSLocalizedString(@"location_manage", nil);
    self.dataArray =  [LSDataBaseTool excuteLocationArray];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor );
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSLocationManagerCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSLocationManagerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        cell.textLabel.font   = [UIFont systemFontOfSize:13.f];
//        cell.textLabel.textColor    =UIColorFromRGB(0x666666);
        cell.contentView.backgroundColor   = UIColorFromRGB(navColor);
        cell.backgroundColor =  UIColorFromRGB(navColor);
        cell.accessoryType =  UITableViewCellAccessoryNone;
    }
    
    LSLocation *location   =self.dataArray[indexPath.row];
    [cell configWithLocation:location ];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSLog(@"delete");
    LSLocation *location   =self.dataArray[indexPath.row];
     BOOL result   =   [LSDataBaseTool deleteLocation:location];
    if (result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:locationchanged_note_key object:nil];
        self.dataArray =  [LSDataBaseTool excuteLocationArray];
        [self.tableView reloadData];
        
    }

}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

// 修改Delete按钮文字为“删除”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"delete", nil);
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        
    LSLocation *location   =self.dataArray[indexPath.row];
    return !location.isCurrent;
   
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
      return NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    LSLocationAddFooter *footer  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    if (footer == nil) {
        footer = [[LSLocationAddFooter alloc] initWithReuseIdentifier:@"footer"];
        footer.delegate   = self;
    }
    return footer;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)locationAddFooterViewClick:(UIView *)view {
    
    
    
    if (self.dataArray.count > 1    ) {
        
       
            if (self.dataArray.count > 5) {
                
                [ProgressHUD showError:NSLocalizedString(@"location_manage_max_tip", nil)];
                
            } else{
            
                LSLocationViewController *locationVC = [[LSLocationViewController alloc] init];
                locationVC.delegate = self;
                [self.navigationController pushViewController:locationVC animated:YES];
            }
            
       
        
    } else {
    
    
        LSLocationViewController *locationVC = [[LSLocationViewController alloc] init];
        locationVC.delegate = self;
        [self.navigationController pushViewController:locationVC animated:YES];
    }
    
    
    
}


- (void)lslocationViewControllerSelectLocation:(LSLocation *)location {
    self.dataArray =  [LSDataBaseTool excuteLocationArray];
    [self.tableView reloadData];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
