package util

import (
	"log"
)

// Version information.
var (
	ReleaseVersion = "None"
	BuildTS        = "None"
	GitHash        = "None"
	GitBranch      = "None"
	GitLog         = "None"
	GolangVersion  = "None"
	ConfigFile     = "None"
)

// PrintVersionInfo prints the server version info
func PrintVersionInfo() {
	log.Println("Welcome")
	log.Println("Release Version: ", ReleaseVersion)
	log.Println("Git Commit Hash: ", GitHash)
	log.Println("Git Commit Log: ", GitLog)
	log.Println("Git Branch: ", GitBranch)
	log.Println("UTC Build Time:  ", BuildTS)
	log.Println("Golang compiler Version: ", GolangVersion)
}
