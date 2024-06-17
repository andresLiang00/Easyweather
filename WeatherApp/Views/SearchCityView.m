//
//  SearchCityView.m
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

#import "SearchCityView.h"

@interface SearchCityView ()

@property (nonatomic, strong) UIButton *searchIcon;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIView *searchFrame;

@end

@implementation SearchCityView

- (void)buildCityView {
    _searchFrame = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width-20, 40)];
    _searchFrame.layer.cornerRadius = 10;
    _searchFrame.layer.borderWidth = 1;
    _searchFrame.layer.borderColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
    [self addSubview:_searchFrame];
    
    _searchIcon = [[UIButton alloc] init];
    _searchIcon.frame = CGRectMake(10, 10, 20, 20);
    [_searchIcon setImage:[UIImage imageNamed:@"Location"] forState:UIControlStateNormal];
    [_searchIcon addTarget:self action:@selector(locateMyself:) forControlEvents:UIControlEventTouchUpInside];
    [_searchFrame addSubview:_searchIcon];
    
    _inputBox = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchIcon.frame) + 10, 5, _searchFrame.frame.size.width - 110, 30)];
    NSMutableAttributedString *cityHint = [[NSMutableAttributedString alloc] initWithString:@"Islamabad" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    _inputBox.attributedPlaceholder = cityHint;
    _inputBox.textColor = [UIColor blackColor];
    _inputBox.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_searchFrame addSubview:_inputBox];
    
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_inputBox.frame)+5, 5, 60, 30)];
    [_searchBtn setTitle:@"Search" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBtn.titleLabel setFont:[UIFont fontWithName:@"ArialMT" size:15]];
    [_searchBtn setBackgroundColor:[UIColor colorWithRed:204/255.0 green:197/255.0 blue:188/255.0 alpha:1]];
    _searchBtn.layer.cornerRadius = 15;
    [_searchBtn addTarget:self action:@selector(searchCity:) forControlEvents:UIControlEventTouchUpInside];
    [_searchFrame addSubview:_searchBtn];
}

- (void)searchCity:(UIButton *)sender {
    if (self.processBlock) {
        self.processBlock();
    }
}

- (void)locateMyself:(UIButton *)sender {
    if (self.locateBlock) {
        self.locateBlock();
    }
}


@end
