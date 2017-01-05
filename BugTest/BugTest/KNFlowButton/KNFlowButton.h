//
//  KNFlowButton.h
//  BugTest
//
//  Created by liu xiao on 17/1/3.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNFlowButton;
@protocol KNFlowButtonDelegate <NSObject>
-(void)flowBtnDidClick:(KNFlowButton *)flowButton;
@end

//吸附的样式
typedef NS_ENUM(NSUInteger, KNFlowAdsorptionType) {
    /** 仅可停留在左、右 */
    KNFlowAdsorptionTypeHorizontal,
    /** 可停留在上、下、左、右 */
    KNFlowAdsorptionTypeEachSide
};

@interface KNFlowButton : UIButton
@property (nonatomic, weak) id <KNFlowButtonDelegate> delegate;
@property (nonatomic, assign) KNFlowAdsorptionType * flowType;


+ (instancetype)defaultFlowButtonWithDelegate:(id<KNFlowButtonDelegate>)delegate;

-(id)initWithIdentifier:(NSString *)identifier;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<KNFlowButtonDelegate>)delegate;

///button 唯一标示
@property (nonatomic, readonly) NSString * identifier;
/**
 *  显示
 */
- (void)show;

/**
 *  移除
 */
- (void)removeFromScreen;
@end
