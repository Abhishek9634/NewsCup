//
//  HTML+Helper.swift
//  Guardian
//
//  Created by Abhishek on 20/07/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import Foundation

class HTML {
    
    static let shared = HTML()
    
    static let bundle = Bundle.main.bundleURL
    
    public func htmlContent(string: String) -> String {
        let html = "\(self.HTMLTagBegin)\(string)\(self.HTMLTagEnd)"
        return html
    }
    
    var HTMLTagBegin: String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="viewport" content="width=device-width-30, initial-scale=1"/>
        <link rel='stylesheet' id='foundation-css' href='style.css' type='text/css' media='all' />
        <style type="text/css">
        .broken_link, a.broken_link {
            text-decoration: line-through;
        }
        html, body, iframe {
            background-image:none;
            background-color:#ffffff;
            font-family: Montserrat-Regular;
            font-size: 90%;
            padding:0px;
            margin:0px;
        }
        @font-face {
            font-family: 'Montserrat-Regular';
            src: local('Montserrat-Regular'), url('Montserrat-Regular.ttf') format("truetype");
        }
        h1, h2, h3, h4, h5, h6 {
            color:#1A1A1A;
        }
        body {
            color:#4C4C4C;
        }
        strong {
            color:#1A1A1A;
        }
        /*img {
            width:auto;
            height:auto;
        }*/
        iframe {
            width:100%;
            height:auto;
        }
        div {
            padding: 5px;
        }
        label {
            padding : 0px,0px,15px,0px
        }
        input[type=text], select, textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        resize: vertical;
        }
        </style>
        </head>
        <body>
        """
    }
    
    let HTMLTagEnd: String = "</body></html>"
    
    var EmptyContent: String {
        return "\(self.HTMLTagBegin)<p>No Description Available</p>\(self.HTMLTagEnd)"
    }
}
