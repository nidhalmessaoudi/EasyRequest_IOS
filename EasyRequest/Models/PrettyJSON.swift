//
//  PrettyJSON.swift
//  EasyRequest
//
//  Created by Nidhal Messaoudi on 9/28/21.
//  Copyright © 2021 Nidhal Messaoudi. All rights reserved.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
