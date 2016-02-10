//
//  VarietyPickerController.h
//  FPBonsaiDue
//
//  Created by Federico Paliotta on 08/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VarietyPickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>



@property (nonatomic) NSArray *varieties;

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *varietySelectedLabel;

-(void)pickerContentInit;

@end
