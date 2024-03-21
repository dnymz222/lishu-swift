//
//  LSMineViewController.m
//  lishu
//
//  Created by xueping on 2021/2/28.
//

#import "LSMineViewController.h"
#import "ColorSizeMacro.h"
#import "LSHandler.h"
#import <Masonry/Masonry.h>
#import "LSEraViewController.h"
#import "LSCalendarGroup.h"
#import "LSNormalHeaderView.h"
#import "LSWkWiewViewController.h"
#import "KeyMacro.h"
//#import "LSInAppPurchaseViewController.h"
#import "ProgressHUD.h"
//#import "LSNavgationController.h"
//#import "LSInAppPurchaseHandler.h"

@interface LSMineViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,copy)NSArray *itemArray;
@property(nonatomic,assign)BOOL isVip;




@end

@implementation LSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   =UIColorFromRGB(ViewBackGroundColor);
    self.navigationItem.title = NSLocalizedString(@"tab_more", nil);

    

    
    self.itemArray = @[
                        @[NSLocalizedString(@"rate_on_app_store", nil),NSLocalizedString(@"share_to_friends", nil),NSLocalizedString(@"privacy_policy", nil),NSLocalizedString(@"terms_of_service", nil),NSLocalizedString(@"lan_setting", nil),NSLocalizedString(@"version", nil)]
                     ];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveInappPurchaseSuccessNote) name:purchase_success_note_key object:nil];
//
    
    // Do any additional setup after loading the view.
}

//- (void)receiveInappPurchaseSuccessNote {
//    self.isVip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
//}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (1 == section) {
        NSArray *array = self.itemArray[0];
        return array.count;
    }  else {
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = UIColorFromRGB(TextDarkColor);
        
        cell.detailTextLabel.textColor = UIColorFromRGB(TextLightColor);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
       
    }
     if (1 == indexPath.section){
        cell.detailTextLabel.text  =@"";
        NSArray *array = self.itemArray[0];
        NSString *string = array[indexPath.row];
        cell.textLabel.text  = string;
        
        if (5 == indexPath.row) {
            NSDictionary *infoDictionary  = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text = app_Version;
        }
        
     } else {
         if( 0 == indexPath.row){
             cell.textLabel.text = NSLocalizedString(@"purchase_membership", nil);
         } else if (1 == indexPath.row){
             cell.textLabel.text = NSLocalizedString(@"restore", "");
         }
     }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LSNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    
//    if (1 == section) {
//        headerView.titleLabel.text = NSLocalizedString(@"era", nil);
//    } else {
//        headerView.titleLabel.text = @"";
//    }
    
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     if (1 == indexPath.section){
        

            
            if (0 == indexPath.row) {
                NSString *urlStr = [NSString
                                     
                                     stringWithFormat:@"https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8",
                                     
                                     @"1281770398"];
                NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:options
                                          completionHandler:^(BOOL success) {
                     
                     
                     
                 }];
            
            } else if (1 == indexPath.row){
                [self activityShare];
                
            } else if (2 == indexPath.row){
                
                LSWkWiewViewController *webVC  =[[LSWkWiewViewController alloc] init];
                webVC.urlString  = NSLocalizedString(@"privacy_url", nil);
                 webVC.navtitle = NSLocalizedString(@"privacy_policy", nil);
                
                [self.navigationController pushViewController:webVC animated:YES];
                
            } else if (3 == indexPath.row){
                
                LSWkWiewViewController *webVC  =[[LSWkWiewViewController alloc] init];
                webVC.urlString  = NSLocalizedString(@"service_url", nil);
                webVC.navtitle = NSLocalizedString(@"terms_of_service", nil);
                [self.navigationController pushViewController:webVC animated:YES];
                
            } else if (4 == indexPath.row){
                
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                            //此处可以做一下版本适配，至于为何要做版本适配，大家应该很清楚
              
                NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
                    
                [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {
                        
                    }];
               
                
            } else {
                
                NSString *urlStr = NSLocalizedString(@"app_url", nil);
                NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:options
                                          completionHandler:^(BOOL success) {
                     
                     
                     
                 }];
                
                
              }
        
        
        
    }
    
    
}
    
    
- (void)activityShare{

        // 1、设置分享的内容，并将内容添加到数组中
        NSString *shareText = NSLocalizedString(@"app_name", nil);
        UIImage *shareImage = [UIImage imageNamed:@"lishu_icon.png"];
        NSURL *shareUrl = [NSURL URLWithString:NSLocalizedString(@"app_url", nil)];
        NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];



        // 2、初始化控制器，添加分享内容至控制器
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItemsArray applicationActivities:nil];

        activityVC.excludedActivityTypes=@[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList ];


    //    activityVC.modalPresentationStyle = UIModalPresentationFormSheet;
        activityVC.modalInPopover = YES;
        // 3、设置回调
    //    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            // ios8.0 之后用此方法回调
            UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
                //NSLog(@"activityType == %@",activityType);
                if (completed == YES) {
    //                NSLog(@"completed");
                }else{
    //                NSLog(@"cancel");
                }
            };
            activityVC.completionWithItemsHandler = itemsBlock;
    //    }
        NSString    *model = [UIDevice currentDevice].model;
        BOOL ispad = [model containsString:@"iPad"];
        if (ispad) {
               CGSize size = [UIScreen mainScreen].bounds.size;

            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:activityVC];
            activityVC.navigationItem.title =NSLocalizedString(@"share_to_friends", nil);


               nav.popoverPresentationController.sourceRect = CGRectMake(size.width/2, size.height/2-120, 0, 0) ;
               nav.popoverPresentationController.sourceView = self.view ;
               nav.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;

            [self presentViewController:nav animated:YES completion:^{

            }];


    //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        button.frame =CGRectMake(size.width/2-60,size.height/2-120 , 120, 60);
    //        activityVC.popoverPresentationController.barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: button];
        } else {



        // 4、调用控制器
            [self presentViewController:activityVC animated:YES completion:nil];
        }


}


- (UIUserInterfaceStyle)overrideUserInterfaceStyle {

    return UIUserInterfaceStyleLight;
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
