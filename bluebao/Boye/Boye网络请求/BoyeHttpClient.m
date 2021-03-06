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
//@property (nonatomic,weak) NSString* BASE_API_URL;

@end

//static NSString * const BASE_API_URL = @"http://192.168.0.100/github/201507lanbao/api.php/";
static NSString * const BASE_API_URL = @"http://lanbao.itboye.com/api.php/";



@implementation BoyeHttpClient

+(NSString *)getBaseApiURL{
    return BASE_API_URL;
}
//
//- (void)initWithBaseURL:(NSString*) baseURL{
//    self.BASE_API_URL = baseURL;
//}


+ (void)stopMonitorNetwork{
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
}
+ (void)startMonitorNetwork{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DLog(@"Network status= %ld",(long)status);
        
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

- (void)post:(NSString *)url :(NSDictionary *)withParams :(void (^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    AFHTTPSessionManager *mg = [AFHTTPSessionManager manager];
    mg = [mg initWithBaseURL:[NSURL URLWithString:BASE_API_URL]];
    NSURL * api_url = [NSURL URLWithString:url relativeToURL:[mg baseURL]];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

//    NSString *base_url = [[NSString alloc] initWithString:BASE_API_URL];
//    url = [base_url stringByAppendingString:url];
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //获得完整URL
    url = [self getFullURLString:url];
    
    [manager POST:[api_url absoluteString] parameters:withParams  success:success failure:failure];
    
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
//        DLog(@"File downloaded to: %@", filePath);

    
//    }];
//    
//    [downloadTask resume];
}
-(void)upload:(NSString*)url withParams:(NSDictionary *)withParams :(NSString *)filePath :(void (^)(AFHTTPRequestOperation *operation ,id responseObject))success :(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [  manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
   
    url = [self getFullURLString:url];
    
    UIImage  *image = [UIImage imageWithContentsOfFile:filePath];
    if(image == nil){
        NSError * error = [[NSError alloc]initWithDomain:@"图片无法读取!" code:10001 userInfo:nil];
        failure(nil, error);
        return;
    }
    
    NSData * data = UIImageJPEGRepresentation(image, 0.5);    //@"file://path/to/image.png"    //@"file://path/to/image.png"
    
//    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    [manager
     POST:url
     parameters:withParams
     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//         [formData appendPartWithFileURL:fileUrl name:@"image" error:nil];
         [formData appendPartWithFileData:data name:@"image" fileName:@"xxx.jpg" mimeType:@""];
//         [formData appendpartwithf];
         
     } success:success failure:failure];
    
}

#pragma  mark- 获得完整的ULR --
-(NSString *)getFullURLString:(NSString *)urlstr{

    
    NSString *base_url = [[NSString alloc] initWithString:BASE_API_URL];
    NSString *  url = [base_url stringByAppendingString:urlstr];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return url;
}

@end
