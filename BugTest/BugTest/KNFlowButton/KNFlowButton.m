//
//  KNFlowButton.m
//  BugTest
//
//  Created by liu xiao on 17/1/3.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "KNFlowButton.h"
#import "KNBugCenter.h"
//显示window用
@interface KNFlowViewController : UIViewController

@end

@implementation KNFlowViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor yellowColor];
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end

@interface KNFlowButton ()
@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, weak) UIWindow * bgWindow;
@end

@implementation KNFlowButton
+ (instancetype)defaultFlowButtonWithDelegate:(id<KNFlowButtonDelegate>)delegate
{
    KNFlowButton *sus = [[KNFlowButton alloc] initWithFrame:CGRectMake(- 50.0 / 6, 100, 50, 50)
                                                              color:[UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f]
                                                           delegate:delegate];
    return sus;
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor*)color delegate:(id<KNFlowButtonDelegate>)delegate
{
    if(self = [super initWithFrame:frame])
    {
        self.delegate = delegate;
        self.userInteractionEnabled = YES;
        self.backgroundColor = color;
        [self setBackgroundColor:color];
        self.alpha = .7;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeLocation:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(id)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    if(self)
    {
        self.identifier = identifier;
        self.alpha = .7;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeLocation:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor darkGrayColor];
        self.frame = CGRectMake(- 50.0 / 6, 100, 50, 50);

        
    }
    return self;
}


#pragma mark - event response
- (void)changeLocation:(UIPanGestureRecognizer*)p
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [p locationInView:appWindow];
    
    if(p.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    }else if(p.state == UIGestureRecognizerStateChanged) {
        self.bgWindow.center = CGPointMake(panPoint.x, panPoint.y);
    }else if(p.state == UIGestureRecognizerStateEnded
             || p.state == UIGestureRecognizerStateCancelled) {
        self.alpha = .7;
        
        CGFloat touchWidth = self.frame.size.width;
        CGFloat touchHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(panPoint.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = 0;
        if (self.flowType == KNFlowAdsorptionTypeHorizontal) {
            minSpace = MIN(left, right);
        }else{
            minSpace = MIN(MIN(MIN(top, left), bottom), right);
        }
        CGPoint newCenter;
        CGFloat targetY = 0;
        
        //校正Y
        if (panPoint.y < 15 + touchHeight / 2.0) {
            targetY = 15 + touchHeight / 2.0;
        }else if (panPoint.y > (screenHeight - touchHeight / 2.0 - 15)) {
            targetY = screenHeight - touchHeight / 2.0 - 15;
        }else{
            targetY = panPoint.y;
        }
        
        if (minSpace == left) {
            newCenter = CGPointMake(touchHeight / 3, targetY);
        }else if (minSpace == right) {
            newCenter = CGPointMake(screenWidth - touchHeight / 3, targetY);
        }else if (minSpace == top) {
            newCenter = CGPointMake(panPoint.x, touchWidth / 3);
        }else if (minSpace == bottom) {
            newCenter = CGPointMake(panPoint.x, screenHeight - touchWidth / 3);
        }
        
        [UIView animateWithDuration:.25 animations:^{
            self.bgWindow.center = newCenter;
        }];
    }else{
        NSLog(@"pan state : %zd", p.state);
    }
}
- (void)click
{
    if([self.delegate respondsToSelector:@selector(flowBtnDidClick:)])
    {
        [self.delegate flowBtnDidClick:self];
    }
}

#pragma mark - public methods
- (void)show
{
    UIWindow * window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    KNFlowViewController * vc = [[KNFlowViewController alloc]init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIWindow *backWindow = [[UIWindow alloc] initWithFrame:self.frame];
    backWindow.windowLevel = UIWindowLevelAlert * 2;
    backWindow.rootViewController = [[KNFlowViewController alloc] init];
    [backWindow makeKeyAndVisible];
    backWindow.backgroundColor = [UIColor redColor];
    self.bgWindow = backWindow;
    //[ZYSuspensionManager saveWindow:backWindow forKey:self.md5Key];
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.backgroundColor = [UIColor redColor];
    //self.clipsToBounds = YES;
    [backWindow addSubview:self];
    
    // 保持原先的keyWindow，避免一些不必要的问题
    [currentKeyWindow makeKeyWindow];
}


-(void)setBgWindow:(UIWindow *)bgWindow
{
    [[KNBugCenter shareInstance]storeWindow:bgWindow withIdentifier:self.identifier];
}

-(UIWindow *)bgWindow
{
    return [[KNBugCenter shareInstance]windowWithIdentifier:self.identifier];
}

-(void)dealloc
{
    NSLog(@"button dealloc");
}
//- (void)removeFromScreen
//{
//    [ZYSuspensionManager destroyWindowForKey:self.md5Key];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
