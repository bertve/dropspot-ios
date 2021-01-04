//
//  Theme.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 28/12/2020.
//

import Foundation
import MaterialComponents

extension UIColor {

    // SOURCE: https://omaralbeik.com/blog/uicolor-from-hex
    convenience init?(hex: String) {
        var hexString = hex

        if hexString.hasPrefix("#") { // Remove the '#' prefix if added.
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            hexString = String(hexString[start...])
        }

        if hexString.lowercased().hasPrefix("0x") { // Remove the '0x' prefix if added.
            let start = hexString.index(hexString.startIndex, offsetBy: 2)
            hexString = String(hexString[start...])
        }

        let r, g, b, a: CGFloat
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else { return nil } // Make sure the strinng is a hex code.

        switch hexString.count {
        case 3, 4: // Color is in short hex format
            var updatedHexString = ""
            hexString.forEach { updatedHexString.append(String(repeating: String($0), count: 2)) }
            hexString = updatedHexString
            self.init(hex: hexString)

        case 6: // Color is in hex format without alpha.
            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
            b = CGFloat(hexNumber & 0x0000FF) / 255.0
            a = 1.0
            self.init(red: r, green: g, blue: b, alpha: a)

        case 8: // Color is in hex format with alpha.
            r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
            g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(hexNumber & 0x000000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)

        default: // Invalid format.
            return nil
        }
    }

}


class Theme {
    
    static func globalContainerSheme() -> MDCContainerScheming {
         let containerSheme = MDCContainerScheme()
        containerSheme.colorScheme = self.globalColorSheme()
        containerSheme.shapeScheme = self.globalShapeScheme()
        containerSheme.typographyScheme = self.globalTypographySheme()
        
        return containerSheme
    }

    private static func globalShapeScheme() -> MDCShapeScheme {
        let shapeScheme = MDCShapeScheme()
        
        // small comps
        // Extended FAB,FAB,Snackbar,Textfield, Button, Chip
        shapeScheme.smallComponentShape = MDCShapeCategory(cornersWith: .rounded, andSize: 2)
        
        // medium comps: card, dialog
        shapeScheme.mediumComponentShape = MDCShapeCategory(cornersWith: .rounded, andSize: 8)
        
        // larg comps: bottom sheet(modal), nav drawer
        let largeShapeCategory = MDCShapeCategory()
        let rounded50PercentCorner = MDCCornerTreatment.corner(withRadius: 0.5,
                                                               valueType: .percentage)
        let cut8PointsCorner = MDCCornerTreatment.corner(withCut: 8)
        largeShapeCategory?.topLeftCorner = rounded50PercentCorner
        largeShapeCategory?.topRightCorner = rounded50PercentCorner
        largeShapeCategory?.bottomLeftCorner = cut8PointsCorner
        largeShapeCategory?.bottomRightCorner = cut8PointsCorner
        shapeScheme.largeComponentShape = largeShapeCategory!
        
        return shapeScheme
    }
    
    static func globalColorSheme() -> MDCSemanticColorScheme {
        let colorSheme = MDCSemanticColorScheme()
        colorSheme.primaryColor = UIColor(hex:"#27353d")!
        colorSheme.primaryColorVariant = UIColor(hex: "#505f67")!
        colorSheme.onPrimaryColor = .white
        colorSheme.secondaryColor = UIColor(hex: "#80e29d")!
        colorSheme.onSecondaryColor = UIColor(hex: "#000f17")!
        colorSheme.errorColor = UIColor(hex: "#B00020")!
        colorSheme.surfaceColor = .white
        colorSheme.onSurfaceColor = UIColor(hex: "#000f17")!
        colorSheme.backgroundColor = .white
        colorSheme.onBackgroundColor = UIColor(hex: "#000f17")!
        
        
        return colorSheme
    }
    
    private static func globalTypographySheme() -> MDCTypographyScheme {
        let typoScheme = MDCTypographyScheme()
        return typoScheme
    }
    
    static func applyThemeToButton(_ btn: MDCButton){
        btn.applyContainedTheme(withScheme: globalContainerSheme())
    }
    
    static func applyThemeToTextField(_ txtf: MDCOutlinedTextField){
        txtf.applyTheme(withScheme: globalContainerSheme())
    }
    
    static func applyThemeToNavDrawer(_ drawer: MDCBottomDrawerViewController){
        drawer.applyTheme(withScheme: globalContainerSheme())
    }
    
}

    
