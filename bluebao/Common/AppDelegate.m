//
//  AppDelegate.m
//  bluebao
//
//  Created by hebidu on 15/7/9.
//  Copyright (c) 2015年 Boye. All rights reserved.
//

#import "AppDelegate.h"
#import "CacheFacade.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+(AppDelegate*)sharedInstance
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    NSString * key = @"136799711";
//    
//    NSString * content = @"1367997111中文中文中文中文中文中文中文中1";
//    NSString * encode = [BoyeCypto aes256Encrypt:content :key];
//    NSLog(@"aes = %@ length=%ld",encode,content.length);
//    NSLog(@"decode1 = %@", [BoyeCypto aes256Decrypt:encode :key]);
////    encode =  @"I85KkQnwH25yoqR0mq1jESVnKdmENjv4rLkzs8+vNag=";
////    NSLog(@"decode2 = %@", [BoyeCypto aes256Decrypt:encode :key]);
//    
////    content = @"中文hebidu126";
////     encode = [BoyeCypto aes256Encrypt:content :key];
////    
////    NSLog(@"aes = %@",encode);
////    NSLog(@"decode = %@", [BoyeCypto aes256Decrypt:encode :key]);
    
//    NSLog(@"",[[CacheFacade sharedCache]get:@""]);
    
    [NSThread sleepForTimeInterval:1];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //导航
    [self _initBarAppearance];
    //登陆
    [self _initLogin];

    //
    [self umengPushConfig:launchOptions];
    
    [self umengAnalytics];
    
    [self umengShareConfig];
    
//    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
//    
//    for (UILocalNotification *notification in localNotifications) {
//        NSLog(@"%@",notification.alertBody);
//        
////        NSDictionary *userInfo = notification.userInfo;
//        [[UIApplication sharedApplication] cancelLocalNotification:notification];
//    }
    return YES;
}

#pragma mark 友盟代码、推送＋统计＋微信分享

-(void)umengShareConfig{
    [UMSocialData setAppKey:@UMENG_APP_KEY];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx5df8e721b02d41d1" appSecret:@"2a559489a116a34453f8e1368db40d25" url:@"http://www.umeng.com/social"];
    [UMSocialData openLog:YES];
}

-(void)umengAnalytics{
    [MobClick startWithAppkey:@UMENG_APP_KEY reportPolicy:BATCH   channelId:@"APP_STORE"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

    [MobClick setEncryptEnabled:YES];
//    [MobClick checkUpdate];
//    [MobClick checkUpdate:@"发现新版本" cancelButtonTitle:@"忽略" otherButtonTitles:@"前往App Store"];
//    [MobClick setLogEnabled:YES];
}


-(void)umengPushConfig:(NSDictionary *)launchOptions{
    
    //set AppKey and AppSecret
    [UMessage startWithAppkey:@UMENG_APP_KEY launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //        register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
//    [UMessage setLogEnabled:YES];

}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    //如果是lanbaoitboye则YES
    NSString *handleUrl = [url absoluteString];
    if ([handleUrl hasPrefix:@"lanbaoitboye://"]) {
        
        return YES;
    }
    
    return  [UMSocialSnsService handleOpenURL:url];
}
#pragma mark --登陆 注册--
-(void)_initLogin{
    
    LoginVC * loginvc = [LoginVC sharedSliderController];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginvc];
    self.window.rootViewController = nav;
    
}

#pragma mark -- 导航条统一样式 --
-(void)_initBarAppearance
{
    //colorWithHexString:@"#f8f8f8"]  colorWithHexString:@"#14caff"
    UIImage *navBgImg = [UIImage imageWithColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:navBgImg forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];


    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:FONT(18)}];
    
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [UMessage registerDeviceToken:deviceToken];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"userInfo=%@",userInfo);
    [UMessage didReceiveRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    if (notification) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:notification.alertBody delegate:self cancelButtonTitle:@"我知道啦！" otherButtonTitles: nil];
        [alert show];
        
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
