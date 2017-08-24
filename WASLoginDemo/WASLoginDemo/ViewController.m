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

@interface ViewController ()

@property (nonatomic, weak) WASLoginView *loginView;
@property (nonatomic, weak) WASSignView *signView;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) CATransform3D LoginTransform0;
@property (nonatomic, assign) CATransform3D LoginTransformBack;
@property (nonatomic, assign) CATransform3D SignTransform0;
@property (nonatomic, assign) CATransform3D SignTransform2;

//动画属性 只可读
@property (nonatomic, strong) CAAnimationGroup * animGLoginForward;
@property (nonatomic, strong) CAAnimationGroup * animGLoginBackward;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataSet];
    _flag = 0;
    
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
    
    _loginView.layer.transform = _LoginTransform0;
    _signView.layer.transform = CATransform3DIdentity;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *LoginAnimForForward2Mid = [CABasicAnimation animationWithKeyPath:@"transform"];
    LoginAnimForForward2Mid.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CABasicAnimation *LoginAnimForMid2Back = [CABasicAnimation animationWithKeyPath:@"transform"];
    LoginAnimForMid2Back.toValue = [NSValue valueWithCATransform3D:_LoginTransformBack];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[LoginAnimForForward2Mid, LoginAnimForMid2Back];
    animGroup.duration = 1.0f;
    animGroup.fillMode = kCAFillModeForwards;
    
    [_loginView.layer addAnimation:animGroup forKey:nil];
    _loginView.layer.transform = _LoginTransformBack;
    
    return;
}

- (void)animationLoginTransform:(CATransform3D)tf1 SignTransForm:(CATransform3D)tf2{
    [UIView animateWithDuration:1 animations:^{
        _loginView.layer.transform = tf1;
        _signView.layer.transform = tf2;
    }];
}
//减少重复代码
- (CAAnimationGroup *)getAnimationGroupWithTransform1:(CATransform3D)tf1 Transform2:(CATransform3D)tf2{
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim1.toValue = [NSValue valueWithCATransform3D:tf1];
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim2.toValue = [NSValue valueWithCATransform3D:tf2];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration = 1.0f;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.removedOnCompletion = YES;
    animGroup.animations = @[anim1, anim2];
    return animGroup;
}

- (void)dataSet{
    _LoginTransform0 = CATransform3DMakeTranslation(viewWidth / 3.0, 0, zTransform);
    _LoginTransformBack = CATransform3DMakeTranslation(viewWidth / 6.0, 0, -zTransform);
//    _LoginTransform2 = CATransform3DTranslate(CATransform3DIdentity, viewWidth / 6.0, 0, -zTransform);
    
    _SignTransform0 = CATransform3DMakeTranslation(-viewWidth / 6.0, 0, -zTransform);
    _SignTransform2 = CATransform3DMakeTranslation(-viewWidth / 3.0, 0, zTransform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
