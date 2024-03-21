//
//  LSLocationViewController.m
//  lishu
//
//  Created by xueping on 2021/3/16.
//

#import "LSLocationViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSNetWorkHandler.h"
#import <YYModel/YYModel.h>

#import "LSDataBaseTool.h"
#import "LSLocationManagerCell.h"
#import "KeyMacro.h"
#import "ProgressHUD.h"

@interface LSLocationViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>


@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *dataArray;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,copy)NSArray *languageArray;
@property(nonatomic,copy)NSArray *languageCodeArray;
@property(nonatomic,assign)NSInteger selectLanuageIndex;



@end

@implementation LSLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth  -80 , 44 )];
    
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    self.searchBar.frame = view.bounds;
    [view addSubview:self.searchBar];
    self.searchBar.barTintColor =[UIColor whiteColor];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
//    UITextField *textfield = [self.searchBar valueForKey:@"_searchField"];
//    textfield.font = [UIFont systemFontOfSize:13.f];
//    textfield.textColor = UIColorFromRGB(0xffffff);
//    [textfield setValue:UIColorFromRGB(0xffffff) forKeyPath:@"_placeholderLabel.textColor"];
//
//    [textfield setValue:[UIFont systemFontOfSize:12.f] forKeyPath:@"_placeholderLabel.font"];
    
    self.searchBar.placeholder  = NSLocalizedString(@"enter_city_name", nil);
    
    
    self.navigationItem.titleView = view;
    
    self.languageArray = @[@"English",@"简体中文",@"繁体中文",@"日本語",@"Français",@"Español",@"Português",@"Deutsch",@"Italiano",@"Pусский",@"한국인",@"Tiếng Việt"];
    self.languageCodeArray = @[@"en",@"zh-cn",@"zh-tw",@"ja",@"fr",@"es",@"pt",@"de",@"it",@"ru",@"ko",@"vi"];
    
    
    
    
    
    [self.view addSubview:self.pickerView];
    CGFloat width  =[UIScreen mainScreen].bounds.size.width;
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@120);
    }];
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.pickerView.mas_bottom).offset(10);
    }];
    
    
    self.selectLanuageIndex = 0;
    
    
    int n = self.languageCodeArray.count;
    
    NSString *language = NSLocalizedString(@"language", nil);
    for (int i = 0; i < n; i++) {
        NSString *code = self.languageCodeArray[i];
        if ([language isEqualToString:code]) {
            self.selectLanuageIndex = i;
            break;
        }
    }
    
//
//    [self.pickerView     reloadAllComponents];
    
    [self.pickerView selectRow:self.selectLanuageIndex inComponent:0 animated:NO];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar  = [[UISearchBar alloc] init];
        _searchBar.delegate  = self;
    }
    return _searchBar;
}

-(UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView   =[[UIPickerView alloc] init];
        _pickerView.delegate  = self;
        _pickerView.dataSource  = self;
    }
    return _pickerView;
}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.languageArray.count;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    

    
    return 200;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont systemFontOfSize:15.f];
        pickerLabel.textColor = UIColorFromRGB(TextDarkColor);
        pickerLabel.adjustsFontSizeToFitWidth = YES;
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;


}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string  =self.languageArray[row];
   
     
    return string;

}





- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40;
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    self.selectLanuageIndex = row;

    
    
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
        
        cell.textLabel.font   = [UIFont systemFontOfSize:13.f];
        cell.textLabel.textColor    =UIColorFromRGB(0x666666);
        cell.contentView.backgroundColor   = UIColorFromRGB(navColor);
        cell.backgroundColor =  UIColorFromRGB(navColor);
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    LSLocation *location  = self.dataArray[indexPath.row];
    
    [cell configWithLocation:location];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LSLocation *location  = self.dataArray[indexPath.row];
    [LSDataBaseTool  addLocation:location ];
    if (self.delegate && [self.delegate respondsToSelector:@selector(lslocationViewControllerSelectLocation:)]) {
        [self.delegate lslocationViewControllerSelectLocation:location];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:locationchanged_note_key object:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (searchBar.text && searchBar.text.length) {
        
        NSString *languagecode =  self.languageCodeArray[self.selectLanuageIndex];
        
        NSDictionary    *dict   =  @{@"key":self.searchBar.text,
                                     @"language":languagecode
        };
        
        
        [LSNetWorkHandler locationCityWithparamater:dict success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
            
            self.dataArray  =[NSArray yy_modelArrayWithClass:[LSLocation class] json:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.dataArray.count) {
                    [self.tableView reloadData];
                } else {
                    [ProgressHUD showError:@"No data"];
                }
                
            });
            
        } failed:^(NSError * _Nonnull error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [ProgressHUD showError:error.localizedDescription];
            });
            
        }];
        
        
        [searchBar resignFirstResponder];
        
    }
    
   
    
    
}






- (UIUserInterfaceStyle)overrideUserInterfaceStyle {

    return UIUserInterfaceStyleLight;
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
