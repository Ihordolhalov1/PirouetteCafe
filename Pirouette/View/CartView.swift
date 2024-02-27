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
    @State private var deliveryPicker = 0
    @State private var countOfPeople = 1
    @State private var address = "  "
    @State private var addressField = ""
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
                .onChange(of: viewModel.positions.count) {
                    
                    viewModel.countOfPositions = viewModel.positions.count
                    numberOfDishes = viewModel.countOfPositions
                }
                .onAppear() {
                    numberOfDishes = viewModel.countOfPositions

                }
            
            if viewModel.positions.count > 0 {
                Picker("Delivery", selection: $deliveryPicker) {
                    
                    Text("Book a table").tag(1)
                    Text("Pick up").tag(2)
                    Text("Delivery").tag(3)
                    
                    
                } 
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                .onChange(of: deliveryPicker) {
                    switch deliveryPicker {
                    case 1:
                        address = "Book a table for \(countOfPeople)"
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
                            .onChange(of: countOfPeople) {
                                address = "Book a table for \(countOfPeople)"
                            }
                    }.padding(.horizontal).font(.subheadline.bold())
                    
                    Text ("We will book a table for \(countOfPeople)")
                case 2:
                    Text("We will prepare your order for pick up").padding()
                case 3:
                    HStack {
                        TextField("Write your address here", text: $addressField)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onAppear() {
                                DatabaseService.shared.getProfile(by: AuthService.shared.currentUser!.uid) { result in
                                    switch result {
                                    case .success(let res):
                                        addressField =  res.address
                                    case .failure(let error):
                                        print("ПОМИЛКА НА ОТРИМАННІ ДЕФОЛТНОЇ АДРЕСИ")
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            .onChange(of: addressField) {
                                address = "We will deliver to address: \(addressField)"
                            }
                        
                        
                    }.padding()
                    
                default:
                    Text("Please  choose how you would like to get your order")
                }
                
                DatePicker(selection: $selectedTime, in: Date()..., displayedComponents: .hourAndMinute) {
                    Text("Select time").padding()
                }
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
                .onAppear {
                    UIDatePicker.appearance().minuteInterval = 10
                    
                    let minuteInterval = 10
                    let calendar = Calendar.current
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
                            isAlertPresented.toggle()
                       
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
                        
                        
                        
                    }, label: {
                        
                        CustomButton(text: "Accept", opacity: 1.0)
                    })
                    
                    
                    
                    
                }.padding()
            }
            
            
            
        }                  .navigationTitle("Cart")

                .alert(isPresented: $isAlertPresented) {
                    Alert(title: Text("Thank you"), message:
                    Text("Order was accepted")
                , dismissButton: .default(Text("OK")))
                }
    }
}

  #Preview {
     CartView(viewModel: CartViewModel.shared, numberOfDishes:  .constant(0))
}
