//
//  AppDelegate.m
//  QingKu
//
//  Created by mdb-losaic on 2019/6/29.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "AppDelegate.h"

#import "MainHomeViewController.h"
#import "ChangeLanguage.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>


#import <GoogleSignIn/GoogleSignIn.h>

#import "LoginViewController.h"

#define FacebookAPPKEY @"2569099436658344"
#define FacebookAppSecret @"0750e983dfb14af7744770f32b4c4139"

#define GooGleAPPKEY @"564164296159-0lpeiinen6cfitlt6t8n60nembpmbe4b.apps.googleusercontent.com"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [FBSDKSettings setAppID:FacebookAPPKEY];
    
    [GIDSignIn sharedInstance].clientID = GooGleAPPKEY;
    
    [ChangeLanguage initUserLanguage];
    [ChangeLanguage setUserLanguage:[ChangeLanguage userLanguage]];
    
    ///111
    [self configTheme];
    
//    MainHomeViewController *mvc = [[MainHomeViewController alloc] init];
    LoginViewController *lvc = [[LoginViewController alloc] init];
    
    self.nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    [self.window setRootViewController:self.nvc];
    
    
    
    
    
    [[UITabBar appearance] setTranslucent:NO];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    return YES;
}


-(void)shareSDKResign
{
    
    
}

/// 设置主题
-(void)configTheme
{
    NSString *dayJsonPath = [[NSBundle mainBundle] pathForResource:@"themejson_day" ofType:@"json"];
    
    NSString *nightJsonPath = [[NSBundle mainBundle] pathForResource:@"themejson_night" ofType:@"json"];
    
    NSString *dayJson = [NSString stringWithContentsOfFile:dayJsonPath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *nightJson = [NSString stringWithContentsOfFile:nightJsonPath encoding:NSUTF8StringEncoding error:nil];
    
    [LEETheme defaultTheme:@"day"];
    
    [LEETheme addThemeConfigWithJson:dayJson Tag:@"day" ResourcesPath:nil];
    
    [LEETheme addThemeConfigWithJson:nightJson Tag:@"night" ResourcesPath:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    return [[GIDSignIn sharedInstance] handleURL:url];
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation];
}



@end
