//
//  Collection+Ext.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 14.05.2024.
//

import Foundation



//Koleksiyonun belirli bir indeksine güvenli bir şekilde erişmek için özel bir altscript (alt betimleyici) oluşturur
extension Collection {
    subscript(safe index: Index) -> Element? {
        //Bu altscript, koleksiyonun sınırları dışındaki bir indekse erişmeye çalışıldığında nil döndürür.
        return indices.contains(index) ? self[index] : nil
    }
}

// Element, bir koleksiyonun elemanlarının türünü temsil ederken, Index koleksiyonun içindeki belirli bir elemanın konumunu belirten türdür.
// indices, bir koleksiyonun geçerli indekslerinin aralığını temsil eden bir özelliktir.
