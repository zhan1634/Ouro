//
//  SearchView.swift
//  MyTraininfo
//
//  Created by MyMac on 08/07/19.
//  Copyright © 2019 MyMac. All rights reserved.
//

import UIKit

class SearchView: UISearchBar {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
