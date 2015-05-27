//
//  Climbers.swift
//  BoulderTransition
//
//  Created by CHENCHIAN on 5/22/15.
//  Copyright (c) 2015 KICKERCHEN. All rights reserved.
//

import Foundation

struct Climbers {
    let name: String
    let image: String
    let imageUrl: String
    let webpage: String
    let nationality: String
    let birthyear: String
    let height: String
    let weight: String
    
    static func all() -> [Climbers] {
        return [Climbers(name: "Nalle Hukkataival", image: "Nalle Hukkataival.jpg", imageUrl: "http://www.up-climbing.com/cache/images/original_photo_5577.jpg", webpage: "http://www.nallehukkataival.com/", nationality: "Finn", birthyear: "1986", height: "173 cm(5.8')", weight: "68 kg(150 lbs)"),
            Climbers(name: "Nicky de Leeuw", image: "Nicky de Leeuw.jpg", imageUrl: "http://www.siked.nl/wp-content/uploads/2015/05/NickyDeLeeuw-11.png", webpage: "https://www.facebook.com/nickydeleeuwclimbing", nationality: "Dutch", birthyear: "1989", height: "187 cm(6.2')", weight: "74 kg(163 lbs)"),
            Climbers(name: "Akiyo Noguchi", image: "Akiyo Noguchi.jpg", imageUrl: "http://www.planetmountain.com/img/1/20100.jpg", webpage: "http://akiyonoguchi.com/", nationality: "Japanese", birthyear: "1989", height: "165 cm(5.5')", weight: "49 kg(108 lbs)"),
            Climbers(name: "Juliane Wurm", image: "Juliane Wurm.jpg", imageUrl: "http://www.klettern.de/sixcms/media.php/6/MKJule%26Jonas-BouldernWEB.jpg", webpage: "http://www.julianewurm.de/", nationality: "German", birthyear: "1990", height: "160 cm(5.3')", weight: "49 kg(108 lbs)"),
            Climbers(name: "Jan Hojer", image: "Jan Hojer.jpg", imageUrl: "http://www.alpenverein.de/chameleon/public/6c541a0c-bdf5-a4f5-6c07-983a72a50b14/jan-hojer-bwc-muenchen-2011-foto-dav-marco-kost_19770.jpg", webpage: "https://www.facebook.com/jan.hojer.58", nationality: "German", birthyear: "1992", height: "186 cm(6.1')", weight: "78 kg(172 lbs)"),
            Climbers(name: "Adam Ondra", image: "Adam Ondra.jpg", imageUrl: "http://www.climbandmore.com/upload/Piotr%20Drozdz%204(1).jpg", webpage: "http://www.adamondra.com/", nationality: "Czech", birthyear: "1993", height: "185 cm(6.1')", weight: "68 kg(150 lbs)")
        ]
    }
}