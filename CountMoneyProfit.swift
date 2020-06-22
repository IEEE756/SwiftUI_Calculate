//
//  CountMoneyProfit.swift
//  TestSwiftUI
//
//  Created by Li Renfu on 2020/6/22.
//  Copyright © 2020 Scann. All rights reserved.
//

/**
 金融产品，制作计算存款利息的界面
 */
import SwiftUI

struct CountMoneyProfit: View {
    
    @State var isPop = false
    @State var isAnimation = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color.init(red: 243/255, green: 243/255, blue: 243/255))
                .edgesIgnoringSafeArea(.all)
            VStack{
                TopView()
                    .opacity(isAnimation ? 1 :0)
                    .animation(Animation.easeInOut.delay(0))
                
                TextView()
                    .opacity(isAnimation ? 1 :0)
                    .animation(Animation.easeInOut.delay(0.2))
                Spacer()
                
                TimeMonthView()
                .opacity(isAnimation ? 1 :0)
                .animation(Animation.easeInOut.delay(0.4))
                Spacer()
                
                MonthYearView()
                .opacity(isAnimation ? 1 :0)
                .animation(Animation.easeInOut.delay(0.6))
                Spacer()
                
                Button(action: {
                    self.isPop = true
                }) {
                    Text("计算")
                    .bold()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                        
                }.offset(x:0,y:isAnimation ? 0 :200)
                    .animation(Animation.interpolatingSpring(stiffness: 100, damping: 10).delay(1.0))
                    
                Spacer()
                
            }
            .padding(.leading,20)
            .padding(.trailing,20)
            .blur(radius: isPop ? 20 :0)
            .animation(.spring())
            
            //最外层
            if(isPop){
                PopWindow(isPopup: $isPop)
            }
            
        }.onAppear{
            self.isAnimation = true
        }
    }
}

struct CountMoneyProfit_Previews: PreviewProvider {
    static var previews: some View {
        CountMoneyProfit()
    }
}

struct TopView: View {
    var body: some View {
        HStack{
            Image(systemName: "list.bullet.indent")
            Spacer()
            Text("存款计算器")
                .bold()
                .font(.system(size:20))
                .padding(.bottom,15)
                .padding(.top,10)
            Spacer()
            Image(systemName: "calendar")
        }
    }
}

struct TextView: View {
    @State var depositAmount = ""

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .frame(height:UIScreen.main.bounds.height * 0.18)
            
            VStack(alignment: .leading) {
                Text("充值金额").font(.system(size:14))
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .stroke( lineWidth: 1)
                            .fill(Color.black.opacity(0.1))
                            .frame(height:70)
                        
                        TextField("20,000", text: $depositAmount)
                            .padding(.leading,20)
                            .font(.system(size:24))
                    }
                    Text("$").bold()
                        .padding(.leading,20)
                        .font(.system(size:28))
                    
                    Image(systemName: "chevron.down")
                        .padding(.trailing,20)
                }
            }.padding()
        }
    }
}

struct TimeBoxView: View {
    var title = 3
    var isActive = false
    private let boxSize = (UIScreen.main.bounds.width - 40 - 15*4 )/5
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(isActive ? Color.red : Color.white)
                .frame(width: boxSize, height: boxSize)
                
            Text("\(title)")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(isActive ?Color.white: Color.black)
        }
    }
}

struct TimeMonthView: View {
    
    @State var isAnimation = false

    var body: some View {
        VStack{
            HStack{
                Text("期限")
                Spacer()
                Text("月份")
            }
            HStack(spacing : 15){
                TimeBoxView()
                    .offset(x:isAnimation ? 0: UIScreen.main.bounds.width,y:0)
                    .animation(Animation.spring().delay(0.4))
                
                TimeBoxView(title: 6, isActive: false)
                .offset(x:isAnimation ? 0: UIScreen.main.bounds.width,y:0)
                                   .animation(Animation.spring().delay(0.5))
                
                TimeBoxView(title: 12, isActive: true)
                .offset(x:isAnimation ? 0: UIScreen.main.bounds.width,y:0)
                                   .animation(Animation.spring().delay(0.6))
                
                TimeBoxView(title: 18, isActive: false)
                .offset(x:isAnimation ? 0: UIScreen.main.bounds.width,y:0)
                                   .animation(Animation.spring().delay(0.7))
                
                TimeBoxView(title: 24, isActive: false)
                .offset(x:isAnimation ? 0: UIScreen.main.bounds.width,y:0)
                                   .animation(Animation.spring().delay(0.8))
            }
        }.onAppear {
            self.isAnimation.toggle()
        }
    }
}

struct Payment: View {

    var bgColor = Color.red
    var percent = "12.8%"
    var subTitle = "按月"
    private let boxWidth = (UIScreen.main.bounds.width - 40 - 15)/2
    var body: some View {
        ZStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 15)
            .fill(bgColor)
            .frame(width: boxWidth)
            
            VStack(alignment:.leading){
                Image(systemName: subTitle == "按年" ? "calendar" : "timer")
                    .font(.system(size: 40))
                    .padding(.bottom,20)
                    .foregroundColor(subTitle == "按年" ? .black : .white)
                
                Text(percent)
                    .bold()
                    .font(.system(size: 24))
                
                Text(subTitle)
                    .bold()
                    .font(.system(size: 12))
            }.foregroundColor(subTitle == "按年" ? .black : .white)
                .padding(.leading,20)
        }
    }
}

struct MonthYearView: View {
    
    @State var isAnimation = false
    
    var body: some View {
        VStack{
            
            HStack{
                Text("支付的利息")
                Spacer()
            }
            HStack{
                Payment()
                    .offset(x:isAnimation ? 0 : UIScreen.main.bounds.width * -1,y : 0)
                    .animation(Animation.spring().delay(0.8))
                
                Payment(bgColor: Color.white, percent: "8.5", subTitle: "按年")
                .offset(x:isAnimation ? 0 : UIScreen.main.bounds.width * -1,y : 0)
                .animation(Animation.spring().delay(0.8))
                               
            }.frame(height: UIScreen.main.bounds.height * 0.25)
        }.onAppear {
            self.isAnimation.toggle()
        }
    }
}


struct PopWindow : View{
    
    @Binding var isPopup : Bool
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.init(red: 243/255, green: 243/255, blue: 243/255))
                .edgesIgnoringSafeArea(.all)
                .brightness(0.9)
                .opacity(isPopup ? 0.6 : 0)
                .animation(.spring())
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(height: 500)
                VStack{
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack{
                            Spacer()
                            Image(systemName: "multiply")
                                .font(.system(size: 28))
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    self.isPopup.toggle()
                            }
                        }.frame(width: UIScreen.main.bounds.width * 0.7)
                        Image(systemName: "bitcoinsign.circle")
                            .font(.system(size: 48))
                            .foregroundColor(.orange)
                            .padding(.bottom,30)
                        
                        Text("计算完成").font(.system(size: 32))
                        Text("感谢使用\n合同已发送到您的邮箱")
                            .font(.system(size: 18))
                            .lineSpacing(8)
                            .padding(.top,40)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            self.isPopup.toggle()
                        }) {
                            Text("感谢")
                                .bold()
                                .frame(width: UIScreen.main.bounds.width * 0.7,height: 60)
                                .background(Color.red)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }.padding(.top,60)
                        Spacer()
                    }
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width * 0.7)
            }.padding(20)
                .offset(x:0,y:isPopup ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}
