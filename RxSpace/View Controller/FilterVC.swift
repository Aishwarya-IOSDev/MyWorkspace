//
//  FilterVC.swift
//  RxSpace
//
//  Created by Aishwarya Aneja on 1/21/23.
//

import Foundation
import UIKit

class FilterVC :UIViewController{
    
    @IBOutlet weak var back_View :UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back_View.backgroundColor = UIColor.black.withAlphaComponent(0.04)
        
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.addTarget(self, action: #selector(actionViewTap(_:)))
        back_View.addGestureRecognizer(tapGesture)

    }
    
    @objc func actionViewTap(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true)
    }
    
    
    
}
