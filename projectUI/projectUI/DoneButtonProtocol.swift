//
//  DoneButtonProtocol.swift
//  projectUI
//
//  Created by namhee kim on 1/27/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import UIKit



protocol DoneButtonDelegate: class {
    func doneButtonPressedFrom(controller: UIViewController)
}