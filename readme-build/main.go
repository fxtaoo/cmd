// none
// Actions 程序，生成 [fxtaoo/cmd](https://github.com/fxtaoo/cmd) 该仓库 README.md 文件

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
)

const (
	_topPageInfo = "# cmd\n一些自写自用的命令行脚本  \nps: 墙内可使用我反向代理的 fxtaooRaw"
	_codeURL     = "https://github.com/fxtaoo/cmd/blob/master/"
	_githubRaw   = "https://raw.githubusercontent.com/fxtaoo/cmd/master/"
	_fxtaooRaw   = "https://raw.fxtaoo.dev/fxtaoo/cmd/master/"
)

type script struct {
	path      string
	name      string
	info      string
	codeUrl   string
	githubRaw string
	fxtaooRaw string
}

type scriptDir struct {
	path    string
	info    string
	content string
}

// app 从文件读 info
func (s *script) readInfo() {
	f, err := os.Open(s.path)
	if err != nil {
		log.Fatalln(s.path + " 打开失败！")
	}
	defer f.Close()
	content := bufio.NewScanner(f)

	// 第一行 #!/usr/bin/env bash 不取
	content.Scan()

	// 第二行 信息
	content.Scan()
	s.info = content.Text()[2:]
}

// app 相关信息添加 markdown 标签
func (s script) appMarkdown() string {
	return "[" + s.name + "]" + "(" + s.codeUrl + ")" + "　[githubRaw]" + "(" + s.githubRaw + ")" + " [fxtaooRaw]" + "(" + s.fxtaooRaw + ")" + "  \n" + s.info
}

// 读整个文件夹下 app 信息，并聚合
func (d *scriptDir) readApp() {
	err := filepath.Walk(d.path, func(path string, file os.FileInfo, err error) error {
		// 遍历文件
		if file.Name() != d.path && !strings.HasPrefix(path, ".") {
			// 排除隐藏文件 . ..
			var tmpApp script
			tmpApp.name = file.Name()
			tmpApp.path = path
			tmpApp.codeUrl = _codeURL + d.path + "/" + tmpApp.name
			tmpApp.githubRaw = _githubRaw + d.path + "/" + tmpApp.name
			tmpApp.githubRaw = _githubRaw + d.path + "/" + tmpApp.name

			tmpApp.readInfo()
			d.content += tmpApp.appMarkdown() + "\n\n"
		}
		return nil
	})
	if err != nil {
		panic(err)
	}
}

func initDir(d *scriptDir, path, info string) {
	d.path = path
	d.info = info
	d.content = "## " + info + "\n\n"
	d.readApp()
}

func main() {

	var appDir, funDir, installDir, otherDir, sysDir scriptDir
	initDir(&appDir, "app", "工具")
	initDir(&funDir, "func", "函数")
	initDir(&installDir, "install", "安装")
	initDir(&otherDir, "other", "其他")
	initDir(&sysDir, "sys", "系统")

	content := _topPageInfo + "\n\n"
	content += appDir.content + installDir.content + sysDir.content + funDir.content + otherDir.content

	// 写 README.md
	f, err := os.OpenFile("README.md", os.O_RDWR|os.O_CREATE, 0755)
	defer f.Close()
	_, err = f.WriteString(content)
	if err != nil {
		fmt.Println(err)
	}
}
