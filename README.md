CHColorPickerView
=================

Easy to use color picker for iOS with just one delegate method. Supports iPhone and iPad

## Usage
- Refer to the **Demo project**.
- Drag and Drop CHColorPicker.h/.m into your project
- Implement the delegate method in your ViewController


Setting up the SectionSelectionView (Example)

```objc
	colorPickerView = [[CHColorPickerView alloc] init];
    
    
    // 1. Setup delegate (Implement delegate methods)
    
    colorPickerView.delegate = self;
    
    
    
    // 2. Setup desired behaviour
    
    colorPickerView.colorsPerRow = 4;
    colorPickerView.colorCellPadding = 2.0;
    
    colorPickerView.highlightSelection = YES;
    colorPickerView.selectionBorderColor = [UIColor whiteColor];
    
    
    // 3. Set colors that should be available as an NSArray
    
    [colorPickerView setColors:[self createDemoColor]];
    
    
    // 4 Do some styling
    
    colorPickerView.backgroundColor = [UIColor colorWithHexString:@"1d2225"];
    
    
    // 5. add to view hierachy
    
    [self.view addSubview:colorPickerView];
```

Implement the delegate

```objc
    -(void)colorPickerView:(CHColorPickerView *)colorPickerView didSelectColor:(UIColor *)color;
```

## License
Copyright 2014 Clemens Hammerl

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
 limitations under the License. 

Attribution is appreciated.