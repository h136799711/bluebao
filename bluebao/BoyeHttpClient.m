//
//  HttpClient.m
//  AFNTest
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "BoyeHttpClient.h"
#import "AFNetworking.h"

@interface BoyeHttpClient()

//API基地址，末尾不带/
@property (nonatomic,weak) NSString* BASE_API_URL;

@end


@implementation BoyeHttpClient

- (void)initWithBaseURL:(NSString*) baseURL{
    self.BASE_API_URL = baseURL;
}


+ (void)stopMonitorNetwork{
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
}
+ (void)startMonitorNetwork{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"Network status= %ld",(long)status);
        
        UIAlertView *uiAlertView =[[UIAlertView alloc] initWithTitle:@"应用消息"
                                                             message:@"网络状态改变了"
                                                            delegate:nil
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定",
                                   nil];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [uiAlertView setMessage:@"不能访问网络!"];
                [uiAlertView show];
            default:
                break;
        }
        
        
    }];

}

- (BOOL)getNetworkStatus{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (void)post:(NSString *)url :(NSDictionary *)withParams :(void (^)(id responseObject))success :(void(^)(NSError *error))failure{
    
    if([self getNetworkStatus] == FALSE){
        return ;
    }
    
    AFHTTPSessionManager *mg = [AFHTTPSessionManager manager];
    mg = [mg initWithBaseURL:[NSURL URLWithString:self.BASE_API_URL]];
    
    NSURL * api_url = [NSURL URLWithString:url relativeToURL:[mg baseURL]];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *base_url = [[NSString alloc] initWithString:self.BASE_API_URL];
    
    url = [base_url stringByAppendingString:url];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:[api_url absoluteString] parameters:withParams  success:^(AFHTTPRequestOperation *operation,id responseObject){
        if(success){
            [success responseObject];
        }
    }failure:^(AFHTTPRequestOperation *operation ,NSError *error){
        if(failure){
            [failure error];
        }
    }];
    
    
}

- (void)get:(NSString *)urlWithParams :(void (^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    //TODO: 未实现
    
}

- (void)downloadTask:(NSString *)url{
    //TODO: 未实现
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:url];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//        
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        
//        NSLog(@"File downloaded to: %@", filePath);
//        
//    }];
//    
//    [downloadTask resume];
}

@end
