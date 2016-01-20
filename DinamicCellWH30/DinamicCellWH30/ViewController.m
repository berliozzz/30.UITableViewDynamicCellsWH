//
//  ViewController.m
//  DinamicCellWH30
//
//  Created by Nikolay Berlioz on 17.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "ColorAndName.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat redColor;
@property (assign, nonatomic) CGFloat greenColor;
@property (assign, nonatomic) CGFloat blueColor;

@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSArray *ballSection;

@property (strong, nonatomic) NSMutableArray *veryBadStudents;
@property (strong, nonatomic) NSMutableArray *badStudents;
@property (strong, nonatomic) NSMutableArray *goodStudents;
@property (strong, nonatomic) NSMutableArray *veryGoodtudents;

@property (strong, nonatomic) NSMutableArray *colorAndName;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.mainTableView.contentInset = inset;
    self.mainTableView.scrollIndicatorInsets = inset;
    
    self.ballSection = [[NSArray alloc] initWithObjects:
                        @"veryBadStudents", @"badStudents", @"goodStudents", @"veryGoodtudents", @"colorAndName", nil];
    
    self.students = [[NSMutableArray alloc] init];
    self.veryBadStudents = [[NSMutableArray alloc] init];
    self.badStudents = [[NSMutableArray alloc] init];
    self.goodStudents = [[NSMutableArray alloc] init];
    self.veryGoodtudents = [[NSMutableArray alloc] init];
    self.colorAndName = [[NSMutableArray alloc] init];
    
    for (int j = 0; j < 10; j++)
    {
        ColorAndName *object = [[ColorAndName alloc] init];
        object.name = [self randomName];
        object.color = [self randomColor];
        
        [self.colorAndName addObject:object];
    }
    
    for (int i = 0; i < 20; i++)
    {
        Student *student = [[Student alloc] init];
        
        student.name     = [self randomName];
        student.lastName = [self randomLastName];
        student.averageBall = [self randomAverageBall];
        
        if (student.averageBall == 2)
        {
            student.color = [UIColor redColor];
            student.rating = veryBadStudents;
            [self.veryBadStudents addObject:student];
        }
        else if (student.averageBall == 3)
        {
            student.color = [UIColor orangeColor];
            student.rating = badStudents;
            [self.badStudents addObject:student];
        }
        else if (student.averageBall == 4)
        {
            student.color = [UIColor colorWithRed:
                             (float) 112 / 255 green:(float)216 / 255 blue:(float)143 / 255 alpha:1];
            student.rating = goodStudents;
            [self.goodStudents addObject:student];
        }
        else if (student.averageBall == 5)
        {
            student.color = [UIColor colorWithRed:
                             (float) 32 / 255 green:(float)134 / 255 blue:(float)28 / 255 alpha:1];
            student.rating = veryGoodtudents;
            [self.veryGoodtudents addObject:student];
        }
        
        [self.students addObject:student];
    }
    
    [self sortWithArray:self.veryBadStudents];
    [self sortWithArray:self.badStudents];
    [self sortWithArray:self.goodStudents];
    [self sortWithArray:self.veryGoodtudents];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (NSMutableArray*) studentsForRating:(NSString*)rating
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if ([rating isEqualToString:@"veryBadStudents"])
    {
        array = self.veryBadStudents;
    }
    else if ([rating isEqualToString:@"badStudents"])
    {
        array = self.badStudents;
    }
    else if ([rating isEqualToString:@"goodStudents"])
    {
        array = self.goodStudents;
    }
    else if ([rating isEqualToString:@"veryGoodtudents"])
    {
        array = self.veryGoodtudents;
    }
    else
    {
        array = self.colorAndName;
    }
    
    return array;
}

- (void) sortWithArray:(NSMutableArray*)array
{
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
}

- (NSInteger) randomAverageBall
{
    return (arc4random() % 4) + 2;
}

- (NSString*) randomLastName
{
    NSString *lastName;
    
    int i = arc4random() % 5;
    
    switch (i)
    {
        case 0:
            lastName = @"Avakumov";
            break;
        case 1:
            lastName = @"Bogdanov";
            break;
        case 2:
            lastName = @"Petrov";
            break;
        case 3:
            lastName = @"Letov";
            break;
        case 4:
            lastName = @"Zvyagin";
            break;
            
        default:
            break;
    }
    
    return lastName;
}

- (NSString*) randomName
{
    NSString *name;
    
    int i = arc4random() % 5;
    
    switch (i)
    {
        case 0:
            name = @"Avreliy";
            break;
        case 1:
            name = @"Boris";
            break;
        case 2:
            name = @"Evgeniy";
            break;
        case 3:
            name = @"Nikolay";
            break;
        case 4:
            name = @"Zolton";
            break;
            
        default:
            break;
    }
    
    return name;
}

- (UIColor*) randomColor
{
    self.redColor = (float)(arc4random() % 256) / 255;
    self.greenColor = (float)(arc4random() % 256) / 255;
    self.blueColor = (float)(arc4random() % 256) / 255;
    
    return [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:1.f];
}

#pragma mark - UITableViewDataSource

/*
 возвращает количество секций
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    
    return  [self.ballSection count];
}

/*
 возвращает количество ячеек в секции
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection %ld", (long)section);
    
    NSString *sectionName = [self.ballSection objectAtIndex:section];
    
    return [[self studentsForRating:sectionName] count];
}

/*
 возвращает title секции в виде строки
*/
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.ballSection objectAtIndex:section];
}

/*
 возвращает ячейку с содержимым
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath: {%ld, %ld}", (long)indexPath.section, (long)indexPath.row);
    
    if (indexPath.section == 4)
    {
        static NSString *identifier = @"ColorAndName";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            NSLog(@"cell created");
        }
        else
        {
            NSLog(@"cell reused");
        }
        NSString *sectionName = [self.ballSection objectAtIndex:indexPath.section];
        NSMutableArray *studentsArray = [self studentsForRating:sectionName];
        
        cell.textLabel.text = [NSString stringWithFormat:@"RGB:{%.0f, %.0f, %.0f}",
                               self.redColor * 255, self.greenColor * 255, self.blueColor * 255];
        cell.backgroundColor = [[studentsArray objectAtIndex:indexPath.row] color];
        
        return cell;
    }
    else
    {
        static NSString *identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            NSLog(@"cell created");
        }
        else
        {
            NSLog(@"cell reused");
        }
        
        NSString *sectionName = [self.ballSection objectAtIndex:indexPath.section];
        NSMutableArray *studentsArray = [self studentsForRating:sectionName];
        
        cell.textLabel.textColor = [[studentsArray objectAtIndex:indexPath.row] color];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",
                               [[studentsArray objectAtIndex:indexPath.row] name],
                               [[studentsArray objectAtIndex:indexPath.row] lastName]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",
                                     (long)[[studentsArray objectAtIndex:indexPath.row] averageBall]];
        
        return cell;
    }
}

@end
