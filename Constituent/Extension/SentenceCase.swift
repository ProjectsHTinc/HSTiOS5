//
//  SentenceCase.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 03/08/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
