//
//  ViewController.m
//  TrendViewExample
//
//  Created by Nick Wilkerson on 5/4/17.
//  Copyright © 2017 Nick Wilkerson. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSArray *dataArray1 = @[@0,@1,@3,@5,@6,@8,@7,@6,@5,@4,@2,@2,@0];
        NSArray *dataArray2 = @[@9,@8,@6,@5,@4,@3,@2,@2,@4,@6,@8,@9,@9];
        
        NSMutableArray *series1 = [[NSMutableArray alloc] init];
        NSMutableArray *series2 = [[NSMutableArray alloc] init];
        allSeries = @[series1, series2];
        
        for (NSInteger i=0; i<dataArray1.count; i++) {
            TVPoint *point1 = [[TVPoint alloc] initWithX:i andY:[(NSNumber *)dataArray1[i] doubleValue]];
            [series1 addObject:point1];
            TVPoint *point2 = [[TVPoint alloc] initWithX:i andY:[(NSNumber *)dataArray2[i] doubleValue]];
            [series2 addObject:point2];
        }
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    CGRect trendViewFrame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.width*2/3);
    trendView = [[TVTrendView alloc] initWithFrame:trendViewFrame];
    trendView.titleText = @"Trend Title";
    trendView.xAxisLabelText = @"X Axis Label";
    trendView.yAxisLabelText = @"Y Axis Label";
    trendView.xUnits = @"X Units";
    trendView.yUnits = @"Y Units";
    trendView.datasource = self;
    
    [self.view addSubview:trendView];
}

-(NSUInteger)numberOfSeriesInTrendView:(TVTrendView *)trendView {
    return 2;
}

-(NSUInteger)trendView:(TVTrendView *)trendView numberOfElementsInSeries:(long)series {
    NSUInteger smallestNumber = NSUIntegerMax;
    for (NSArray *series in allSeries) {
        if (series.count < smallestNumber) {
            smallestNumber = series.count;
        }
    }
    return smallestNumber;
}

-(id<TVPointProtocol>)trendView:(TVTrendView *)trendView pointInSeries:(long)series forIndex:(long)index {
    TVPoint *point = [(NSMutableArray *)allSeries[series] objectAtIndex:index];
    return point;
}

/*
 *  You must tell the trendview what range of values to display
 */
-(TVDataRanges)dataRangesForTrendView:(TVTrendView *)trendView {
    TVPoint *point;
    

    point = [allSeries[0] objectAtIndex:0];
    
    double minX = point.x;
    double minY = point.y;
    double maxX = point.x;
    double maxY = point.y;
    
    for (NSMutableArray *series in allSeries) {
        for (TVPoint *point in series) {
            
            if (point.x < minX) {
                minX = point.x;
            }
            if (point.y < minY) {
                minY = point.y;
            }
            if (point.x > maxX) {
                maxX = point.x;
            }
            if (point.y > maxY) {
                maxY = point.y;
            }
        }
    }
    
    TVDataRanges ranges = [trendView dataRangeWithMinX:minX minY:minY maxX:maxX maxY:maxY];
    
    return ranges;
}

-(UIColor *)trendView:(TVTrendView *)trendView colorForSeries:(long)series {
    if (series == 0) {
        return [UIColor redColor];
    } else if (series == 1) {
        return [UIColor blueColor];
    } 
    return [UIColor yellowColor]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
