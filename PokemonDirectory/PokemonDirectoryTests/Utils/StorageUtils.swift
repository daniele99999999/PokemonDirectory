//
//  StorageUtils.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

struct StorageUtils
{
    static func loadPlist(name: String, rootKey: String?, bundle: Bundle = Bundle.main) -> Dictionary<String, Any>?
    {
        guard let path = bundle.url(forResource: name, withExtension: "plist") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        guard let plistDictionary = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] ?? [:] else { return nil }
        
        if let rootKey = rootKey
        {// ho passato la root -> estraggo il dictionary interno
            
            guard let plistSubDictionary = plistDictionary[rootKey] as? [String: Any] else
            {
                return nil
            }
            
            return plistSubDictionary
        }
        else
        {// non ho passato la root -> restituisco tutto il plist
            return plistDictionary
        }
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> Array<Dictionary<String, Any>>?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        guard let JSONArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: Any]] else { return nil }
        return JSONArray
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> Dictionary<String, Any>?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        guard let JSONDictionary = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else { return nil }
        return JSONDictionary
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> Data?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        return data
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> String?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
