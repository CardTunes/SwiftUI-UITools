//
//  JsonUtil.swift
//  UITools
//
//  Created by David Card on 9/20/24.
//

import Foundation
public class JsonUtil {
    public static func decode<T : Decodable>(json:String) -> T? {
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        var result:T?
        do {
            result = try decoder.decode(T.self, from: jsonData)
            return result
        }
        catch {
            print(error)
        }
        return nil
    }
    
    public static func encode<T : Encodable>(item:T) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(item)
        let json = String(data: data, encoding: String.Encoding.utf8)
        return json!
    }
}
