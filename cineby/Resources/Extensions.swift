//
//  Extensions.swift
//  cineby
//
//  Created by Rishav chandra on 16/04/25.
//

import Foundation


extension String {
    
    func captilizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
