//
//  IntCaseIterable.swift
//  SharedDesignSystem
//
//  Created by walkerhilla on 1/25/24.
//

import Foundation

public protocol IntCaseIterable: RawRepresentable, CaseIterable where RawValue == Int { }
