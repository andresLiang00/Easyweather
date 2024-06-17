//
//  ViewController.m
//  WeatherApp
//
//  Created by Andres on 2024/4/22.
//

#import "LaunchVC.h"
#import "SearchCityView.h"
#import "WeatherView.h"
#import "HumidityView.h"
#import "ProcessView.h"
#import "WindView.h"
#import "TempeatureView.h"
#import "MaxMinTempView.h"
#import "SuntimeView.h"
#import "DownPickerView.h"
#import "WeatherRequest.h"
#import "CityInfoModel.h"
#import "SaveModelManager.h"
#import "SaveCityTagView.h"
#import <CoreLocation/CoreLocation.h>
#import <AFNetworkReachabilityManager.h>


#define RotateAngle(degrees)  ((M_PI * (degrees))/ 180.f)


@interface LaunchVC ()<UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate>

@property (nonatomic, assign) CGFloat squareHeight;
@property (nonatomic, strong) UILabel *weatherTitle;
@property (nonatomic, strong) SearchCityView *cityView;
@property (nonatomic, strong) UIView *upperView;
@property (nonatomic, strong) WeatherView *weatherview;
@property (nonatomic, strong) HumidityView *numview;
@property (nonatomic, strong) TempeatureView *tempview;
@property (nonatomic, strong) MaxMinTempView *maxminTempView;
@property (nonatomic, strong) WindView *windSpeedview;
@property (nonatomic, strong) SuntimeView *sunview;

@property (nonatomic, strong) ProcessView *loadingView;
@property (nonatomic, strong) UIButton *downDragBtn;

@property (nonatomic, strong) DownPickerView *downListView;

@property (nonatomic, strong) CLLocationManager *locateManager;
// 存储当前的地理位置信息
@property (nonatomic, strong) CLGeocoder *currentGeoCode;
// 存储个人位置
@property (nonatomic, retain) CLLocation *myLocation;
// 存储个人城市
@property (nonatomic, copy) NSString *myLocation_City;

// 请求权限
@property (nonatomic, assign) BOOL location_authorization;

@property (nonatomic, copy) void(^acceessNetwork)(void);
// 新增或历史搜索成功的城市标签
@property (nonatomic, strong) UIButton *history_edit_Btn;

// 保存查询的城市记录
@property (nonatomic, strong) UIButton *add_save_Btn;

@property (nonatomic, strong) SaveCityTagView *saveCityTagView;

@property (nonatomic, strong) CityInfoModel *currentModel;
@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createMain];
    [self locationRequest];
    
}

- (void)createMain {
    [self accessNetwork];
    self.view.backgroundColor = [UIColor whiteColor];
    // 标题
    _weatherTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, topInset, self.view.frame.size.width, 40)];
    _weatherTitle.text = @"Islamabad";
    _weatherTitle.textAlignment = NSTextAlignmentCenter;
    _weatherTitle.font = [UIFont fontWithName:@"ArialMT" size:25];
    _weatherTitle.textColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1];
    [self.view addSubview:_weatherTitle];
    
    // 保存添加按钮
    _add_save_Btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, topInset, 40, 40)];
    NSMutableAttributedString *addContent = [[NSMutableAttributedString alloc] initWithString:@"add" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Lato-Bold" size:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [_add_save_Btn setAttributedTitle:addContent forState:UIControlStateNormal];
    // 先隐藏按钮 搜索的时候展示
    _add_save_Btn.hidden = YES;
    [_add_save_Btn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_add_save_Btn];
    
    //搜索城市
    _cityView = [[SearchCityView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_weatherTitle.frame), self.view.frame.size.width, 50)];
    [_cityView buildCityView];
    _cityView.inputBox.delegate = self;
    [self.view addSubview:_cityView];
    
    _squareHeight = (ScreenHeight - CGRectGetMaxY(_cityView.frame) - botInset)/3.0f;
    _upperView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cityView.frame), self.view.frame.size.width, 3 * _squareHeight)];
    [self.view addSubview:_upperView];
    
    _weatherview = [[WeatherView alloc] initWithFrame:CGRectMake(0, 0 , 0.5 * self.view.frame.size.width, _squareHeight)];
    [_weatherview buildWeather];
    [_upperView addSubview:_weatherview];
    
    _numview = [[HumidityView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weatherview.frame), 0, 0.5 * self.view.frame.size.width, _squareHeight)];
    [_numview buildView];
    [_upperView addSubview:_numview];
    
    _windSpeedview = [[WindView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_numview.frame), 0.5 * self.view.frame.size.width, _squareHeight)];
    _windSpeedview.windSpeed = 1.f;
    [_windSpeedview showWindSpeed];
    [_upperView addSubview:_windSpeedview];
    
    _tempview = [[TempeatureView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weatherview.frame), CGRectGetMaxY(_numview.frame), 0.5 * self.view.frame.size.width, _squareHeight)];
    [_tempview buildTempView];
    [_upperView addSubview:_tempview];
    
    _maxminTempView = [[MaxMinTempView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_windSpeedview.frame), 0.5 * self.view.frame.size.width, _squareHeight)];
    _maxminTempView.minTemperature = 20.f;
    _maxminTempView.maxTemperature = 23.f;
    [_maxminTempView drawMinAndMax];
    [_upperView addSubview:_maxminTempView];
    
    _sunview = [[SuntimeView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weatherview.frame), CGRectGetMaxY(_tempview.frame), 0.5 * self.view.frame.size.width, _squareHeight)];
    [_sunview buildSunView];
    [_upperView addSubview:_sunview];
    
    // 绘制分割线
    [self drawSeparateLine];
    // 加载动画
    [self prepareLoading];
    
    // 下拉按钮
    _downDragBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cityView.frame), 60, 50)];
    _downDragBtn.center = CGPointMake(self.view.center.x, _downDragBtn.center.y);
    [_downDragBtn setBackgroundColor:[UIColor whiteColor]];
    [_downDragBtn setImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
    [_downDragBtn addTarget:self action:@selector(downClick) forControlEvents:UIControlEventTouchUpInside];
    _downDragBtn.layer.borderColor = [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1].CGColor;
    _downDragBtn.layer.borderWidth = 0.5f;
    _downDragBtn.hidden = YES;
    [self.view addSubview:_downDragBtn];
    
    _downListView = [[DownPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cityView.frame), self.view.frame.size.width, 0)];
    [_downListView showList];
    _downListView.cityPKView.delegate = self;
    _downListView.cityPKView.dataSource = self;
    [self.view addSubview:_downListView];
//    [self locationRequest];
    
    _saveCityTagView = [[SaveCityTagView alloc] initWithFrame:CGRectMake(ScreenWidth, ScreenHeight, ScreenWidth, 0)];
    [self.view addSubview:_saveCityTagView];
    WeakSelf(weakSelf);
    weakSelf.saveCityTagView.city_chooseBlock = ^(CityInfoModel * _Nonnull model) {
        weakSelf.currentModel = model;
        [weakSelf weatherHistoryClick:nil];
        [weakSelf locallizeWithModel:model];
    };
    
    _history_edit_Btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 40, ScreenHeight - botInset - 40, 40, 40)];
    [_history_edit_Btn setImage:[UIImage imageNamed:@"List"] forState:UIControlStateNormal];
    [_history_edit_Btn addTarget:self action:@selector(weatherHistoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_history_edit_Btn];
    
    
}

// 分割线
- (void)drawSeparateLine {
    UILabel *topline = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
    topline.backgroundColor = [UIColor blackColor];
    topline.alpha = 0.2;
    [_upperView addSubview:topline];
    
    UILabel *grayline = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weatherview.frame), 0, 0.5, 3 * _squareHeight)];
    grayline.backgroundColor = [UIColor blackColor];
    grayline.alpha = 0.2;
    [_upperView addSubview:grayline];
    
    UILabel *secgrayline = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_weatherview.frame), self.view.frame.size.width, 0.5)];
    secgrayline.backgroundColor = [UIColor blackColor];
    secgrayline.alpha = 0.2;
    [_upperView addSubview:secgrayline];
    
    UILabel *thirdgrayline = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tempview.frame), self.view.frame.size.width, 0.5)];
    thirdgrayline.backgroundColor = [UIColor blackColor];
    thirdgrayline.alpha = 0.2;
    [_upperView addSubview:thirdgrayline];
    
    UILabel *forthgrayline = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_sunview.frame), self.view.frame.size.width, 0.5)];
    forthgrayline.backgroundColor = [UIColor blackColor];
    forthgrayline.alpha = 0.2;
//    [_upperView addSubview:forthgrayline];
}

- (void)accessNetwork {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    WeakSelf(weakSelf);
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"Unknow network");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"Unreachable");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"reachable");
                if (self.acceessNetwork) {
                    self.acceessNetwork();
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"reachable");
                if (self.acceessNetwork) {
                    self.acceessNetwork();
                }
                break;
            default:
                break;
        }
    }];
    weakSelf.acceessNetwork = ^{
        [manager stopMonitoring];
//        [self locationRequest];
    };
    
}
// 定位请求权限
- (void)locationRequest {
    self.locateManager = [CLLocationManager new];
    self.locateManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locateManager.distanceFilter = 10.f;
    self.locateManager.delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.locateManager requestWhenInUseAuthorization];
    });
    self.currentGeoCode = [[CLGeocoder alloc] init];
}

- (void)prepareLoading {
    _loadingView = [[ProcessView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:circle];
    WeakSelf(weakSelf);
    weakSelf.cityView.processBlock = ^{
        [weakSelf beginQuery];
    };
    weakSelf.cityView.locateBlock = ^{
        [weakSelf queryMyLocationWeather];
    };
    weakSelf.loadingView.finishBlock = ^{
        [weakSelf.loadingView removeFromSuperview];
    };
}

#pragma mark - 保存按钮
- (void)saveClick:(UIButton *)sender {
    // 保存model到本地
    if (_myLocation_City != nil && _myLocation_City.length > 0) {
        [SaveModelManager saveCityWithDefault:self.currentModel];
    }
    else {
        // 没有获取本地定位权限 从下标为0开始更新信息
        [SaveModelManager saveCityWeather:self.currentModel];
    }
    [self alert:@"Save Successfully" msg:@"You've save the weather of this city!"];
}

- (void)downClick {
    self.downDragBtn.selected = !self.downDragBtn.selected;
    if (self.downDragBtn.selected) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:1 animations:^{
            self.downDragBtn.transform = CGAffineTransformRotate(self.downDragBtn.transform, RotateAngle(180));
            CGRect btnRect = self.downDragBtn.frame;
            btnRect.origin.y += 200;
            self.downDragBtn.frame = btnRect;
            
            CGRect listRect = self.downListView.frame;
            listRect.size.height = 200;
            self.downListView.frame = listRect;
            self.downListView.cityPKView.frame = CGRectMake(0, 0, listRect.size.width, listRect.size.height);
        }];
    }
    else {
        self.downListView.cityPKView.frame = CGRectMake(0, 0, self.downListView.cityPKView.frame.size.width, 0);
        [UIView animateWithDuration:1 animations:^{
            self.downDragBtn.transform = CGAffineTransformRotate(self.downDragBtn.transform, RotateAngle(180));
            self.downDragBtn.frame = CGRectMake(self.downDragBtn.frame.origin.x, self.downDragBtn.frame.origin.y-200, 60, 50);
            CGRect listRect = self.downListView.frame;
            listRect.size.height = 0;
            self.downListView.frame = listRect;
            self.downDragBtn.hidden = YES;
        }];

    }

}

// 定位请求
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *ownLocation = locations.lastObject;
//    NSLog(@"locationManager经度：%f locationManager纬度%f",ownLocation.coordinate.longitude,ownLocation.coordinate.latitude);
    if (ownLocation && !self.myLocation) {
        self.myLocation = ownLocation;
        [self queryMyLocationWeather];
    }
    [_locateManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
            // 在这里执行需要权限的操作，例如启动定位服务
            //设置允许在应用在后台运行时继续获取位置更新
            self.locateManager.allowsBackgroundLocationUpdates = NO;
            //开始获取设备的当前位置信息
            [self.locateManager startUpdatingLocation];
            self.currentGeoCode = [[CLGeocoder alloc] init];
            self.saveCityTagView.location_isAllow = YES;
        } else {
            NSLog(@"Denied Location");
        }
    });
}


- (void)queryMyLocationWeather {
    [self locateMyself];
}

- (void)locateMyself {
    if (self.myLocation) {
        if (self.downDragBtn.selected) {
            [self downClick];
        }
        [self.view endEditing:YES];
        [self.view addSubview:self.loadingView];
        [self.loadingView showProcess];
        [WeatherRequest weatherNetRequest:2 params:[NSString stringWithFormat:@"%f:%f",self.myLocation.coordinate.latitude,self.myLocation.coordinate.longitude] result:^(id  _Nonnull responseObj) {
            [self.loadingView endProcess];
            if (responseObj) {
    //                NSLog(@"response:%@",responseObj);
                [self alert:@"Locate successfully!" msg:@"Weather info is updating now..."];
                self.myLocation_City = responseObj[@"name"];
                self.location_authorization = YES;
                [self updateInfo:responseObj];
            }
            else {
                [self alert:@"Locate Fail!" msg:@"Please Check your location permission setting and try again"];
            }
        }];
    }
    else {
        [self alert:@"Locate Fail!" msg:@"Please Check your location permission setting and try again"];
    }
}

// 查询请求
- (void)beginQuery {
    if (self.cityView.inputBox.text.length == 0) return;
    if (self.downDragBtn.selected) {
        [self downClick];
    }
    [self.view endEditing:YES];
    id currentDic = self.downListView.currentRowName[self.downListView.selectRow];
    if ([currentDic isKindOfClass:[NSDictionary class]] && [self.cityView.inputBox.text isEqualToString:currentDic[@"name"]]) {
        // 通过选择器搜索
//        NSLog(@"id:%d",self.downListView.cityID);
        [self.view addSubview:self.loadingView];
        [self.loadingView showProcess];
        [WeatherRequest weatherNetRequest:1 params:[NSString stringWithFormat:@"%d",self.downListView.cityID] result:^(id  _Nonnull responseObj) {
            [self.loadingView endProcess];
            if (responseObj) {
//                NSLog(@"response:%@",responseObj);
                [self alert:@"Request successfully!" msg:@"Weather info is updating now..."];
                [self updateInfo:responseObj];
            }
            else {
                [self alert:@"Request Fail!" msg:@"Weather not found. Please try again"];
            }
        }];
    }
    else {
        // 手动输入地名
        NSString *placeName = _cityView.inputBox.text;
        if ([placeName containsString:@" "]) {
            [self alert:@"Bad location!" msg:@"Location cannot contain space. Please try again"];
        }
        else {
            [self.view addSubview:self.loadingView];
            [self.loadingView showProcess];
            [WeatherRequest weatherNetRequest:0 params:placeName result:^(id  _Nonnull responseObj) {
                [self.loadingView endProcess];
                if (responseObj) {
//                    NSLog(@"result:%@",responseObj);
                    [self alert:@"Request successfully!" msg:@"Weather info is updating now..."];
                    [self updateInfo:responseObj];
                }
                else {
                    [self alert:@"Request Fail!" msg:@"Weather not found. Please try again"];
                }
            }];
        }
    }
}

#pragma mark - 更新对应信息
- (void)updateInfo:(id)response {
    if (![response isKindOfClass:[NSDictionary class]]) {
        return;
    }
    id weather = response[@"weather"];
    NSString *iconName = weather[0][@"icon"];
    id sys = response[@"sys"];
    id main = response[@"main"];
    id wind = response[@"wind"];
    if (_myLocation_City != nil && [response[@"name"] isEqualToString:self.myLocation_City]) {
        _add_save_Btn.hidden = YES;
    }
    else {
        _add_save_Btn.hidden = NO;
    }
    // 存当前天气模型
    CityInfoModel *saveModel = [CityInfoModel new];
    saveModel.city_name = response[@"name"];
    saveModel.city_id = response[@"id"];
    saveModel.weather_desc = weather[0][@"description"];
    saveModel.weather_icon_string = iconName;
    saveModel.sunrise_time_string = [sys[@"sunrise"] intValue];
    saveModel.sunset_time_string = [sys[@"sunset"] intValue];
    saveModel.weather_timezone = [response[@"timezone"] intValue];
    saveModel.current_temp = main[@"temp"];
    saveModel.max_temp = main[@"temp_max"];
    saveModel.min_temp = main[@"temp_min"];
    saveModel.weather_humidity = main[@"humidity"];
    saveModel.weather_windspeed = [wind[@"speed"] floatValue];
    self.currentModel = saveModel;
    if (_myLocation_City != nil && _myLocation_City.length > 0 && [_myLocation_City isEqualToString:saveModel.city_name]) {
        [SaveModelManager saveCityWithDefault:saveModel];
    }
    [self locallizeWithModel:saveModel];
    
}

# pragma mark - 根据模型更新本地视图
- (void)locallizeWithModel:(CityInfoModel *)model {
    _weatherTitle.text = model.city_name;
    _weatherview.weatherTypeLabel.text = model.weather_desc;
    NSString *iconName = model.weather_icon_string;
    [_weatherview updateImageview:iconName];
    _sunview.sunriseLabel.text = [_sunview transformTimeStamp:[NSString stringWithFormat:@"%d",model.sunrise_time_string] timeZone:model.weather_timezone];
    _sunview.sunsetLabel.text = [_sunview transformTimeStamp:[NSString stringWithFormat:@"%d",model.sunset_time_string] timeZone:model.weather_timezone];
    // 更新实时温度
    [_tempview resetNumberView:model.current_temp];
    // 更新最高和最低温
    [_maxminTempView updateData:@[model.max_temp,model.min_temp]];
    // 更新湿度
    [_numview updateCurrentHumidity:model.weather_humidity];
    [_windSpeedview updateWindSpeed:model.weather_windspeed];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _downDragBtn.hidden = NO;
    if (!self.downDragBtn.selected) {
        [self downClick];
    }
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    if (textField.text.length >= 3) {
        [self searchTips:textField.text];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.downListView.cityPKView.frame = CGRectMake(0, 0, self.downListView.cityPKView.frame.size.width, 0);
    [UIView animateWithDuration:1 animations:^{
        self.downDragBtn.hidden = YES;
        self.downDragBtn.frame = CGRectMake(0, CGRectGetMaxY(self.cityView.frame), 60, 50);
        self.downDragBtn.center = CGPointMake(self.view.center.x, self.downDragBtn.center.y);
        if (self.downListView.frame.size.height > 0) {
            self.downDragBtn.transform = CGAffineTransformRotate(self.downDragBtn.transform, RotateAngle(180));
            CGRect listRect = self.downListView.frame;
            listRect.size.height = 0;
            self.downListView.frame = listRect;
            self.downDragBtn.selected = !self.downDragBtn.selected;
        }
    }];
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 2;
    }
    return _downListView.currentRowName.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 150;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleName = @"";
    if (component == 0) {
        titleName = @[@"City",@"Province/Region"][row];
    }
    else {
        titleName = _downListView.currentRowName[row][@"name"];
    }
    NSMutableAttributedString *rowContent = [[NSMutableAttributedString alloc] initWithString:titleName attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    return rowContent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _downListView.currentRowName = _downListView.combineArray[row];
        [_downListView.cityPKView reloadComponent:1];
        [_downListView.cityPKView selectRow:0 inComponent:1 animated:YES];
    }
    else {
        _cityView.inputBox.text = _downListView.currentRowName[row][@"name"];
        _cityView.inputBox.textColor = [UIColor blackColor];
        _downListView.cityID = [_downListView.currentRowName[row][@"id"] intValue];
        _downListView.selectRow = (int)row;
    }
}

#pragma mark - 弹窗
-(void)alert:(NSString *)title msg:(NSString *)Message{
    UIAlertController *alertController = [UIAlertController
        alertControllerWithTitle:title message:Message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:ok];
    [[self getTopVC] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 提示查找
- (void)searchTips:(NSString *)currentName {
    __block BOOL hasFound = false;
    [_downListView.cityNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [[obj lowercaseString] containsString:[currentName lowercaseString]];
        if (result) {
            _downListView.currentRowName = _downListView.combineArray[0];
            [_downListView.cityPKView reloadComponent:1];
            [_downListView.cityPKView selectRow:0 inComponent:0 animated:YES];
            [_downListView.cityPKView selectRow:idx inComponent:1 animated:YES];
            hasFound = true;
            *stop = YES;
            return;
        }
    }];
    
    if (hasFound) return;
    [_downListView.proNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [[obj lowercaseString] containsString:[currentName lowercaseString]];
        if (result) {
            _downListView.currentRowName = _downListView.combineArray[1];
            [_downListView.cityPKView reloadComponent:1];
            [_downListView.cityPKView selectRow:1 inComponent:0 animated:YES];
            [_downListView.cityPKView selectRow:idx inComponent:1 animated:YES];
//            [_downListView.cityPKView select]
            *stop = YES;
            return;
        }
    }];
    
}

- (UIViewController *)getTopVC {
    UIViewController *EY_rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *EY_currentVC = [self getVCPath:EY_rootViewController];
    return EY_currentVC;
}


- (UIViewController *)getVCPath:(UIViewController *)topVC {
    UIViewController *thisVC;
    if ([topVC presentedViewController]) {
        topVC = [topVC presentedViewController];
    }
    thisVC = topVC;
    return thisVC;
}

# pragma mark - 展示历史搜索记录
- (void)weatherHistoryClick:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        if (self.saveCityTagView.frame.size.height == 0) {
            CGRect rect = self.saveCityTagView.frame;
            rect.size.height = ScreenHeight;
            rect.origin.y = 0;
            rect.origin.x = 0;
            self.saveCityTagView.frame = rect;
            [self.saveCityTagView setview];
        }
        else {
            self.saveCityTagView.frame = CGRectMake(ScreenWidth, ScreenHeight, ScreenWidth, 0);
        }
    }];
}

@end
