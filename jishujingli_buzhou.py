#!/bin/python
# -*- coding: utf-8 -*-

#import sys
#reload(sys)
#sys.setdefaultencoding('utf8')

import newticket

options = {}
options["reporter"] = "chenyang"
options["owner"] = "chenyang"
options["type"] = "task"
options["description"] = ""
options["cc"] = "masol, chenyang"

# 2. 前期准备
step2_name = "2. 前期准备"
step2_list = [
  "填写项目交接表",
  "[如果] 存在疑问，问相关同事",
  "获得项目的外网证书",
  "创建项目总贴，和页面对应的帖子",
  "[如果] 页面存在复用view，将帖子转给产品",
  "[如果] 需要module支持，在信息结构图中添加module",
  "与产品经理沟通，然后修改信息结构图",
  "在项目中添加module"
]

# DEBUG_START
step2_name = "2. 大步骤"
step2_list = [
  "步骤1",
  "步骤2",
  "步骤3"
]
options["cc"] = "chenyang, chenyang"
# DEBUG_END

print("- %s" % step2_name)

for step_name in step2_list:
  options["summary"] = "[wware] " + step_name
  ret = newticket.run(options)
  if ret["status"] is 0:
    print(" - #%s %s" % (ret["id"], step_name))
