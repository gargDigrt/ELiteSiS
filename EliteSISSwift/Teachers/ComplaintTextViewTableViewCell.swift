//
//  ComplaintTextViewTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 14/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ComplaintTextViewTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var textViewReason: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textViewReason.delegate = self
        
        textViewReason.text = "Response to Complaints"
        textViewReason.textColor = UIColor.lightGray
        textViewReason.layer.borderWidth = 1
        textViewReason.layer.borderColor = UIColor.black.cgColor
        textViewReason.tintColor = UIColor.black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Response to Complaints"
            textView.textColor = UIColor.lightGray
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
