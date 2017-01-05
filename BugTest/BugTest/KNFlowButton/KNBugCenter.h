//
//  KNBugCenter.h
//  BugTest
//
//  Created by liu xiao on 17/1/4.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNBugCenter : NSObject
+(instancetype)shareInstance;

-(void)showFlowView;

///根据identifier 读取window
-(UIWindow *)windowWithIdentifier:(NSString *) identifier;

///保存window
-(void)storeWindow:(UIWindow *)window withIdentifier:(NSString *)identifier;
@end
