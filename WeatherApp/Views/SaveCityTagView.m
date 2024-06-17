//
//  DownListView.m
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import "SaveCityTagView.h"
#import "LaunchVC.h"
#import "DownPickerView.h"
#import "CityitemCell.h"
#import "SaveModelManager.h"
#import "UIView+AnimationView.h"

#define cityidentifier @"CityitemCell"
#define cellWidth ScreenWidth-40

@interface SaveCityTagView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *history_lab;
@property (nonatomic, strong) UIButton *edit_item;
@property (nonatomic, strong) UITableView *city_historyTable;
@property (nonatomic, strong) NSArray *city_arr;
@property (nonatomic, assign) BOOL hasClick;

@end

@implementation SaveCityTagView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_edit_item.selected) {
        // 点击删除时候不响应
        return;
    }
    NSData *modelData = [_city_arr objectAtIndex:indexPath.section];
    CityInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    if (self.city_chooseBlock) {
        self.city_chooseBlock(model);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _city_arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityitemCell *cell = [tableView dequeueReusableCellWithIdentifier:cityidentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    NSData *modelData = [_city_arr objectAtIndex:indexPath.section];
    CityInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    cell.label_city_name.text = model.city_name;
    [cell.label_city_name sizeToFit];
    cell.label_weather_desc.text = model.weather_desc;
    [cell.label_weather_desc sizeToFit];
    CGFloat currentTemp = -273.15 + [model.current_temp doubleValue];
    NSString *temp = [NSString stringWithFormat:@"%.0f",currentTemp];
    cell.label_current_temp.text = [NSString stringWithFormat:@"%d °C",[temp intValue]];
    cell.label_weather_humidity.text = [NSString stringWithFormat:@"Humidity: %@ %%",model.weather_humidity];
    WeakSelf(weakSelf);
    cell.deleteBlock = ^{
        [weakSelf deletePlace:indexPath.section];
    };
    if (indexPath.section == 0 && self.location_isAllow == YES) {
        cell.cell_deletebtn.hidden = YES;
        cell.label_city_name.text = @"My Location";
        [cell.label_city_name sizeToFit];
        cell.rightView.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    else {
        cell.cell_deletebtn.hidden = !self.edit_item.selected;
        if (self.edit_item.selected == YES) {
            [UIView animateWithDuration:0.2 animations:^{
                cell.rightView.transform = CGAffineTransformMakeTranslation(30, 0);
                self.hasClick = YES;
            }];
        }
        else{
            [UIView animateWithDuration:0.2 animations:^{
                cell.rightView.transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        }
    }
    return cell;
}

# pragma mark - 删列表后更新数据
- (void)reloadNewData:(NSInteger)idx {
    NSMutableArray *city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cityList"]];
    _city_arr = city_arr;
    [self.city_historyTable reloadData];
}

- (void)deletePlace:(NSInteger)idx {
    NSLog(@"delete line %ld",idx);
    NSData *modelData = [_city_arr objectAtIndex:idx];
    CityInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    if (self.location_isAllow) {
        [SaveModelManager deleteCityModelWithDefault:model];
    }
    else {
        [SaveModelManager deleteCityModel:model];
    }
    [self reloadNewData:idx];
}

- (NSArray *)city_arr {
    if (!_city_arr) {
        _city_arr = [NSArray array];
    }
    return _city_arr;
}

- (void)editClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.city_historyTable reloadData];
}

- (void)setview {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *backview = [[UIImageView alloc] init];
    backview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backview.image = [UIImage imageNamed:@"Background"];
    [self addSubview:backview];
    
    _history_lab = [[UILabel alloc] initWithFrame:CGRectMake(0, topInset + 10, ScreenWidth, 50)];
    _history_lab.text = @"Weather History";
    _history_lab.textColor = [UIColor colorWithRed:29/255.0 green:177/255.0 blue:177/255.0 alpha:1];
    _history_lab.font = [UIFont fontWithName:@"Lato-Bold" size:30];
    [_history_lab sizeToFit];
    [self addSubview:_history_lab];
    
    _edit_item = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 90, topInset + 10, 80, 50)];
    [_edit_item setImage:[UIImage imageNamed:@"Edit"] forState:UIControlStateNormal];
    [_edit_item setTitle:@"Edit" forState:UIControlStateNormal];
    [_edit_item setTitle:@"Finish" forState:UIControlStateSelected];
    _edit_item.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:20];
    [_edit_item addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_edit_item];
    
//    _city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cityList"]];
    
    CityInfoModel *saveModel = [CityInfoModel new];
    saveModel.city_name = @"Guangzhou";
    saveModel.weather_desc = @"Modern Rain";
    saveModel.weather_icon_string = @"aa";
    saveModel.current_temp = @"28";
    saveModel.weather_humidity = @"70";
    
    CityInfoModel *defaultModel = [CityInfoModel new];
    defaultModel.city_name = @"My Location";
    defaultModel.weather_desc = @"Modern Rain";
    defaultModel.weather_icon_string = @"aa";
    defaultModel.current_temp = @"28";
    defaultModel.weather_humidity = @"70";
    NSMutableArray *city_arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cityList"]];
    _city_arr = city_arr;
    
    _city_historyTable = [[UITableView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_history_lab.frame)+30, ScreenWidth-40, self.frame.size.height - CGRectGetMaxY(_history_lab.frame)-30-100)];
    _city_historyTable.delegate = self;
    _city_historyTable.dataSource = self;
    _city_historyTable.backgroundColor = [UIColor clearColor];
//    _city_historyTable.estimatedRowHeight = 50;
    _city_historyTable.rowHeight = 50;
    _city_historyTable.estimatedSectionFooterHeight = 0.0;
    _city_historyTable.estimatedSectionHeaderHeight = 0.0;
    _city_historyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_city_historyTable registerClass:[CityitemCell class] forCellReuseIdentifier:cityidentifier];
    [self addSubview:_city_historyTable];
    
}




@end
