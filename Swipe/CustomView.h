//
//  CustomView.h
//  Swipe
//
//  Created by Test on 14/02/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSwipeDelegate <NSObject>
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;
@end

@interface CustomView : UIView

@property (nonatomic, weak) id <CustomSwipeDelegate> delegate;
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign)CGPoint originalPoint;



@end
