//
//  Movie+CoreDataProperties.swift
//  CoreDataFundamentals
//
//  Created by Ankith on 01/07/24.
//
//

import Foundation
import CoreData
import UIKit

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var rating: Double
    @NSManaged public var runTime: Int64
    @NSManaged public var watched: Bool
    @NSManaged public var posterImage: UIImage?

}

extension Movie : Identifiable {

}
