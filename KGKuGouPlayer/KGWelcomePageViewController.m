//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGWelcomePageViewController.h"

#define COUNT 5
#define KStartButtonCenterYRatio 547.f/667.f
#define KPageControlCenterYRatio 610.f/667.f
@interface KGWelcomePageViewController ()

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //scrollView填充屏幕
    _welcomePageScrollView.frame = [UIScreen mainScreen].bounds;
    //让pageControl处于屏幕610.f/667.f比例的位置
    _welcomePageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5f, [UIScreen mainScreen].bounds.size.height*KPageControlCenterYRatio);
    //设置scrollView，包括显示的图片以及contentSize等
    [self setUpScrollView];
    //设置pageControl的数量
    [self setUpPageControl];
}

#pragma mark 设置scrollView，包括显示的图片以及contentSize等
- (void)setUpScrollView
{
    for (int i=0; i<COUNT; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"introduction_%d",i+1]]];
        imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //在最后一张的imageView上添加按钮
        if (i == COUNT-1)
        {
            [self addStartButton:imageView];
        }
        [_welcomePageScrollView addSubview:imageView];
    }
    _welcomePageScrollView.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _welcomePageScrollView.pagingEnabled = YES;
    //到最后一张不允许滑动
    _welcomePageScrollView.bounces = NO;
}

//设置pageControl的连动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _welcomePageControl.currentPage = (NSUInteger)(_welcomePageScrollView.contentOffset.x)/[UIScreen mainScreen].bounds.size.width;
}

#pragma mark 设置pageControl
- (void)setUpPageControl
{
    _welcomePageControl.numberOfPages=COUNT;
}

#pragma mark 设置最后一张imageView上的button
- (void)addStartButton:(UIImageView *)imageView
{
    //使imageView可以与用户进行交互
    imageView.userInteractionEnabled=YES;
    UIButton *startButton=[[UIButton alloc]init];
    startButton.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-122.f)*0.5, [UIScreen mainScreen].bounds.size.height*KStartButtonCenterYRatio, 122.f, 32.f);
    [startButton setImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startButton setImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    [startButton addTarget:self action:@selector(startKuGouClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}

#pragma mark 设置startButton的点击事件
- (void)startKuGouClicked:(UIButton *)button
{
    //切换到主页--将主页设置为window的rootViewController，这样就不会再回到欢迎页
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainPageViewController=[storyboard instantiateViewControllerWithIdentifier:@"mainPage"];
    //self.view.window.rootViewController=mainPageViewController;
    //不再AppDelegate内，需要使用单例来取window
    [UIApplication sharedApplication].keyWindow.rootViewController=mainPageViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
