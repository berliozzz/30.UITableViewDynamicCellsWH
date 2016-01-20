//
//  Student.h
//  DinamicCellWH30
//
//  Created by Nikolay Berlioz on 17.01.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    veryBadStudents = 2,
    badStudents = 3,
    goodStudents = 4,
    veryGoodtudents = 5
}RatingStudent;


@interface Student : NSObject

@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *lastName;
@property (strong, nonatomic) UIColor   *color;
@property (assign, nonatomic) NSInteger  averageBall;

@property (assign, nonatomic) RatingStudent rating;

@end
