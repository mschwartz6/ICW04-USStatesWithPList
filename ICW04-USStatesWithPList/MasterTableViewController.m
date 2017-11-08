//
//  MasterTableViewController.m
//  ICW04-USStatesWithPList
//
//  Created by alive on 11/7/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "MasterTableViewController.h"

@interface MasterTableViewController ()
{
    States *allStates;
    NSArray *abbreviationsArray;
    NSMutableArray *mutArray;
    NSUInteger sizeOfKeyArray;
    NSArray *arrayOfColors;
    UIFont *appFont;
}

@end

@implementation MasterTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    //Array for headers
    [self createAbbreviationsArray];
    //Create custom navigation title view
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    UIView *navTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    navTitleView.backgroundColor = [arrayOfColors objectAtIndex:3];
    UILabel *myLabel = [[UILabel alloc]init];
    [myLabel setTextColor:[UIColor blackColor]];
    [myLabel setFont:appFont];
    [myLabel setText:@"P List Table Party"];
    [navTitleView addSubview:myLabel];
    self.navigationItem.titleView = navTitleView;
    [myLabel sizeToFit];
    self.navigationController.navigationBar.barTintColor = [arrayOfColors objectAtIndex:3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    allStates = [[States alloc]initWithData];
    abbreviationsArray = [[NSArray alloc]init];
    mutArray = [[NSMutableArray alloc]init];
    sizeOfKeyArray = [allStates.completeStateKeys count];
    
    //Create custom color palette and font for the whole app
    arrayOfColors = [[NSArray alloc]initWithObjects:[UIColor colorWithRed:0.51 green:0.90 blue:0.51 alpha:1.0],[UIColor colorWithRed:0.97 green:0.73 blue:0.35 alpha:1.0],[UIColor colorWithRed:0.90 green:0.44 blue:0.79 alpha:1.0],[UIColor colorWithRed:0.97 green:0.29 blue:0.29 alpha:.1], nil];
    appFont = [UIFont fontWithName:@"Avenir Next" size:36];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source and Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [abbreviationsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger counter = 0 ;
    char temp = [[abbreviationsArray objectAtIndex:section]characterAtIndex:0];
    //Programmatically check the amount of rows in any given section
    for (NSUInteger i = 0; i < sizeOfKeyArray ;i++)
    {
        if ([[allStates.completeStateKeys objectAtIndex:i]characterAtIndex:0] == temp)
        {
            counter++;
        }
    }
    return counter;
}

-(NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return abbreviationsArray;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = abbreviationsArray[section];
    //Create custom section headers
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0.54 green:0.95 blue:1.00 alpha:1.0];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    [myLabel setTextColor:[UIColor blackColor]];
    myLabel.font = [UIFont boldSystemFontOfSize:18];
    myLabel.text = title;
    [view addSubview:myLabel];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
    
    NSInteger currentRow = [self getRow:tableView forIndexPath:indexPath];
    //Customize the content and UI for the cells
    cell.textLabel.text = [allStates.completeStateKeys objectAtIndex:currentRow];
    cell.textLabel.font = appFont;
    cell.detailTextLabel.text = @">";
    cell.detailTextLabel.font = appFont;
    if (indexPath.section % 2 == 0)
        cell.backgroundColor = [arrayOfColors objectAtIndex:0];
    else
        cell.backgroundColor = [arrayOfColors objectAtIndex:1];
    cell.layer.borderWidth = 1.6;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIView *selectedView = [[UIView alloc]initWithFrame:cell.frame];
    selectedView.backgroundColor = [arrayOfColors objectAtIndex:2];
    cell.selectedBackgroundView = selectedView;
    
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger currentRow = [self getRow:self.tableView forIndexPath:indexPath];
    DetailViewController *destination = [segue destinationViewController];
    destination.stateToDisplay = [allStates.stateInfoArray objectAtIndex:currentRow];
    destination.arrayOfColors = arrayOfColors;
    destination.appFont = appFont;
    
}
//Helper method to create an array of abbreviations for table section headers
-(void)createAbbreviationsArray
{
    char temp = ';';
    for (NSUInteger i = 0 ; i < sizeOfKeyArray; i++)
    {
        char singleLetter = [[allStates.completeStateKeys objectAtIndex:i]characterAtIndex:0];
        if (singleLetter!= temp)
        {
          temp = singleLetter;
          [mutArray addObject:[NSString stringWithFormat:@"%c",singleLetter]];
        }
    }
    abbreviationsArray = [mutArray copy];
}
//Helper method to get correct position of state dictionary in "allStates.stateInfoArray"(which is an array of dictionary objects) from selected row
//Needed because for every indexPath.section the first row of that section is equal to 0;
//However "allStates.stateInfoArray" is an array from (0 to (n-1))
-(NSInteger) getRow :(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sumRows = 0;
    for (int i = 0; i < indexPath.section; i++)
    {
        NSInteger rowsInSection = [tableView numberOfRowsInSection:i];
        sumRows += rowsInSection;
    }
    NSInteger currentRow = sumRows + indexPath.row;
    return currentRow;
}
@end
