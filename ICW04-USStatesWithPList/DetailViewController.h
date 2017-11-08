//
//  DetailViewController.h
//  ICW04-USStatesWithPList
//
//  Created by alive on 11/7/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "States.h"
@interface DetailViewController : UIViewController
@property(nonatomic,strong)NSDictionary *stateToDisplay;
@property(nonatomic,strong)NSArray *arrayOfColors;
@property(nonatomic,strong)UIFont *appFont;
@end
