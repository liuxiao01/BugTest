//
//  ViewController.m
//  BugTest
//
//  Created by liu xiao on 17/1/3.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "ViewController.h"
#import "KNFlowButton.h"
#import "ViewController1.h"
@interface ViewController ()
{
    UIWindow * window;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    UIButton  *button  = [UIButton  buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 60, 60);
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)aaa
{
    window = [[UIWindow alloc]init];
    ViewController1 * vc = [[ViewController1 alloc]init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
