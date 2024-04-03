//
//  ViewController.swift
//  TintHW
//
//  Created by Ting on 2024/3/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tapButton: UIButton!
    
    @IBAction func ActionButton(_ sender: UIButton) {
        if let listVC = storyboard?.instantiateViewController(withIdentifier: "ListVC") as? ListViewController {
            navigationController?.pushViewController(listVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
