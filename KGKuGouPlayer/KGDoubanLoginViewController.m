//
//  KGDoubanLoginViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/19.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGDoubanLoginViewController.h"
#import "KGPlayBar.h"
#import <MBProgressHUD.h>
#import <AFNetworking.h>

@interface KGDoubanLoginViewController ()

@property (copy, nonatomic) NSString *authorization_code;

@end

@implementation KGDoubanLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //豆瓣第三方授权登录页面的加载
    NSURL *loginURL = [NSURL URLWithString:@"https://www.douban.com/service/auth2/auth?client_id=0365e094d140cd8f0a31a1be73c268ad&redirect_uri=http://www.lizhi.fm&response_type=code"];
    [_loginWeb loadRequest:[NSURLRequest requestWithURL:loginURL]];
    //MBProgressHUD *mbHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //mbHUD.mode = MBProgressHUDModeText;
    //mbHUD.mode = MBProgressHUDAnimationFade;
    //mbHUD.animationType = MBProgressHUDAnimationZoomOut;
    //mbHUD.activityIndicatorColor = [UIColor lightGrayColor];
    //mbHUD.labelColor = [UIColor greenColor];
    //mbHUD.color = [UIColor cyanColor];
    //mbHUD.labelText = @"Please try later.";
    [MBProgressHUD showHUDAddedTo:self.view LabelText:@"Please try later." animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews)
    {
        if ([subView isKindOfClass:[KGPlayBar class]])
        {
            KGPlayBar *playBar = (KGPlayBar *)subView;
            playBar.hidden = YES;
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews)
    {
        if ([subView isKindOfClass:[KGPlayBar class]])
        {
            KGPlayBar *playBar = (KGPlayBar *)subView;
            playBar.hidden = NO;
        }
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    static NSInteger count = 0;
    NSLog(@"count %li,request %@",count,request.URL.absoluteString);
    //请求字符串当中是否包含?code＝
    if (_authorization_code == nil && [request.URL.absoluteString containsString:@"?code="])
    {
        NSArray *stringArray = [request.URL.absoluteString componentsSeparatedByString:@"code="];
        NSString *code = [stringArray lastObject];
        NSArray *stepArray = [code componentsSeparatedByString:@"&"];
        NSLog(@"%@",[stepArray firstObject]);
        
        _authorization_code = [stepArray firstObject];
        
        //取得了授权code后需要使用POST方式发送获取access_tocken请求
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"client_id":@"0365e094d140cd8f0a31a1be73c268ad",@"client_secret":@"9c8ca64743d9b80b",
              @"redirect_uri":@"http://www.lizhi.fm",
              @"grant_type":@"authorization_code",
              @"code":_authorization_code};
        [MBProgressHUD showHUDAddedTo:self.view LabelText:@"授权请求中..." animated:YES];
        [manager POST:@"https://www.douban.com/service/auth2/token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            //一般服务器返回的如果是JSON格式，AFNetworking会自动将JSON转变为字典responseObject返回给用户
            KGAccessToken *token = [KGAccessToken accessTokenWithDict:responseObject];
            [CurUserMngTool sharedCurUserMngTool].token = token;
            
            //把access_token存入沙盒
            [[NSUserDefaults standardUserDefaults]setObject:[CurUserMngTool sharedCurUserMngTool].token.access_token forKey:@"access_token"];
            
            NSLog(@"JSON: %@", responseObject);
            NSLog(@"access_token %@ user %@",token.access_token,token.douban_user_name);
            
            //提示应该保证足够的提示时间，一般会将它显示到window或者导航控制器的view上
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"Success!";
//            [hud hide:YES afterDelay:2.f];
            [MBProgressHUD showTipToWindow:@"Success!" afterDelay:2.f];
            //自动返回到主页
            [self.navigationController popViewControllerAnimated:YES];
            [CurUserMngTool sharedCurUserMngTool].isChangeUser = YES;
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"Error: %@", error);
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showTipToWindow:@"Error!" afterDelay:2.f];
        }];
    }
//    count++;
   
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
