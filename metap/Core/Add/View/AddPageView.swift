//
//  AddPageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct AddPageView: View {
    @State var etkinlikAdi: String = ""
    @State var etkinlikAciklamasi: String = ""
    @State var etkinlikAdresi: String = ""
    @State var kacSaatIcinde: Int = 1
    @State var kacKisilik: Int = 1
    @StateObject var addVm =  AddPageViewModel()
    @State private var image: UIImage? = nil
    @State private var showSheet = false


    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            header
                .padding([.top, .horizontal])
            ZStack(alignment: .bottom) {
                ScrollView ( showsIndicators: false) {
                    
                    FieldView(isPassword: false, title: "Etkinlik Adı", bindingVar: $etkinlikAdi)
                    
                    FieldView(isPassword: false, title: "Etkinlik Adresi", bindingVar: $etkinlikAdresi)

                    TextEditorView(title: "Etkinlik Açıklaması", gelen: $etkinlikAciklamasi)
                    
                    pickerView(title: "Etkinlik Kaç Saat İçinde Olacak? ", bind: $kacSaatIcinde)
                    pickerView(title: "Etkinlik Kaç Kişilik Olacak? ", bind: $kacKisilik)
                    
                    photoAdd
                        .onTapGesture {
                            showSheet = true
                        }

                    
                }.padding()
                
                shareButton
                
            }
            .sheet(isPresented: $showSheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
        }.ignoresSafeArea()
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
            AddPageView()
    }
}


struct TextEditorView: View {
    init(title: String, gelen: Binding<String> ){
        self.title = title
        self.desc = gelen
        UITextView.appearance().backgroundColor = .clear
    }
    var title: String = ""
    var desc: Binding<String>
    var body: some View {
        GroupBox(){
            ZStack(alignment: .topLeading){
                if desc.wrappedValue == "" {
                    Text(title)
                        .foregroundColor(.secondary.opacity(0.5))
                }
                TextEditor(text: desc)
                    .frame(height:200)
                    .offset(x:-5,y:-8)
            }
        }
    }
}

extension AddPageView {
    
    func uploadClicked(){
        guard etkinlikAdi != "" && etkinlikAdresi != "" && etkinlikAciklamasi != "" && image != nil else {
            addVm.anyError.toggle()
            return
        }
        
        addVm.uploadPost(etkinlikAdi: etkinlikAdi, etkinlikAciklamasi: etkinlikAciklamasi, etkinlikAdresi: etkinlikAdresi, kacSaatIcinde: kacSaatIcinde, kacKisilik: kacKisilik, image: image!)

    }
    
    private var shareButton : some View {
        
        Button {
            self.uploadClicked()
            if !addVm.anyError{
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            HStack{
                Image(systemName: "plus")
                  
                Text("Paylaş").font(.title2)
            }
            .padding()
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
            )
            .padding(30)
            .foregroundColor(.accentColor)
            .alert(isPresented: $addVm.anyError) {
                Alert(title: Text("Hata"), message: Text("Bir şey oldu."), dismissButton: Alert.Button.default(Text("OK")))
            }
        }

        
    }
    
    private var placeholderImage: some View {
        VStack {
            if image != nil {
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .scaledToFit()



            } else {
                Image(systemName: "plus.square.on.square")
                    .resizable().scaledToFit().frame(width:200).padding().foregroundColor(.accentColor)
            }
        }

    }
    
    private var photoAdd: some View {
        GroupBox(){
            HStack{
                Image(systemName: "info").foregroundColor(.accentColor)
                Text("Etkinlik alanından bir fotoğraf ekle.")
                    .foregroundColor(.secondary.opacity(0.5))
                Spacer()
            }
            placeholderImage
                   
        }
    }
    
    private var header: some View {
        HStack{
            Text("Etkinlik Ekle")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Image(systemName: "xmark")
                .font(.title2)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
        }.padding(.vertical,10)

    }
}
