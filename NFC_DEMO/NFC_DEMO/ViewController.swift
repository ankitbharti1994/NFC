//
//  ViewController.swift
//  NFC_DEMO
//
//  Created by Geniusport on 5/3/18.
//  Copyright © 2018 Adeptpros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func readNFCTag(_ sender: Any) {
        NFCManager.shared.readTag {(payloadMessage) in
            DispatchQueue.main.async {
                self.messageLabel.text = payloadMessage
            }
        }
    }
}

