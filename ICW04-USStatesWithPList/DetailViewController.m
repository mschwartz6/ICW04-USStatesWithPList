//
//  DetailViewController.m
//  ICW04-USStatesWithPList
//
//  Created by alive on 11/7/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stateNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateFlagImage;
@property (weak, nonatomic) IBOutlet UILabel *stateCapitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateMottoLabel;
@property (weak, nonatomic) IBOutlet UILabel *statePopulationLabel;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles =  NO;
    NSArray *allKeys = [[_stateToDisplay allKeys]sortedArrayUsingSelector:@selector(compare:)];
    //capital,flag, motto, name,population,year
    NSString *capital = [allKeys objectAtIndex:0];
    NSString *flagPath = [allKeys objectAtIndex:1];
    NSString *motto = [allKeys objectAtIndex:2];
    NSString *name = [allKeys objectAtIndex:3];
    NSString *population = [allKeys objectAtIndex:4];
    NSString *year = [allKeys objectAtIndex:5];
    
    //display state name one char per line
    NSString *stateName = _stateToDisplay[name];
    NSMutableArray *nameArray = [[NSMutableArray alloc]init];
    NSMutableString *brokenString = [[NSMutableString alloc]init];
    for (NSUInteger i = 0; i <stateName.length;i++)
    {
        [nameArray addObject:[NSString stringWithFormat:@"%c",[stateName characterAtIndex:i]]];
        [brokenString appendFormat:@"%@%@",[nameArray objectAtIndex:i],@"\n"];
    }
    
    _stateNameLabel.text = [NSString stringWithFormat:@"%@",brokenString];
    _stateFlagImage.image = [UIImage imageNamed:_stateToDisplay[flagPath]];
    _stateCapitalLabel.text = [NSString stringWithFormat:@"Capital:\n%@",_stateToDisplay[capital]];
    _stateYearLabel.text = [NSString stringWithFormat:@"Year Joined\nthe Union:\n%@",_stateToDisplay[year]];
    _stateMottoLabel.text = [NSString stringWithFormat:@"Motto:\n%@",_stateToDisplay[motto]];
    _statePopulationLabel.text = [NSString stringWithFormat:@"Population:\n%@",_stateToDisplay[population]];
    
    //new UIFont instance to make state name bold
    UIFont *nameLabelFont = [UIFont fontWithDescriptor: [[_appFont fontDescriptor]fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:29];
    
    _stateNameLabel.font = nameLabelFont;
    _stateCapitalLabel.font =[_appFont fontWithSize:26];
    _stateYearLabel.font = [_appFont fontWithSize:26];
    _stateMottoLabel.font = [_appFont fontWithSize:26];
    _statePopulationLabel.font = [_appFont fontWithSize:26];
    
    int rando = arc4random()%3;
    self.view.backgroundColor = [_arrayOfColors objectAtIndex:rando];
    ++rando;
    if (rando ==3) rando = 0;
    _stateNameLabel.backgroundColor = [_arrayOfColors objectAtIndex:rando];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
