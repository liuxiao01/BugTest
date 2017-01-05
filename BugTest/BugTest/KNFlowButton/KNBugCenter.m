//
//  KNBugCenter.m
//  BugTest
//
//  Created by liu xiao on 17/1/4.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "KNBugCenter.h"
#import "KNFlowButton.h"
@interface KNBugCenter () <KNFlowButtonDelegate>
@property (nonatomic, strong) NSMutableDictionary * windowDictionary;  //用来存房window
@end

@implementation KNBugCenter

+(instancetype)shareInstance
{
    static KNBugCenter *centerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        centerInstance = [[self alloc] init];
        centerInstance.windowDictionary = [[NSMutableDictionary alloc]init];
    });
    return centerInstance;

}


-(void)showFlowView
{
    KNFlowButton * button = [[KNFlowButton alloc]initWithIdentifier:@"123456"];
    button.delegate = self;
    [button show];
}
-(UIWindow *)windowWithIdentifier:(NSString *)identifier
{
    if(self.windowDictionary
       && [identifier isKindOfClass:[NSString class]]
       && identifier.length > 0)
    {
        id  object = [self.windowDictionary objectForKey:identifier];
        if([object isKindOfClass:[UIWindow class]])
        {
            return object;
        }
    }
    return nil;
}

-(void)storeWindow:(UIWindow *)window withIdentifier:(NSString *)identifier
{
    if(window && [identifier isKindOfClass:[NSString class]]
       && identifier.length > 0)
    {
        if(!self.windowDictionary)
        {
            self.windowDictionary = [[NSMutableDictionary alloc]init];
        }
        [self.windowDictionary setObject:window forKey:identifier];
    }
}

#pragma mark KNFlowButtonDelegate

-(void)flowBtnDidClick:(KNFlowButton *)flowButton
{
    //按钮被点击
}
@end
