//
//  ViewController.swift
//  TipHelper
//
//  Created by Nesha Prabahar on 15/07/20.
//  Copyright © 2020 Nesha Prabahar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tipControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        tipControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
    }
    
    @IBOutlet weak var newBillField: UITextField!
    @IBOutlet weak var otherTip: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var groupTextField: UITextField!
    
    @IBOutlet weak var groupTotal: UILabel!
    
    @IBOutlet weak var dollarImage: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newBillField.becomeFirstResponder()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        var group = Double(groupTextField.text!) ?? 1.0
        
        if group == 0.0 {
            group = 1.0
        }
        
        let bill = Double(newBillField.text!) ?? 0
        let percents = [0.15, 0.18, 0.2]
        var percent = 0.15
        if tipControl.selectedSegmentIndex == 3 {
            percent = Double(otherTip.text!) ?? 15.0
            percent = percent/100.0
        } else {
            percent = percents[tipControl.selectedSegmentIndex]
        }
        
        let tip = bill * percent
        let total = bill + tip
        let groupTot = total/group
        
        tipLabel.text = String(format: "$%0.2f", groupTot)
        groupTotal.text = String(format: "$%0.2f", total)
        
        UIView.animate(withDuration: 1.0, delay: 0.0,
        options: [],
        animations: { () -> Void in
           self.dollarImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: nil)

    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(newBillField?.text, forKey: "billAmount")
        
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)

        //if let value = coder.decodeObject(forKey: "billAmount") as? String {
        newBillField?.text = coder.decodeObject(forKey: "billAmount") as? String
        newBillField?.becomeFirstResponder()
        //}
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}

