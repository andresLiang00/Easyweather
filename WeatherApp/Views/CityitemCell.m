//
//  CityitemCell.m
//  WeatherApp
//
//  Created by Andres on 2024/5/27.
//

#import "CityitemCell.h"
#import "LaunchVC.h"
#import "UIView+AnimationView.h"

@implementation CityitemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-40, 50)];
        self.rightView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.rightView.layer.cornerRadius = 10;
        [self.contentView addSubview:self.rightView];
        
        self.label_city_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 25)];
        self.label_city_name.textColor = [UIColor colorWithRed:204/255.0 green:197/255.0 blue:188/255.0 alpha:1];
        self.label_city_name.font = [UIFont fontWithName:@"Courier" size:20];
        [self.rightView addSubview:self.label_city_name];
        
        self.label_weather_desc = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.label_city_name.frame)+5, 200, 15)];
        self.label_weather_desc.textColor = [UIColor blackColor];
        self.label_weather_desc.font = [UIFont fontWithName:@"Courier" size:12];
        [self.rightView addSubview:self.label_weather_desc];
        
        self.label_current_temp = [[UILabel alloc] initWithFrame:CGRectMake(self.rightView.frame.size.width-110, 5, 100, 30)];
//        self.label_current_temp.text = [NSString stringWithFormat:@"%@ °C",self.current_temp];
        self.label_current_temp.textColor = [UIColor brownColor];
        self.label_current_temp.textAlignment = NSTextAlignmentRight;
        self.label_current_temp.font = [UIFont fontWithName:@"Courier" size:20];
        [self.rightView addSubview:self.label_current_temp];
        
        self.label_weather_humidity = [[UILabel alloc] initWithFrame:CGRectMake(self.rightView.frame.size.width-160, CGRectGetMaxY(self.label_current_temp.frame)+5, 150, 10)];
//        self.label_weather_humidity.text = [NSString stringWithFormat:@"%@ %%",self.weather_humidity];
        self.label_weather_humidity.textColor = [UIColor blackColor];
        self.label_weather_humidity.textAlignment = NSTextAlignmentRight;
        self.label_weather_humidity.font = [UIFont fontWithName:@"Courier" size:10];
        [self.rightView addSubview:self.label_weather_humidity];
        
        self.cell_deletebtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 20, 20)];
        [self.cell_deletebtn setTitle:@"——" forState:UIControlStateNormal];
        self.cell_deletebtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        [self.cell_deletebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cell_deletebtn.layer.cornerRadius = 10;
        [self.cell_deletebtn setBackgroundColor:[UIColor redColor]];
        [self.cell_deletebtn addTarget:self action:@selector(cell_delete:) forControlEvents:UIControlEventTouchUpInside];
        self.cell_deletebtn.hidden = YES;
        [self.contentView addSubview:self.cell_deletebtn];
    }
    return self;
}

- (void)layoutSubviews {
    
}

- (void)cell_delete:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}
@end
