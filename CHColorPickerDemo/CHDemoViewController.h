//
//  CHDemoViewController.h
//  CHColorPickerDemo
//
//  Created by Clemens Hammerl on 04.07.14.
//  Copyright (c) 2014 cocoabeats GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CHColorPickerView.h"

@interface CHDemoViewController : UIViewController <CHColorPickerViewDelegate>
{
    @private
    CHColorPickerView *colorPickerView;
    NSInteger gridSize;

}
@end
