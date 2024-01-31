//
//  IntCaseIterable.swift
//  SharedDesignSystem
//
//  Created by HUNHIE LEE on 1/30/24.
//

import Foundation

public protocol IntCaseIterable: RawRepresentable, CaseIterable where RawValue == Int { }
