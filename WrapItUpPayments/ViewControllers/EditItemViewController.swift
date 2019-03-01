//
//  EditItemViewController.swift
//  WrapItUpPayments
//
//  Created by Derik Gagnon on 2/26/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBAction func SaveButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func DeleteButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func GoBackButtonPressed(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true) {
            self.NameLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditItemViewController: EditRowDelegate {
    func didTapCell(_ item: MenuItem) {
        print("In Edit")
        //orderViewController?.printItemName(item: item)
        self.NameLabel?.text = item.name
    }
}
