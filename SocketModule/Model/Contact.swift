//
//	contact.swift
//
//	Create by Devubha Manek on 3/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Contact{
	var email : String
	var familyName : String
	var givenName : String
	var phoneNumber : String

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    init(fromString string:String){
        let dictionary:[String:Any] = convertToDictionary(text: string)!
        email = getStringFromDictionary(dictionary: dictionary, key: "email")
        familyName = getStringFromDictionary(dictionary: dictionary, key: "familyName")
        givenName = getStringFromDictionary(dictionary: dictionary, key: "givenName")
        phoneNumber = getStringFromDictionary(dictionary: dictionary, key: "phoneNumber")
    }

}
