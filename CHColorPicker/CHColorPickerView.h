//
//  CHColorPickerView.h
//  CHColorPickerDemo
//
//  Created by Clemens Hammerl on 04.07.14.
//  Copyright (c) 2014 cocoabeats GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHColorPickerView;
@protocol CHColorPickerViewDelegate <NSObject>

// gets called after a color has been selected
-(void)colorPickerView:(CHColorPickerView *)colorPickerView didSelectColor:(UIColor *)color;

@end

@interface CHColorPickerView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{

    
    
    __weak id<CHColorPickerViewDelegate> delegate;
    
    @private
    NSArray *colors;                                                                // Array that contains the UIColor objects for the picker


}




// Delegates
@property (nonatomic, weak) id<CHColorPickerViewDelegate> delegate;                 // The Color Pickers Delegate, may be nil


// Subviews
@property (nonatomic, strong, readonly) UICollectionView *colorView;                // The collection view displaying the colors


// Layout
@property (nonatomic, assign) NSInteger colorsPerRow;                               // Number of colors displayed per row
@property (nonatomic, assign) CGFloat colorCellPadding;                             // Space between color cells (horizontal and vertical


// Selection behaviour
@property (nonatomic, assign) BOOL highlightSelection;                              // If set to YES a border with "selectionBorderColor" is drawn around color cell, defaults to YES
@property (nonatomic, strong) UIColor *selectionBorderColor;                        // The color used for the border that highlights the selection


// public methods
-(void)setColors:(NSArray *)colors;                                                 // Changes the colors displayed at the picker

@end
