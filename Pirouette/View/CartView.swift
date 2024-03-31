//
//  CartView.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 18.01.2024.
//

import SwiftUI


struct CartView: View {
    @StateObject var viewModel: CartViewModel
    @Binding var numberOfDishes: Int

    @State private var isAlertPresented = false
    @State private var isAddressEmpty = false
    @State private var isNameOrPhoneEmpty = false

    @State private var deliveryPicker = 0
    @State private var countOfPeople = 1
    @State private var address = "  "
    @State private var addressField = ""
    @State private var clientName = ""
    @State private var clientPhone = ""

    @State private var selectedTime = Date()

    var body: some View {
        
        VStack {
            Text("Cart").font(.title)  .fontWeight(.bold)
                .padding()
            
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions {
                        Button {
                            viewModel.positions.removeAll() {
                                pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("Delete")
                        }.tint(.red)
                    }
            }.listStyle(.plain)
                .onChange(of: viewModel.positions.count) {  newValue in
                    
                    viewModel.countOfPositions = viewModel.positions.count
                    numberOfDishes = viewModel.countOfPositions
                }
                .onAppear() {
                    numberOfDishes = viewModel.countOfPositions
                   
                    // Витягую дані по користувачу
                    
                    DatabaseService.shared.getProfile(by: AuthService.shared.currentUser!.uid) { result in
                        switch result {
                        case .success(let res):
                            addressField =  res.address
                            clientName = res.name
                            clientPhone = res.phone
                            
                        case .failure(let error):
                            print("ПОМИЛКА НА ОТРИМАННІ ДЕФОЛТНОЇ АДРЕСИ")
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                    
                }
            
            if viewModel.positions.count > 0 {
                Picker("Delivery", selection: $deliveryPicker) {
                    
                    Text("Book a table").tag(1)
                    Text("Pick up").tag(2)
                    Text("Delivery").tag(3)
                    
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                .onChange(of: deliveryPicker) {  newValue in
                    switch deliveryPicker {
                    case 1:
                        address = "Thank you! We will book a table for \(countOfPeople) person"
                    case 2:
                        address = "Pick up"
                    case 3:
                        address = "Delivery to address: \(addressField)"
                    default:
                        address = "Error, delivery not chosen"
                    }
                }
                
                switch deliveryPicker {
                case 1:
                    HStack {
                        Stepper("For how many person?     " + "\(self.countOfPeople)", value: $countOfPeople, in: 1...50)
                            .onChange(of: countOfPeople) {  newValue in
                                address = "Book a table for \(countOfPeople)"
                            }
                    }.padding(.horizontal).font(.subheadline.bold())
                    
                    Text("We will book a table for \(countOfPeople) person")
                case 2:
                    Text("We will prepare your order for pick up from our restaurant")
                        .lineLimit(nil)
                        .padding()
                case 3:
                    HStack {
                        TextField("Write your address here", text: $addressField)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                          /*  .onAppear() {
                                DatabaseService.shared.getProfile(by: AuthService.shared.currentUser!.uid) { result in
                                    switch result {
                                    case .success(let res):
                                        addressField =  res.address
                                    case .failure(let error):
                                        print("ПОМИЛКА НА ОТРИМАННІ ДЕФОЛТНОЇ АДРЕСИ")
                                        print(error.localizedDescription)
                                    }
                                }
                            } */
                            .onChange(of: addressField) {  newValue in
                                address = "We will deliver to address: \(addressField)"
                            }
                        
                        
                    }.padding()
                    
                default:
                    Text("Please  choose how you would like to get your order")
                        .lineLimit(nil)

                }
                
              /*  DatePicker(selection: $selectedTime, in: Date()..., displayedComponents: .hourAndMinute) {
                    Text("Please select time").padding()
                }
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
                .onAppear {
                    UIDatePicker.appearance().minuteInterval = 15
                    
                    let minuteInterval = 15
                    let calendar = Calendar.current
                    let currentMinute = calendar.component(.minute, from: selectedTime)
                    let roundedMinute = (currentMinute / minuteInterval) * minuteInterval
                    let roundedDate = calendar.date(bySetting: .minute, value: roundedMinute, of: selectedTime)!
                    selectedTime = roundedDate
                */
                let currentDate = Date()
                let calendar = Calendar.current
                let currentDatePlus30Minutes = calendar.date(byAdding: .minute, value: 30, to: currentDate)!
                let closingTime = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: currentDate)!

                DatePicker(selection: $selectedTime, in: currentDatePlus30Minutes...closingTime, displayedComponents: .hourAndMinute) {
                    Text("Please select time").padding()
                }
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
                .onAppear {
                    UIDatePicker.appearance().minuteInterval = 15
                    
                    let minuteInterval = 15
                    let currentMinute = calendar.component(.minute, from: selectedTime)
                    let roundedMinute = (currentMinute / minuteInterval) * minuteInterval
                    let roundedDate = calendar.date(bySetting: .minute, value: roundedMinute, of: selectedTime)!
                    selectedTime = roundedDate
                }


                    
                    
            }
            
               
        
            HStack{
                Text("Total: ").fontWeight(.bold)
                Spacer()
                Text(stringPrice(price:self.viewModel.cost)).fontWeight(.bold)
            }.padding()
            
            if viewModel.positions.count > 0 && deliveryPicker > 0 {
                HStack(spacing: 25) {
                    Button(action: {
                        viewModel.positions.removeAll()
                   
                    }, label: {
                        Text("Clear")
                    }).padding()
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .cornerRadius(12)
                        .padding(8)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                     /*   DatabaseService.shared.getProfile(by: AuthService.shared.currentUser!.uid) { result in
                            switch result {
                            case .success(let res):
                                clientName = res.name
                                clientPhone =  res.phone
                            case .failure(let error):
                                print("ПОМИЛКА НА ОТРИМАННІ ДЕФОЛТНОГО IМʼЯ та НОМЕРА ТЕЛЕФОНУ")
                                print(error.localizedDescription)
                            }
                        } */
                    
                        if clientName.count < 2 || clientPhone.count < 6 {
                            isNameOrPhoneEmpty.toggle()
                        } else {
                            
                            if deliveryPicker == 3 && addressField.count < 5 {
                                self.isAddressEmpty.toggle()
                            } else {
                                
                                isAlertPresented.toggle()
                                print("ЗНАЧЕНИЕ isAlertPresented \(isAlertPresented) ")
                                var order = Order(userID: AuthService.shared.currentUser!.uid, date: Date(), status: OrderStatus.new.rawValue, address: address, dateToGet: selectedTime)
                                order.positions = self.viewModel.positions
                                
                                
                                DatabaseService.shared.setOrder(order: order) { result in
                                    switch result{
                                    case .success(let order):
                                        print(order.cost)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                viewModel.positions.removeAll()
                            }
                            
                        }
                    }, label: {
                        
                        CustomButton(text: "Accept", opacity: 1.0)
                    })
                    
                    
                    
                    
                }.padding()
            }
            
            
            
        }                  .navigationTitle("Cart")

            .alert(
                     "Thank you",
                     isPresented: $isAlertPresented,
                     actions: {
                         Button("OK") {}
                     },
                     message: {
                         Text("Order was accepted")
                     }
                 )
                 .alert(
                     "Address is undefined",
                     isPresented: $isAddressEmpty,
                     actions: {
                         Button("Close") {}
                     },
                     message: {
                         Text("Please let us know the shipping address")
                     }
                 )
                 .alert(
                     "Your name ot phone number is undefined, please fill in the Account page",
                     isPresented: $isNameOrPhoneEmpty,
                     actions: {
                         Button("Close") {}
                     },
                     message: {
                         Text("Please let us know your name and phone number")
                     }
                 )
    }
}

  #Preview {
     CartView(viewModel: CartViewModel.shared, numberOfDishes:  .constant(0))
}
