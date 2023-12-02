//
//  Icons.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//
import SwiftUI
import Foundation



struct IconPickerView: View {
    @Binding var selectedImage: String
    
    let rows = [GridItem(.fixed(35)), GridItem(.fixed(35)), GridItem(.fixed(35)),GridItem(.fixed(35)),GridItem(.fixed(35))]
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(Icons.allIcons, id: \.self) { image in
                    HStack {
                        VStack {
                            Image(systemName: image)
                                .foregroundColor(Color(Colors.mainText))
                                .font(.system(size: 20))
                                .frame(width: 40, height: 40)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .strokeBorder(Color(Colors.mainText))
                                }
                        }
                    }
                    .opacity(image == selectedImage ? 1.0 : 0.5)
                    .scaleEffect(image == selectedImage ? 1.1 : 1.0)
                    .onTapGesture {
                        selectedImage = image
                    }
                }
            }
            .padding(2)
        }
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(selectedImage: .constant("folder.circle"))
    }
}
struct Icons {
    
    
    static let car: String = "car.fill"
    static let box_truck: String = "box.truck"
    static let car_2: String = "car.2"
    static let car_3: String = "car"
    static let creditcard: String = "creditcard"
    static let banknote: String = "banknote"
    static let banknote_2: String = "banknote.fill"
    static let giftcard: String = "giftcard"
    static let person_2: String = "person.2"
    static let person_bust: String = "person.bust"
    static let figure_wave: String = "figure.wave"
    static let figure_roll: String = "figure.roll"
    static let circle_hexagonpath: String = "circle.hexagonpath"
    static let captions_bubble: String = "captions.bubble"
    static let network_badge_shield_half_filled: String = "network.badge.shield.half.filled"
    static let icloud: String = "icloud"
    static let bonjour: String = "bonjour"
    static let figure_2_and_child_holdinghands: String = "figure.2.and.child.holdinghands"
    static let figure_and_child_holdinghands: String = "figure.and.child.holdinghands"
    static let face_smiling: String = "face.smiling"
    static let house: String = "house"
    static let sofa: String = "sofa"
    static let fireplace: String = "fireplace"
    static let fish: String = "fish"
    static let hare: String = "hare"
    static let pawprint: String = "pawprint"
    static let popcorn: String = "popcorn"
    static let lightbulb_circle_fill: String = "lightbulb.circle.fill"
    static let figure_walk: String = "figure.walk"
    static let heart: String = "heart"
    static let pill: String = "pill"
    static let cross: String = "cross"
    static let stethoscope_circle_fill: String = "stethoscope.circle.fill"
    static let fleuron: String = "fleuron"
    static let wand_and_stars_inverse: String = "wand.and.stars.inverse"
    static let pencil_tip: String = "pencil.tip"
    static let wifi: String = "wifi"
    static let wifi_2: String = "wifi.circle.fill"
    static let antenna_radiowaves_left_and_right: String = "antenna.radiowaves.left.and.right"
    static let network: String = "network"
    static let book: String = "book"
    static let graduationcap: String = "graduationcap"
    static let pencil_and_ruler: String = "pencil.and.ruler"
    static let backpack: String = "backpack"
    static let tshirt: String = "tshirt"
    static let tag: String = "tag"
    static let gift: String = "gift"
    static let shippingbox: String = "shippingbox"
    static let party_popper_fill: String = "party.popper.fill"
    static let cart: String = "cart"
    static let carrot: String = "carrot"
    static let airpods_chargingcase: String = "airpods.chargingcase"
    static let airplane: String = "airplane"
    static let sailboat: String = "sailboat"
    static let road_lanes: String = "road.lanes"
    static let music_mic: String = "music.mic"
    static let theatermasks: String = "theatermasks"
    static let fuelpump_fill: String = "fuelpump.fill"
    static let display: String = "display"
    static let applewatch_watchface: String = "applewatch.watchface"
    static let gamecontroller: String = "gamecontroller"
    static let bus_fill: String = "bus.fill"
    static let cablecar: String = "cablecar"
    static let steeringwheel: String = "steeringwheel"
    static let key: String = "key"
    static let door_right_hand_closed: String = "door.right.hand.closed"
    static let house_and_flag: String = "house.and.flag"
    static let arrow_triangle_2_circlepath: String = "arrow.triangle.2.circlepath"
    static let dollarsign_arrow_circlepath: String = "dollarsign.arrow.circlepath"
    static let hourglass: String = "hourglass"
    static let chart_xyaxis_line: String = "chart.xyaxis.line"
    static let creditcard_and_123: String = "creditcard.and.123"
    static let chart_bar: String = "chart.bar"
    static let dollarsign: String = "dollarsign"
    static let rublesign: String = "rublesign"
    static let eurosign: String = "eurosign"
    static let shippingbox_circle: String = "shippingbox.circle"
    static let timelapse: String = "timelapse"
    static let camera_metering_matrix: String = "camera.metering.matrix"
    static let person_fill_checkmark: String = "person.fill.checkmark"
    static let person_crop_square_filled_and_at_rectangle_fill: String = "person.crop.square.filled.and.at.rectangle.fill"
    static let bitcoinsign: String = "bitcoinsign"
    static let percent: String = "percent"
    static let sum: String = "sum"
    static let number: String = "number"
    
    static let allIcons: [String] =
    [
        //Transportation Expenses
        car,
        box_truck,
        car_2,
        car_3,
        //Credit card, Loans, Debt
        creditcard,
        banknote,
        banknote_2,
        giftcard,
        person_2,
        person_bust,
        figure_wave,
        figure_roll,
        circle_hexagonpath,
        captions_bubble,
        network_badge_shield_half_filled,
        icloud,
        bonjour,
        figure_2_and_child_holdinghands,
        figure_and_child_holdinghands,
        face_smiling,
        house,
        sofa,
        fireplace,
        fish,
        hare,
        pawprint,
        popcorn,
        lightbulb_circle_fill,
        figure_walk,
        heart,
        pill,
        cross,
        stethoscope_circle_fill,
        fleuron,
        wand_and_stars_inverse,
        pencil_tip,
        wifi,
        wifi_2,
        network,
        antenna_radiowaves_left_and_right,
        book,
        graduationcap,
        pencil_and_ruler,
        backpack,
        tshirt,
        tag,
        gift,
        shippingbox,
        party_popper_fill,
        cart,
        carrot,
        airpods_chargingcase,
        airplane,
        sailboat,
        road_lanes,
        music_mic,
        theatermasks,
        fuelpump_fill,
        display,
        applewatch_watchface,
        gamecontroller,
        bus_fill,
        cablecar,
        steeringwheel,
        key,
        door_right_hand_closed,
        house_and_flag,
        arrow_triangle_2_circlepath,
        dollarsign_arrow_circlepath,
        hourglass,
        chart_xyaxis_line,
        creditcard_and_123,
        chart_bar,
        dollarsign,
        rublesign,
        eurosign,
        bitcoinsign,
        shippingbox_circle,
        timelapse,
        camera_metering_matrix,
        person_fill_checkmark,
        person_crop_square_filled_and_at_rectangle_fill,
        percent,
        sum,
        number
    ]
}






//"car.fill",
//"house.circle.fill",
//"house.fill",
//"bolt.circle.fill",
//"power.circle.fill",
//"lightbulb.circle.fill",
//"graduationcap.circle.fill",
//"graduationcap.fill",
//"fork.knife.circle.fill",
//"cart.fill",
//"cart.circle.fill",
//"dollarsign.circle.fill",
//"dollarsign",
//"fuelpump.fill",
//"fuelpump.circle.fill",
//"wifi.circle.fill",
//"tv.badge.wifi",
//"phone.circle.fill",
//"smartphone",
//"play.circle.fill",
//"stethoscope.circle.fill",
//"cross.circle.fill",
//"figure.run.circle.fill",
//"figure.child.circle.fill",
//"figure.and.child.holdinghands",
//"figure.2.and.child.holdinghands",
//"lightbulb.fill",
//"pawprint.circle.fill",
//"pawprint.fill",
//"dog.circle.fill",
//"cat.circle.fill",
//"cross.case.fill",
//"cross.fill",
//"cross.circle.fill",
//"banknote.fill",
//"network.badge.shield.half.filled",
//"network",
