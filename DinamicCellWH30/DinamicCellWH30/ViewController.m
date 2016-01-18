//
//  ViewController.m
//  DinamicCellWH30
//
//  Created by Nikolay Berlioz on 17.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat redColor;
@property (assign, nonatomic) CGFloat greenColor;
@property (assign, nonatomic) CGFloat blueColor;
@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) NSArray *ballSection;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.mainTableView.contentInset = inset;
    self.mainTableView.scrollIndicatorInsets = inset;
    
    self.ballSection = [[NSArray alloc] initWithObjects:
                        @"Bad student", @"Very bad student", @"Good student", @"Very good student", nil];
    
    self.students = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++)
    {
        Student *student = [[Student alloc] init];
        
        student.name     = [self randomName];
        student.lastName = [self randomLastName];
        student.averageBall = [self randomAverageBall];
        
        if (student.averageBall == 2)
        {
            student.color = [UIColor redColor];
        }
        else if (student.averageBall == 3)
        {
            student.color = [UIColor orangeColor];
        }
        
        [self.students addObject:student];
    }
    
    [self sort];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void) sort
{
    [self.students sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
    
    /*
     Здесь по имени секции должны отбираться объекты из массива
     возможно создать отдельный метод
     который будет возвращать кол-во объектов в секции
    */
    
    
    return [self.students count];
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
    
    cell.textLabel.textColor = [[self.students objectAtIndex:indexPath.row] color];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",
                           [[self.students objectAtIndex:indexPath.row] name],
                           [[self.students objectAtIndex:indexPath.row] lastName]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",
                                 (long)[[self.students objectAtIndex:indexPath.row] averageBall]];
    
    return cell;
}
































@end
