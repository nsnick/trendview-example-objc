//
//  ViewController.h
//  TrendViewExample
//
//  Created by Nick Wilkerson on 5/4/17.
//  Copyright © 2017 Nick Wilkerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVTrendView.h"

@interface ViewController : UIViewController <TVTrendViewDatasource> {
    TVTrendView *trendView;
    NSArray *allSeries;
}


@end

