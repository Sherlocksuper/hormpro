import DataModel, { TargetBean } from '../Model/DataModel'

import { ProgressBar } from './ProgressBar'

@Component
export default struct TargetListItem {
  private targetItem: TargetBean
  private index: number
  @Prop isEdited: boolean
  @Link deleteTargetArray: Array<boolean>
  @Link selectItemIndex: number
  @State progress: number = 0

  aboutToAppear() {
    this.progress = this.targetItem.progress
  }

  build() {
    Column() {
      Row() {
        Text(this.targetItem.name)
        Blank()
        Column() {
          Text(this.progress + '%')
          Text(this.targetItem.date.toDateString()).fontSize(12)
        }

        if (this.isEdited) {
          Checkbox().select(this.deleteTargetArray[this.index]).onChange((value) => {
            this.deleteTargetArray[this.index] = value
          })
        }
      }.justifyContent(FlexAlign.SpaceBetween).width('100%')

      if (this.index == this.selectItemIndex) {
        ProgressBar({
          onCancel: () => {
            this.selectItemIndex = -1
          },
          onConfirm: (nowProgress: number) => {
            DataModel.updateProgress(this.index, nowProgress)
            this.progress = nowProgress
            this.selectItemIndex = -1
          }
        })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height(this.index == this.selectItemIndex ? $r('app.float.item_expended_height') : $r('app.float.item_normal_height'))
    .borderRadius(20)
    .padding({
      left: $r('app.float.list_padding'),
      top: $r('app.float.list_padding_top'),
      bottom: $r('app.float.list_padding_bottom'),
      right: $r('app.float.list_padding'),
    })
    .backgroundColor(Color.White)
    .animation({ duration: 300 })
  }
}