Swift 实现
  'git@github.com:stephenwzl/eleme_pulltorefresh.git'
  
  基本原理: 1 给 UIScrollView 添加一个 UIImageView(使用分类中添加属性的方法)
           2 使用 KVO 监听 ScrollView.contentOffset 的变化, 定义不同的距离和状态, 重写状态的 setter 方法, 实现不同的切换.
