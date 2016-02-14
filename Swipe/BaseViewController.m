//
//  ViewController.m
//  Swipe
//
//  Created by Test on 14/02/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "BaseViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface BaseViewController ()

@property(nonatomic, strong) NSMutableArray *cardStack;

@property(nonatomic,strong) CustomView *frontView;

@property(nonatomic,strong) CustomView *backView;
@property(nonatomic,strong) UIView *holdingView;
@property(nonatomic,strong) UIView *shadowView;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    UIView *shadowView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    shadowView.backgroundColor = [UIColor lightGrayColor];
    shadowView.backgroundColor = [UIColor colorWithRed:(122.0/255.0) green:(137.0/255.0) blue:(138.0/255.0) alpha:1];
    
    [shadowView.layer setCornerRadius:8.0f];
    // border
    [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [shadowView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setShadowOpacity:0.8];
    [shadowView.layer setShadowRadius:3.0];
    [shadowView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.shadowView = shadowView;
    
    [self.containerView addSubview:shadowView];
    
    UIView *holdingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    holdingView.backgroundColor = [UIColor colorWithRed:(231.0/255.0) green:(238.0/255.0) blue:(237.0/255.0) alpha:1];
    
    
    [holdingView.layer setCornerRadius:8.0f];
    
    // border
    [holdingView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [holdingView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [holdingView.layer setShadowColor:[UIColor blackColor].CGColor];
    [holdingView.layer setShadowOpacity:0.8];
    [holdingView.layer setShadowRadius:3.0];
    [holdingView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.holdingView = holdingView;
    
    [self.containerView addSubview:holdingView];
    
    [self reloadAction:self.reloadButton];
    
    
    
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self setAnchorPoint:CGPointMake(0, 1) forView:_shadowView];
    _shadowView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-1));

    
    _holdingView.frame = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    [self setAnchorPoint:CGPointMake(0, 1) forView:_holdingView];
    _holdingView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-1));
    
    
    _backView.frame = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    [self setAnchorPoint:CGPointMake(0, 1) forView:_backView];
    _backView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1));

    _frontView.frame = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    
}


#pragma mark - BBDraggable Delegate Methods
-(void)cardSwipedLeft:(UIView *)card;
{
    
    if ([card isEqual:self.backView]) {
        
        [self setAnchorPoint:CGPointMake(0, 1) forView:_holdingView];
        _holdingView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
    }
    else{
        
        [self setAnchorPoint:CGPointMake(0, 1) forView:self.backView];
        _backView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
        [self setAnchorPoint:CGPointMake(0, 1) forView:_holdingView];
        _holdingView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1));
        
    }
    
}

-(void)cardSwipedRight:(UIView *)card
{
    
    if ([card isEqual:self.backView]) {
        
        [self setAnchorPoint:CGPointMake(0, 1) forView:_holdingView];
        _holdingView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
    }
    else{
        
        [self setAnchorPoint:CGPointMake(0, 1) forView:self.backView];
        _backView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
        [self setAnchorPoint:CGPointMake(0, 1) forView:_holdingView];
        _holdingView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1));
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reloadAction:(id)sender {
    

    [self setAnchorPoint:CGPointMake(0, 1) forView:_holdingView];
    _holdingView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-1));
    
    _backView = [[CustomView alloc] initWithFrame:self.containerView.bounds];
    _backView.delegate = self;
        _backView.backgroundColor = [UIColor colorWithRed:(177.0/255.0) green:(38.0/255.0) blue:(33.0/255.0) alpha:1];
    [self setAnchorPoint:CGPointMake(0, 1) forView:_backView];
    _backView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1));
    [self.containerView addSubview:_backView];
    
    _frontView = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height)];
    _frontView.delegate = self;
    _frontView.backgroundColor = [UIColor colorWithRed:(223.0/255.0) green:(54.0/255.0) blue:(47.0/255.0) alpha:1];
    [self.containerView addSubview:_frontView];
    
    

}


-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end
