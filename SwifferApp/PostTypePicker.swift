//
//  PostTypePicker.swift
//  SwifferApp
//
//  Created by Kat Slump on 1/8/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

import UIKit

class PostTypePicker: UIPickerView {
    var types = ["Health","Current events","Letter","Milestones","Social"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }

}
