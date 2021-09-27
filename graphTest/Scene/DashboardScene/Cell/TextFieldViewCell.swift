//
//  TextFieldViewCell.swift
//  graphTest
//
//  Created by Javier Hernandez on 23/09/21.
//

import UIKit


protocol textfieldDelegate: AnyObject {
    func returnString(string: String)
}

class TextFieldViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    
    weak var delegate: textfieldDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TextFieldViewCell: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let Regex = "[a-z A-Z ]+"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)
        if predicate.evaluate(with: text) || string == ""
        {
            return true
        }
        else
        {
            return false
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.returnString(string: textField.text ?? "")
    }
}
