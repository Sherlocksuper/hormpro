import promptAction from '@ohos.promptAction'
import DataModel, { TargetBean } from '../Model/DataModel'
import { AddTargetDialog } from './AddTargetDialog'
import TargetListItem from './TargetListItem'

@Component
export default struct TargetLists {
  @State targetList: Array<TargetBean> = DataModel.getTargetList()
  @State isEdited: boolean = false
  @State deleteTargetArray: Array<boolean> = []
  @State selectItemIndex: number = -1
  dialogController: CustomDialogController = new CustomDialogController(
    {
      builder: AddTargetDialog({
        onConfirm: (name: string) => this.addNewTask(name)
      }),
      alignment: DialogAlignment.Bottom,
      offset: { dx: 0, dy: -20 }
    },
  )

  build() {
    Column() {
      this.titleBar()

      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.targetList, (item, index) => {
          ListItem() {
            TargetListItem({
              targetItem: item,
              index: index,
              isEdited: this.isEdited,
              deleteTargetArray: $deleteTargetArray,
              selectItemIndex: $selectItemIndex,
            }).onClick(() => {
              this.selectItemIndex = index
            })
          }
        })
      }.width('100%').margin({ top: 10 }).height('85%')

      Button("添加子目标").onClick(() => {
        this.dialogController.open()
      })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  titleBar() {
    Row() {
      if (!this.isEdited) {
        Text("编辑").onClick(() => {
          this.isEdited = true;
        })
      } else {
        Text("取消").onClick(() => {
          this.isEdited = false;
        })
        Blank()
        Text("全选").margin({ right: 10 }).onClick(() => {
          this.changeSelectAllAndCancel()
        })
        Text("删除").onClick(() => {
          this.deleteSelectTarget(this.deleteTargetArray)
        })
      }
    }.justifyContent(FlexAlign.End).width('100%').padding(10)
  }

  addNewTask(name: string) {
    if (name == "") {
      promptAction.showToast({
        message: "任务名称不可为空",
        duration: 3000
      })
    }

    DataModel.addTarget(new TargetBean(name, 0))
    this.targetList = DataModel.getTargetList()
    console.log(this.targetList.length.toString())
  }

  changeSelectAllAndCancel() {
    for (let i = 0; i < this.targetList.length; i++) {
      this.deleteTargetArray[i] = true
    }
    console.log("全选成功")
  }

  deleteSelectTarget(selectArray: Array<boolean>) {
    DataModel.deleteTarget(this.deleteTargetArray)
    this.targetList = DataModel.getTargetList()
    this.deleteTargetArray = []
  }
}

