# 自己写的NY4的DEMO

# 版本0.1.0 -- 初版

## 特点

### 文件说明

SystemFiles里面存放着系统定义及系统文件；UserFiles存放着给用户定义的文件。

以macro命名的文件存放用户宏定义，以path命名的文件存放用户的路径处理。

SystemFiles文件夹中的keyscan.asm存放按键处理，由于可能修改可能比较多，建议将其移至UserFiles中较为合适。后续版本再进行考虑修改。

### 计时器

计时器BT使用125us，初始化宏在 SystemFiles/SystemMacro.asm 中的 M_Init 中（其中定义为125us的语句在将值0x0赋给bt，具体可查看说明文档），处理的宏在 SystemFiles/SystemMacro.asm 中的 M_Timer

系统只使用8ms计时，处理以下内容：

- 按键去抖动计时
- 睡眠计时
- 静音播放计时

留给用户使用的有 125us、2ms、4ms、8ms 计时区处理，分别对应 Block_125us、Block_2ms、Block_4ms、Block_8ms

### 寄存器

**固定寄存器**

为方便语音播放，将 0x35~0x3f 这些特殊地址固定，作为语音播放所需的寄存器。

**动态分配**

自定义宏 newR 和 NewB 用以动态分配寄存器变量和位变量

1. 寄存器变量

存储地址 0x10~0x2f ，若想修改范围，可修改 V_DynamicRam 和 V_MaxSRamAddr 即可。

2. 位变量
 
存储地址 0x30~0x34 。若想修改范围，除了修改 V_BitRam 和 V_BitRamMax 之外，还需修改 newB 中对于 V_BitRam 的 switch 判断。

### 页面

页面0作为系统页面，用以处理系统变量、声音处理及整个框架所需的变量。

页面1作为用户变量，但使用动态分配时，需认为是使用页面0分配，因为动态分配已去掉 0x35~0x3f 这些地址。（后续将进一步优化）

### 处理播放相关

1. 在项目中添加播放文件，即可在 Resource.asm 文件中添加声音文件。
2. 在 userFiles/userMacro.asm 的Block_PlayList中添加播放序列

- 播放声音
	- 只播放一次，使用格式：VoiceMake 声音文件标号,采样率
	- 播放N次，使用格式：VoiceMake@N 声音文件标号,采样率,播放次数
- 播放静音
	- 使用格式：MuteMake	静音时间
- 播放完毕
	- 使用格式：ListEnd

3. 需要播放声音时，使用格式： PlayList	播放序列标号

**注意**

采样率直接使用十进制，如8K采样率用 D'8000'；静音时间的单位是ms，例如静音1s，静音时间可用 D'1000'

