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
@property (nonatomic, assign) CATransform3D LoginTransform2;
@property (nonatomic, assign) CATransform3D SignTransform0;
@property (nonatomic, assign) CATransform3D SignTransform2;

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
    _signView.layer.transform = _SignTransform0;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _flag = (_flag + 1 )% 4;
    switch (_flag) {
        case 0:
            [self animationLoginTransform:_LoginTransform0 SignTransForm:_SignTransform0];
            break;
        case 1:
        case 3:
            [self animationLoginTransform:CATransform3DIdentity SignTransForm:CATransform3DIdentity];
            break;
        case 2:
            [self animationLoginTransform:_LoginTransform2 SignTransForm:_SignTransform2];
            break;
            
        default:
            break;
    }
    NSLog(@"%zd",_flag);
    
////        CGPoint point = [[touches anyObject] locationInView:self.view];
//    [UIView animateWithDuration:1.5 animations:^{
////        _loginView.layer.position = point;
//        _loginView.layer.transform = transform1;
//        _signView.layer.transform = transform2;
//    }];
}

- (void)animationLoginTransform:(CATransform3D)tf1 SignTransForm:(CATransform3D)tf2{
    [UIView animateWithDuration:1 animations:^{
        _loginView.layer.transform = tf1;
        _signView.layer.transform = tf2;
    }];
}

- (void)dataSet{
    _LoginTransform0 = CATransform3DMakeTranslation(viewWidth / 3.0, 0, zTransform);
    _LoginTransform2 = CATransform3DMakeTranslation(viewWidth / 6.0, 0, -zTransform);
    
    _SignTransform0 = CATransform3DMakeTranslation(-viewWidth / 6.0, 0, -zTransform);
    _SignTransform2 = CATransform3DMakeTranslation(-viewWidth / 3.0, 0, zTransform);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
