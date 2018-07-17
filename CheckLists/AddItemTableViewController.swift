//
//  AddItemTableViewController.swift
//  CheckLists
//
//  Created by Nour Abukhaled on 2/26/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//
import UIKit

protocol AddItemViewControllerDelegate: class {
    
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller:AddItemTableViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller:AddItemTableViewController, didFinishEditing item: ChecklistItem)
}
class AddItemTableViewController: UITableViewController , UITextFieldDelegate {
 
    @IBOutlet var textField: UITextField!
    @IBOutlet var cancelBarButton: UIBarButtonItem!
    @IBOutlet var doneBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
          textField.text = item.text
            doneBarButton.isEnabled = true
            
        }
}
    // to dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }

    @IBAction func Cancel(){
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
}
    @IBAction func Done(){
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: itemToEdit)
        }else{
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // to enable copy past
        let oldText = textField.text!
        let stringRange = Range(range,in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    
}
