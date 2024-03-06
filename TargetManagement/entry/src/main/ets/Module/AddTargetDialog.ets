@CustomDialog
export struct AddTargetDialog {
  controller: CustomDialogController
  @State newTargetName: string = ''
  onConfirm: (name: string) => void

  build() {
    Column() {
      Text("tap your target's name")
      TextInput({ placeholder: "name", text: this.newTargetName })
        .onChange((value: string) => {
          this.newTargetName = value
        })
      Row() {
        Button("confirm").onClick(() => {
          this.onConfirm(this.newTargetName)
          this.controller.close()
        })
        Button("cancel").onClick(() => {
          this.controller.close()
        })
      }.justifyContent(FlexAlign.Center)
    }.padding(10)
  }
}