//
//  NFCManager.swift
//  NFC_DEMO
//
//  Created by Geniusport on 5/3/18.
//  Copyright © 2018 Adeptpros. All rights reserved.
//

import Foundation
import CoreNFC

class NFCManager: NSObject, NFCNDEFReaderSessionDelegate {
    
    static let shared = NFCManager()
    typealias delegate = (String) -> Void
    private var completionBlock: delegate?
    
    private override init() {
        super.init()
        completionBlock = nil
    }
    
    func readTag(_ handler: delegate?) {
        self.completionBlock = handler
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        completionBlock?(error.localizedDescription)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let message = messages.first else { return }
        guard let payload = message.records.first else { return }
        guard let payloadData = String(data: payload.payload, encoding: String.Encoding.utf8) else { return }
        completionBlock?(payloadData)
    }
}

