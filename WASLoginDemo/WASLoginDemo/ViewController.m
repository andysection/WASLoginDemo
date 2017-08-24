//
//  ViewController.m
//  WASLoginDemo
//
//  Created by 王璋杰 on 2017/8/22.
//  Copyright © 2017年 sec. All rights reserved.
//

#import "ViewController.h"
#import "WASLoginView.h"
#import "WASSignView.h"
static float viewWidth = 150.0f;
static float zTransform = 50.0f;
typedef enum : NSUInteger {
    ViewFrontTypeLogin = 0,
    ViewFrontTypeSign,
} ViewFrontType;

@interface ViewController ()

@property (nonatomic, weak) WASLoginView *loginView;
@property (nonatomic, weak) WASSignView *signView;
@property (nonatomic, assign) ViewFrontType viewFrontType;

//动画属性 只可读
@property (nonatomic, assign, readonly) CATransform3D LoginTransformForward;
@property (nonatomic, assign, readonly) CATransform3D LoginTransformBackward;
@property (nonatomic, assign, readonly) CATransform3D SignTransformBackward;
@property (nonatomic, assign, readonly) CATransform3D SignTransformForward;
@property (nonatomic, strong, readonly) CAKeyframeAnimation * animKeyframeLoginForward;
@property (nonatomic, strong, readonly) CAKeyframeAnimation * animKeyframeLoginBackward;
@property (nonatomic, strong, readonly) CAKeyframeAnimation * animKeyframeSignForward;
@property (nonatomic, strong, readonly) CAKeyframeAnimation * animKeyframeSignBackward;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    _viewFrontType = ViewFrontTypeLogin;
    _loginView.layer.transform = self.LoginTransformForward;
    _signView.layer.transform = self.SignTransformBackward;
    
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:59.0/255 green:69.0/255 blue:100.0/255 alpha:1.0];
    
    WASLoginView *loginView = [[WASLoginView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - viewWidth , 200, viewWidth, 200)];
    [self.view addSubview:loginView];
    _loginView = loginView;
    
    WASSignView *signView = [[WASSignView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 200, viewWidth, 200)];
    [self.view addSubview:signView];
    _signView = signView;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-viewWidth, 0, 1, 667)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self viewFrontTypeChanged];
    
    return;
}

- (void)setViewFrontType:(ViewFrontType)viewFrontType{
    //进行动画 显示LOGIN
    CAKeyframeAnimation *LoginAnimGroup = self.animKeyframeLoginForward;
    CATransform3D loginTransform = self.LoginTransformForward;
    CAKeyframeAnimation *SignAnimGroup = self.animKeyframeSignBackward;
    CATransform3D signTransform = self.SignTransformBackward;
    //显示SIGN
    if (viewFrontType == ViewFrontTypeSign) {
        LoginAnimGroup = self.animKeyframeLoginBackward;
        loginTransform = self.LoginTransformBackward;
        SignAnimGroup = self.animKeyframeSignForward;
        signTransform = self.SignTransformForward;
    }
    
    //添加组动画
    [self.loginView.layer addAnimation:LoginAnimGroup forKey:nil];
    [self.signView.layer addAnimation:SignAnimGroup forKey:nil];
    //设置tranform正确属性
    self.loginView.layer.transform = loginTransform;
    self.signView.layer.transform = signTransform;
    
    _viewFrontType = viewFrontType;
}
//更换菜单界面
- (void)viewFrontTypeChanged{
    self.viewFrontType = !_viewFrontType;
    NSLog(@"%zd", _viewFrontType);
}

//减少重复代码
- (CAKeyframeAnimation *)getKeyFrameAnimationWithTargetTransform:(CATransform3D)tf fromTransform:(CATransform3D)ftf{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSValue *t1 = [NSValue valueWithCATransform3D:ftf];
    NSValue *t2 = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    NSValue *t3 = [NSValue valueWithCATransform3D:tf];
    
    anim.values = @[t1, t2, t3];
    
    anim.duration = 8.0f;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    return anim;
}

# pragma mark - readonly Property Transform3D
- (CATransform3D)LoginTransformForward{
    return CATransform3DMakeTranslation(viewWidth / 3, 0, zTransform);
}

-(CATransform3D)LoginTransformBackward{
    return CATransform3DMakeTranslation(viewWidth / 3, 0, -zTransform);
}

-(CATransform3D)SignTransformBackward{
    return CATransform3DMakeTranslation(-viewWidth / 3, 0, -zTransform);
}

- (CATransform3D)SignTransformForward{
    return CATransform3DMakeTranslation(-viewWidth / 3, 0, zTransform);
}
# pragma mark - readonly Property KeyframeAnimation
- (CAKeyframeAnimation *)animKeyframeLoginBackward{
    return [self getKeyFrameAnimationWithTargetTransform:self.LoginTransformBackward fromTransform:self.LoginTransformForward];
}

- (CAKeyframeAnimation *)animKeyframeLoginForward{
    return [self getKeyFrameAnimationWithTargetTransform:self.LoginTransformForward fromTransform:self.LoginTransformBackward];
}

- (CAKeyframeAnimation *)animKeyframeSignForward{
    return [self getKeyFrameAnimationWithTargetTransform:self.SignTransformForward fromTransform:self.SignTransformBackward];
}

- (CAKeyframeAnimation *)animKeyframeSignBackward{
    return [self getKeyFrameAnimationWithTargetTransform:self.SignTransformBackward fromTransform:self.SignTransformForward];
}

@end
