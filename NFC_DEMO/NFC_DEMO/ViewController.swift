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
    
    @IBAction func openDocument(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes:
            ["com.apple.iwork.pages.pages",
             "com.apple.iwork.numbers.numbers",
             "com.apple.iwork.keynote.key",
             "public.image",
             "com.apple.application",
             "public.item","public.data",
             "public.content",
             "public.audiovisual-content",
             "public.movie",
             "public.audiovisual-content",
             "public.video",
             "public.audio",
             "public.text",
             "public.data",
             "public.zip-archive",
             "com.pkware.zip-archive",
             "public.composite-content",
             "public.text"], in: .open)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
}

extension ViewController: UIDocumentPickerDelegate,UINavigationControllerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            print("couldn't pick document")
            return
        }
        DispatchQueue.main.async {
            self.messageLabel.text = "\(url)"
        }
        let documentInteractionController = UIDocumentInteractionController(url: url)
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

