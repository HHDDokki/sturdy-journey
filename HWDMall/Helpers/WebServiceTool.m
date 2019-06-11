//
//  WebServiceTool.m
//  HWDMall
//
//  Created by stewedr on 2018/10/31.
//  Copyright © 2018 stewardR. All rights reserved.
//

#import "WebServiceTool.h"

#import "LoginViewController.h"

#define kVersion @"version"
#define kTerminal @"platform"
#define kToken @"token"

#define kVersionValue @"1.2.0"
#define kTerminalValue @"1"

@implementation WebServiceTool
static id _instance = nil;
+ (instancetype)shareHelper {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 未知网络
                    RDLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    RDLog(@"无法联网");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // 手机自带网络
                    RDLog(@"当前使用的是2G/3G/4G网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    // WIFI
                    RDLog(@"当前在WIFI网络下");
                }
            }
        }];
    });
    return _instance;
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/html",nil];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].token);
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].token forHTTPHeaderField:kToken];
    [manager.requestSerializer setValue:kTerminalValue forHTTPHeaderField:kTerminal];
    [manager.requestSerializer setValue:kVersionValue forHTTPHeaderField:kVersion];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 30;
    URLString =  [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"url----%@, body----%@, header----%@", URLString,parameters,manager.requestSerializer.HTTPRequestHeaders);
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (![GVUserDefaults standardUserDefaults].token.length) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSDictionary *allHeaders = response.allHeaderFields;
                NSString *token = allHeaders[@"token"];
                [GVUserDefaults standardUserDefaults].token = token;
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        RDLog(@"%ld",(long)response.statusCode);
        if (response.statusCode == 403) {
            // 未登录 跳转登录
            [MBProgressHUD hideHUD];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            [[ToolsManage getCurrentVC] presentViewController:nav animated:YES completion:nil];
        }else{
            if (failure) {
                failure(error);
            }
        }
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/html",@"text/plain",nil];
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].token);
    if (!kObjectIsEmpty([GVUserDefaults standardUserDefaults].token)) {
        [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].token forHTTPHeaderField:kToken];
    }
    NSLog(@"%@",manager.requestSerializer);
    [manager.requestSerializer setValue:kTerminalValue forHTTPHeaderField:kTerminal];
    [manager.requestSerializer setValue:kVersionValue forHTTPHeaderField:kVersion];
    manager.requestSerializer.timeoutInterval = 30;
    URLString =  [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"url----%@, body----%@, header----%@", URLString,parameters,manager.requestSerializer.HTTPRequestHeaders);
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (![GVUserDefaults standardUserDefaults].token.length || [URLString isEqualToString:NSStringFormat(@"%@%@",kApiPrefix,kApi_appLogin)] || [URLString isEqualToString:NSStringFormat(@"%@%@",kApiPrefix,kApi_mobileLogin)]) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSDictionary *allHeaders = response.allHeaderFields;
                NSString *token = allHeaders[@"token"];
                if (!kStringIsEmpty(token)) {
                    [GVUserDefaults standardUserDefaults].token = token;
                    NSLog(@"%@",token);
                }
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        RDLog(@"%ld",(long)response.statusCode);
        [MBProgressHUD hideHUD];
        [[ToolsManage getCurrentVC].view hideToastActivity];
        [kWindow hideToastActivity];
        if (response.statusCode == 403) {
            // 未登录 跳转登录
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            [[ToolsManage getCurrentVC] presentViewController:nav animated:YES completion:nil];
        }else{
            if (failure) {
                failure(error);
            }
        }
        
    }];
}

#pragma mark -- POST/GET网络请求 --
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/html",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].token forHTTPHeaderField:kToken];
    [manager.requestSerializer setValue:kTerminalValue forHTTPHeaderField:kTerminal];
    [manager.requestSerializer setValue:kVersionValue forHTTPHeaderField:kVersion];
    manager.requestSerializer.timeoutInterval = 30;
    URLString =  [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    if (![GVUserDefaults standardUserDefaults].token.length) {
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                        NSDictionary *allHeaders = response.allHeaderFields;
                        NSString *token = allHeaders[@"token"];
                        [GVUserDefaults standardUserDefaults].token = token;
                        RDLog(@"响应头：%@",allHeaders);
                    }
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    success(dict);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    if (![GVUserDefaults standardUserDefaults].token.length) {
                        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                        NSDictionary *allHeaders = response.allHeaderFields;
                        NSString *token = allHeaders[@"token"];
                        [GVUserDefaults standardUserDefaults].token = token;
                        RDLog(@"响应头：%@",allHeaders);
                    }
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSDictionary *allHeaders = response.allHeaderFields;
                RDLog(@"%ld",(long)response.statusCode);
                if (response.statusCode == 403) {
                    // 未登录 跳转登录
                    [MBProgressHUD hideHUD];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
                    [[ToolsManage getCurrentVC] presentViewController:nav animated:YES completion:nil];
                }else{
                    if (failure) {
                        failure(error);
                    }
                }
            }];
        }
            break;
    }
}

#pragma mark -- 检查登录状态请求 --
- (void)checkLoginWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/html",@"text/plain",nil];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].token forHTTPHeaderField:kToken];
    [manager.requestSerializer setValue:kTerminalValue forHTTPHeaderField:kTerminal];
    [manager.requestSerializer setValue:kVersionValue forHTTPHeaderField:kVersion];
    manager.requestSerializer.timeoutInterval = 30;
    URLString =  [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"url----%@, body----%@, header----%@", URLString,parameters,manager.requestSerializer.HTTPRequestHeaders);
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        RDLog(@"%ld",(long)response.statusCode);
        if (response.statusCode == 403) {
            if (failure) {
                failure(error);
            }
        }
    }];
}

@end
