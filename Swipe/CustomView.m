//
//  CustomView.m
//  Swipe
//
//  Created by Test on 14/02/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "CustomView.h"

#define ACTION_MARGIN 120
#define SCALE_STRENGTH 4
#define SCALE_MAX .93
#define ROTATION_MAX 1
#define ROTATION_STRENGTH 320
#define ROTATION_ANGLE M_PI/8



@interface CustomView()
@property(nonatomic, assign) CGFloat xDFromCenter;
@property(nonatomic, assign) CGFloat yDFromCenter;
@end


@implementation CustomView

#pragma mark - Initialization
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureAppearence];

        _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(cardDraggingStarted:)];
        [self addGestureRecognizer:_panGestureRecognizer];

        
    }
    return self;
}
-(void)configureAppearence{
    self.layer.cornerRadius = 8;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    [self setAnchorPoint:CGPointMake(0.5, 0.5) forView:self];
}


#pragma mark - Card Swiping Methods
-(void)cardDraggingStarted:(UIPanGestureRecognizer *)pan{
    _xDFromCenter = [pan translationInView:self].x;
    _yDFromCenter = [pan translationInView:self].y;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            _originalPoint = self.center;
        }
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat rotation = MIN(_xDFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            CGFloat angle = (CGFloat) (ROTATION_ANGLE * rotation);
            CGFloat scale = MAX(1 - fabsf(rotation) / SCALE_STRENGTH, SCALE_MAX);
            self.center = CGPointMake(_originalPoint.x + _xDFromCenter, _originalPoint.y + _yDFromCenter);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
            CGAffineTransform scaleT = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleT;
            
        }
            break;
        case UIGestureRecognizerStateEnded:{
             [self cardSwipeDone];
        }
            break;
            
        default:
            break;
    }
}


-(void)cardSwipeDone{
    if (_xDFromCenter > ACTION_MARGIN) {
        [self likeDetected];
    } else if (_xDFromCenter < -ACTION_MARGIN) {
        [self dislikeDetected];
    } else {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                         }];
    }
    
}
#pragma mark - Like Dislike Detection
-(void)dislikeDetected
{
    CGPoint finishPoint = CGPointMake(-500, 2*_yDFromCenter +_originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [_delegate cardSwipedLeft:self];
}
-(void)likeDetected
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [_delegate cardSwipedRight:self];
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


- (void)dealloc
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

@end
