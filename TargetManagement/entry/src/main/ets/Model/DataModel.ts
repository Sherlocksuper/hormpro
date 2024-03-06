class DataModel {
  private targetList: Array<TargetBean> = [
    new TargetBean("haha", 0),
    new TargetBean("aha", 0),
    new TargetBean("aa", 0),
    new TargetBean("aaaa", 0),
    new TargetBean("a", 0),
    new TargetBean("a", 0),
    new TargetBean("a", 0),
    new TargetBean("a", 0),
    new TargetBean("a", 0),
    new TargetBean("a", 0),
  ]

  addTarget(target: TargetBean) {
    this.targetList.push(target)
  }

  getTargetList() {
    return this.targetList
  }

  deleteTarget(deleteArray: Array<boolean>) {
    var newTargetList: Array<TargetBean> = []
    for (let i = 0; i < this.targetList.length; i++) {
      if (deleteArray[i] != true) {
        newTargetList.push(this.targetList[i])
      }
    }
    this.targetList = newTargetList
  }

  updateProgress(index: number, progress: number) {
    this.targetList[index].progress = progress
  }
}

export class TargetBean {
  name: string
  progress: number
  date: Date

  constructor(name: string, progress: number) {
    this.name = name
    this.progress = progress
    this.date = new Date()
  }
}

export default new DataModel();