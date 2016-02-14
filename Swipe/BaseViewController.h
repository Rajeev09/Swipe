//
//  ViewController.h
//  Swipe
//
//  Created by Test on 14/02/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomView.h"


@interface BaseViewController : UIViewController<CustomSwipeDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
- (IBAction)reloadAction:(id)sender;

@end

