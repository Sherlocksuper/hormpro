import DataModel, { TargetBean } from '../Model/DataModel'
import TargetLists from '../Module/TargetsList'

@Entry
@Component
@Preview
struct Index {
  build() {
    Column() {
      TargetLists()
    }
    .height('100%')
    .width("100%")
    .backgroundColor('#f1f2f5')
    .padding(10)
  }
}