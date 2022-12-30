//
//  AppConstant.swift
//  Recro Interview Task
//
//  Created by Brijesh on 29/12/22.
//
//****************************************************************************
//NOTE: - Please Do not change any (sesitive) value if you are not sure.
//****************************************************************************

import Foundation

enum AppConstants {
    static let appName:String = "Recro Interview Task"
    
}

enum ApiConstant {
    static let baseURL:String = "https://run.mocky.io"
    
    enum URLs {
        static let getProductList:String = baseURL + "/v3/2f06b453-8375-43cf-861a-06e95a951328"
    }
}
