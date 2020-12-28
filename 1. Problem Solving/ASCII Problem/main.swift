//
//  main.swift
//  ASCII Problem
//
//  Created by MBP on 28/12/2020.
//  Copyright © 2020 Saad Abdullah. All rights reserved.
//

import Foundation

func replace(string s: inout String, n: Int) {
    let offset = n % 26
    
    for (i,c) in s.enumerated() {
        let index = s.index(s.startIndex, offsetBy: i)
        
        let ascii = UnicodeScalar(c.asciiValue!)
        var newIntValue = Int(ascii.value) + offset
        
        newIntValue =  newIntValue > 122 ? (newIntValue - 122) + 96 : newIntValue
        
        let newchar = String(UnicodeScalar(UInt8(newIntValue)))
        s.replaceSubrange(index...index, with: newchar)
    }
}

var s = "abc"
replace(string: &s, n: 28)
print(s)
