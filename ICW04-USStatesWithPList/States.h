//
//  States.h
//  ICW04-USStatesWithPList
//
//  Created by alive on 11/7/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface States : NSObject
@property(nonatomic,strong)NSDictionary *completeStateDictionary;
@property(nonatomic,strong)NSMutableArray *stateInfoArray;
@property(nonatomic,strong)NSArray *completeStateKeys;

-(id)initWithData;
@end
