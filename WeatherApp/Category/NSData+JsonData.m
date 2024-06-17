//
//  NSData+JsonData.m
//  WeatherApp
//
//  Created by Andres on 2024/4/25.
//

#import "NSData+JsonData.h"

@implementation NSData (JsonData)

- (id)jsonToArray {
    if (self) {
        return [NSJSONSerialization JSONObjectWithData:self
                                               options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                 error:nil];
    } 
    else {
        return nil;
    }
}

@end
