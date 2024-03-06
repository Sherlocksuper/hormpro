import DataModel from '../Model/DataModel'

@Component
export struct ProgressBar {
  private newProgress: number = 0
  onCancel?: () => void;
  onConfirm?: (nowProgress: number) => void;

  build() {
    Column() {
      Slider({
        value: this.newProgress,
        min: 0,
        max: 100,
        style: SliderStyle.OutSet
      })
        .showTips(true)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.newProgress = value
          console.info('value:' + value + 'mode:' + mode.toString())
        })
      Row() {
        Button("取消").onClick(() => {
          this.onCancel()
        })
        Blank()
        Button("确定").onClick(() => {
          this.onConfirm(this.newProgress)
        })
      }.width('80%')
    }
  }
}