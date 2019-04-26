package main

import (
	"flag"

	"./util" // TODO 将这个目录更改为项目的绝对路径
)

func main() {
	var showVersion bool

	flag.BoolVar(&showVersion, "v", false, "show version")
	flag.Parse()

	if showVersion {
		util.PrintVersionInfo()
		return
	}

	// TODO 添加项目代码
}
