//
//  AppDelegate.m
//  iOS_FanmoreIndiana
//
//  Created by 刘琛 on 16/1/11.
//  Copyright © 2016年 刘琛. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalModel.h"
#import "NSData+NSDataDeal.h"
#import "UIViewController+MonitorNetWork.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//#import <AlipaySDK/AlipaySDK.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:ShareSDKAppKey
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeiXinAppID
                                       appSecret:WeiXinAppSecret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQAppKey
                                      appKey:QQappSecret
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    
    
    [UserLoginTool loginRequestGet:@"init" parame:nil success:^(id json) {
        LWLog(@"%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {
            GlobalModel *global = [GlobalModel mj_objectWithKeyValues:json[@"resultData"][@"global"]];
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:GlobalInfo];
            [NSKeyedArchiver archiveRootObject:global toFile:fileName];
            
            if (![json[@"resultData"][@"user"] isKindOfClass:[NSNull class]]) {
                
                UserModel *user = [UserModel mj_objectWithKeyValues:json[@"resultData"][@"user"]];
                NSLog(@"userModel: %@",user);
                
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:UserInfo];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                //保存新的token
                [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
                
                AdressModel *address = [AdressModel mj_objectWithKeyValues:json[@"resultData"][@"user"][@"addressModel"]];
                NSString *fileNameAdd = [path stringByAppendingPathComponent:DefaultAddress];
                [NSKeyedArchiver archiveRootObject:address toFile:fileNameAdd];
                
                
            }else {
                [UIViewController ToRemoveSandBoxDate];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    [self registRemoteNotification:application];
    
    return YES;
}

/**
 *  注册远程通知
 */
- (void)registRemoteNotification:(UIApplication *)application{
    if (IsIos8) { //iOS 8 remoteNotification
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        
        UIRemoteNotificationType type = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeNewsstandContentAvailability;
        [application registerForRemoteNotificationTypes:type];
        
    }
}

/**
 *  ios8
 *
 *  @param application          <#application description#>
 *  @param notificationSettings <#notificationSettings description#>
 */
-(void)application:(UIApplication*)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
        [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
        LWLog(@"注册推送服务时，发生以下错误： %@",error.description);
}

/**
 *  获取deviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //    NSLog(@"%@",deviceToken);
    NSString * aa = [[deviceToken hexadecimalString] copy];
    //    NSString * urlstr = [MainUrl stringByAppendingPathComponent:@"updateDeviceToken"];
    NSMutableDictionary * parame = [NSMutableDictionary dictionary];
    parame[@"deviceToken"] = aa;
    //    NSLog(@"deviceToken===%@",aa);
    [UserLoginTool loginRequestGet:@"updateDeviceToken" parame:parame success:^(id json) {
        LWLog(@"送11111 %@", json);
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //    NSLog(@"didReceiveRemoteNotification ------ %@",userInfo);
    //    NSLog(@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    //以警告框的方式来显示推送消息
    NSDictionary * dict = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (dict != NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:dict[@"body"]
                                                        message:dict[@"title"]
                                                       delegate:self
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:@"处理",nil];
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

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
    }
    
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}





@end
