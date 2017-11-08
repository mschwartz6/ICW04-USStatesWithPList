//
//  States.m
//  ICW04-USStatesWithPList
//
//  Created by alive on 11/7/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "States.h"

@implementation States
-(id)initWithData
{
   
    self = [super init];
    if (self)
        {
         NSString *path = [[NSBundle mainBundle] pathForResource:@"USStateInfo" ofType:@"plist"];
            _stateInfoArray = [[NSMutableArray alloc]init];
            
        _completeStateDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        _completeStateKeys = [[_completeStateDictionary allKeys]sortedArrayUsingSelector:@selector(compare:)];
        int amountOfStateKeys = (int)[_completeStateKeys count];
        for (int i = 0; i<amountOfStateKeys;i++)
            {
            NSString *stateNameKey = [_completeStateKeys objectAtIndex:i];
            [_stateInfoArray addObject:[_completeStateDictionary objectForKey: stateNameKey]];
            }
        }
    return self;
}
@end
