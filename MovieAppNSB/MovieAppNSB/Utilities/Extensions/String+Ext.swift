//
//  String+Ext.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 6.05.2024.
//

import Foundation


extension String {
    // Her kelimenin ilk harfini büyük hale getiren fonksiyon
    func capitalizeFirstLetterOfWords() -> String {
        // Metni boşluk karakterine göre böler ve bir diziye dönüştürür
        return self.components(separatedBy: " ").map {
            // Her kelimeyi dönüştürür
            // $0 her kelimeyi temsil eder
            // prefix(1) her kelimenin ilk harfini alır
            // uppercased() bu ilk harfi büyük harfe dönüştürür
            // lowercased().dropFirst() ise her kelimenin geri kalanını küçük harfe dönüştürür ve ilk harfi keser
            $0.prefix(1).uppercased() + $0.lowercased().dropFirst()
        }.joined(separator: " ") // Her kelimeyi birleştirir ve boşluk karakteriyle ayırır
    }
}

