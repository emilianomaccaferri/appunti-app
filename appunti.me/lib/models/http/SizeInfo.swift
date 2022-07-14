//
//  SizeInfo.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 14/07/22.
//

import Foundation
import SwiftUI

struct SizeInfo: Codable{
    let folder_size_bytes: Float;
    let folder_size_kilobytes: Float;
    let folder_size_megabytes: Float;
    let folder_size_gigabytes: Float;
    let completion_percentage: CGFloat;
    let max_folder_size_bytes: Float;
    let max_folder_size_kilobytes: Float;
    let max_folder_size_megabytes: Float;
    let max_folder_size_gigabytes: Float;
    init(){
        self.folder_size_bytes = 0;
        self.folder_size_kilobytes = 0;
        self.folder_size_megabytes = 0;
        self.folder_size_gigabytes = 0;
        self.completion_percentage = 0;
        self.max_folder_size_bytes = 0;
        self.max_folder_size_kilobytes = 0;
        self.max_folder_size_megabytes = 0;
        self.max_folder_size_gigabytes = 0;
    }
}
