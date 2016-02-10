//
//  FPCBonsaiDueAddFPCBonsai.h
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPCBonsai;
@class VarietyPickerController;

@interface FPCBonsaiDueAddBonsaiViewController : UITableViewController <UITextFieldDelegate,
                                                                     UIPickerViewDataSource,
                                                                     UIPickerViewDelegate>

@property (strong, nonatomic) FPCBonsai * myNewFPCBonsai;
@property (strong, nonatomic) NSString *varietyPickedValue;

@property (weak, nonatomic) IBOutlet UITextField *nameInput;

@property (weak, nonatomic) IBOutlet UITextField *ageInput;

@property (weak, nonatomic) IBOutlet UILabel *varietyLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
