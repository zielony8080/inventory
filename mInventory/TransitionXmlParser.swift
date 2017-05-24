//
//  TransitionXmlParser.swift
//  mInventory
//
//  Created by Łukasz Zielony on 12.05.2017.
//  Copyright © 2017 Lukasz Zielony. All rights reserved.
//

import Foundation

class TransitionXmlParser: NSObject, XMLParserDelegate {
    
    var parser: XMLParser!
    var states: [DocumentState] = []
    
    func parse() -> [DocumentState] {
        
        if let path = Bundle.main.path(forResource: "document-transitions", ofType: "xml") {
            parser = XMLParser(contentsOf: URL(fileURLWithPath: path))
            parser.delegate = self
            parser.parse()
        }

        return states
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "state" {
            states.append(DocumentState())
            states.last?.name = attributeDict["name"]!
            states.last?.document = attributeDict["document"]!
        } else if elementName == "transition" {
            states.last?.transitions.append(DocumentTransition())
            states.last?.transitions.last?.name = attributeDict["name"]!
            states.last?.transitions.last?.action = attributeDict["action"]
            states.last?.transitions.last?.condition = attributeDict["condition"]
            states.last?.transitions.last?.failureTransition = attributeDict["failureTransition"]
        } else if elementName == "attribute" {
            states.last?.attributes.append(DocumentAttribute(name: attributeDict["name"]!, value: attributeDict["value"]!))
            
        }
    }
}
