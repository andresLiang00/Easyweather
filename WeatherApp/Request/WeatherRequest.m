//
//  WeatherRequest.m
//  WeatherApp
//
//  Created by Andres on 2024/4/23.
//

//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
//https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
//1831a8e4e3c3800c8ee3c1cbe68b99cf
//api.openweathermap.org/data/2.5/forecast/daily?q={city name}&cnt={cnt}&appid={API key}
//You can search weather forecast for 5 days with data every 3 hours
//api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}
//https://api.openweathermap.org/data/2.5/weather?id={city id}&appid={API key}

#define apiUrlformat @"https://api.openweathermap.org/data/2.5/weather?q=%@&appid=1831a8e4e3c3800c8ee3c1cbe68b99cf"
#define apiUrlIDformat @"https://api.openweathermap.org/data/2.5/weather?id=%d&appid=1831a8e4e3c3800c8ee3c1cbe68b99cf"
#define apiUrlCoordinateformat @"https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=1831a8e4e3c3800c8ee3c1cbe68b99cf"
#import "WeatherRequest.h"

@implementation WeatherRequest

+ (void)weatherNetRequest:(int)queryType params:(NSString *)params result:(void (^)(id responseObj))responseBlock {
    NSMutableURLRequest *request;
    if (queryType == 0) {
        // 0为地名搜索
        if (params.length == 0) {
            responseBlock(nil);
            return;
        }
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:apiUrlformat,params]]];
    }
    else if (queryType == 1){
        if (params.length == 0 || [params intValue] <= 0) {
            responseBlock(nil);
            return;
        }
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:apiUrlIDformat,[params intValue]]]];
    }
    else if (queryType == 2) {
        if (params.length == 0) {
            responseBlock(nil);
            return;
        }
        NSArray *coor = [params componentsSeparatedByString:@":"];
        NSString *lat = [NSString stringWithFormat:@"%.2f",[coor[0] doubleValue]];
        NSString *lon = [NSString stringWithFormat:@"%.2f",[coor[1] doubleValue]];
        NSLog(@"%@",[NSURL URLWithString:[NSString stringWithFormat:apiUrlCoordinateformat,lat,lon]]);
        if (coor.count == 2) {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:apiUrlCoordinateformat,lat,lon]]];
        }
    }
    [request setTimeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    __block NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                 NSLog(@"NSURLSessionDataTask error : %@",error);
                responseBlock(nil);
            }
            else {
                NSError *serializationError = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
//                NSLog(@"response:%@",responseObject);
                if (!responseObject) {
                    responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                
                if (!responseObject && serializationError) {
                    NSLog(@"SerializationError : %@", serializationError.localizedDescription);
                    responseBlock(nil);
                    return;
                }
                
                if ([responseObject[@"cod"] intValue] == 200) {
                    // 200才是成功返回码
                    responseBlock(responseObject);
                    return;
                }
                responseBlock(nil);
            }
        });
    }];
            
    [task resume];
}
@end
