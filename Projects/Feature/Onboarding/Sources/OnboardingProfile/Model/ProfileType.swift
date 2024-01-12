//
//  ProfileType.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/8/24.
//

import Foundation

public enum ProfileType: CaseIterable {
  case nickName, gender, birth, profileImage, mbti, none
  
  var nextViewType: ProfileType {
    switch self {
    case .nickName:
      return .gender
    case .gender:
      return .birth
    case .birth:
      return .profileImage
    case .profileImage:
      return .mbti
    case .mbti:
      return .none
    case .none:
      return .nickName
    }
  }
  
  func getTitleText(_ nickName: String = "") -> String {
    switch self {
    case .nickName:
      return "닉네임을 만들어 주세요"
    case .gender:
      return "반가워요! \(nickName)님\n성별을 알려주세요."
    case .birth:
      return "생일은 언제인가요?"
    case .profileImage:
      return "프로필 사진을 올려주세요 !"
    case .mbti:
      return "거의 다 왔어요!\n이제 MBTI만 설정하면 끝."
    case .none:
      return ""
    }
  }
  
  var description: String {
    switch self {
    case .nickName:
      return "상대방에게 보여지는 이름이에요.\n나중에 변경할 수 있어요."
    case .gender:
      return "알려주신 성별은 대화할 친구를 찾는데 사용해요."
    case .birth:
      return "알려주신 생일은 대화할 친구를 찾는 데 사용해요."
    case .profileImage:
      return "나를 잘 표현하는 사진으로 첫인상을 남겨보세요"
    case .mbti:
      return "나와 궁합이 잘 맞는 친구를 찾을 수 있어요."
    case .none:
      return ""
    }
  }
  
  var warningDescription: String {
    switch self {
    case .nickName:
      return "다른 사람에게 불쾌감을 주는 닉네임은 제재돼요."
    case .profileImage:
      return ""
    case .gender, .birth:
      return "한 번 설정하면 변경할 수 없어요."
    case .mbti, .none:
      return ""
    }
  }
}