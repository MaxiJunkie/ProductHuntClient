//
//  IRequestManager.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 02.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation

struct RequestConfig<Model>  {
    let request: IRequest
    let parser: Parser<Model>
}

enum Result<T> {
    case Success(T)
    case Fail(String)
}

protocol IRequestSender {
    func send<Model>(config: RequestConfig<Model>, completionHandler: @escaping (Result<Model>) -> Void)
}

