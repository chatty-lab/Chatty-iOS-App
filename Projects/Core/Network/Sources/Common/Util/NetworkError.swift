//
//  NetworkError.swift
//  CoreNetwork
//
//  Created by 윤지호 on 1/21/24.
//

import Foundation

public struct NetworkError: Error {
  let errorCase: ErrorCase
  let massage: String
}

public enum ErrorCase: Error {
  // Common Error
  case E000WrongParameter
  case E001TokenAuthenticationFailed
  case E002AccessTokenExpired
  case E003NonExistentUser
  case E004DisabledUser

  // Custom Error
  case E005NaverSnsFailed
  case E006AlreadyExistNickname
  case E007SNSAuthenticationFailed
  case E008AlreadyExistUser
  case E009RefreshTokenExpired
  case E011NonExistentChatRoom
  case E012AlreadyExistChatRoom
  case E013NonExistentChatContent
  case E014SendSNSFailed
  case E015NoUserInChatRoom
  case E016InvalidExtension
  case E017NonExistentMatch
  case E018DailyMatchingLimitOver
  case E019TooManyRequests
  
  // Common Error
  case E097WrongEndpointRequest
  case E098OverCall
  case E099ServerError
  case UnknownError
  
  public var message: String {
    switch self {
    
    // Common Error
    case .E000WrongParameter:
      return "잘못된 파라미터"
    case .E001TokenAuthenticationFailed:
      return "토큰 인증 실패"
    case .E002AccessTokenExpired:
      return "엑세스 토큰 만료"
    case .E003NonExistentUser:
      return "존재하지 않는 사용자"
    case .E004DisabledUser:
      return "이용 정지된 사용자"
      
    // Custom Error
    case .E005NaverSnsFailed:
      return "naver에서 sms 전송을 실패했습니다. "
    case .E006AlreadyExistNickname:
      return "이미 존재 하는 닉네임입니다."
    case .E007SNSAuthenticationFailed:
      return "유효하지 않은 인증 번호입니다."
    case .E008AlreadyExistUser:
      return "이미 존재 하는 유저입니다."
    case .E009RefreshTokenExpired:
      return "refreshToken이 만료되었습니다."
    case .E011NonExistentChatRoom:
      return "채팅방이 존재하지 않습니다."
    case .E012AlreadyExistChatRoom:
      return "채팅방이 이미 존재합니다."
    case .E013NonExistentChatContent:
      return "채팅 내용이 존재하지 않습니다."
    case .E014SendSNSFailed:
      return "sms전송을 실패했습니다."
    case .E015NoUserInChatRoom:
      return "유저가 채팅방에 존재하지 않습니다."
    case .E016InvalidExtension:
      return "올바르지 않은 확장자입니다."
    case .E017NonExistentMatch:
      return "존재하지 않는 매치입니다."
    case .E018DailyMatchingLimitOver:
      return "일일 매칭 횟수 제한을 초과했습니다."
    case .E019TooManyRequests:
      return "너무 많은 요청을 보냈습니다."
    
    // Common Error
    case .E097WrongEndpointRequest:
      return "잘못된 요청"
    case .E098OverCall:
      return "과호출"
    case .E099ServerError:
      return "내부 서버 오류"
    case .UnknownError:
      return ""
    }
    
  }
}

public enum ErrorCode: String {
  // Common Error
  case E000
  case E001
  case E002
  case E003
  case E004
  
  // Custom Error
  case E005
  case E006
  case E007
  case E008
  case E009
  case E011
  case E012
  case E013
  case E014
  case E015
  case E016
  case E017
  case E018
  case E019
  
  // Common Error
  case E097
  case E098
  case E099
  case unknown
  
  public func toCase() -> ErrorCase {
    switch self {
      // Common Error
    case .E000:
      return .E000WrongParameter
    case .E001:
      return .E001TokenAuthenticationFailed
    case .E002:
      return .E002AccessTokenExpired
    case .E003:
      return .E003NonExistentUser
    case .E004:
      return .E004DisabledUser

    // Custom Error
    case .E005:
      return .E005NaverSnsFailed
    case .E006:
      return .E006AlreadyExistNickname
    case .E007:
      return .E007SNSAuthenticationFailed
    case .E008:
      return .E008AlreadyExistUser
    case .E009:
      return .E009RefreshTokenExpired
    case .E011:
      return .E011NonExistentChatRoom
    case .E012:
      return .E012AlreadyExistChatRoom
    case .E013:
      return .E013NonExistentChatContent
    case .E014:
      return .E014SendSNSFailed
    case .E015:
      return .E015NoUserInChatRoom
    case .E016:
      return .E016InvalidExtension
    case .E017:
      return .E017NonExistentMatch
    case .E018:
      return .E018DailyMatchingLimitOver
    case .E019:
      return .E019TooManyRequests
      
    // Common Error
    case .E097:
      return .E097WrongEndpointRequest
    case .E098:
      return .E098OverCall
    case .E099:
      return .E099ServerError
    default:
      return .UnknownError
    }
  }
}
