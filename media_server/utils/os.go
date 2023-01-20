package utils

import (
	"os"
	"path/filepath"
	"runtime"
	"strings"
)

func CreateDirectory(rootDir, path string) error {
	var err error

	err = NavigateAssets(rootDir, "")

	if err != nil {
		return err
	}

	err = os.Mkdir(path, os.ModePerm)

	if err != nil {
		return err
	}

	return nil
}

func TerminateDirectory(rootDir, path string) error {
	var err error

	err = NavigateAssets(rootDir, "")

	if err != nil {
		return err
	}

	err = os.RemoveAll(path)

	if err != nil {
		return err
	}

	return nil
}

func GetBasepath(rootDir string) string {
	var (
		_, b, _, _ = runtime.Caller(0)
		basepath   = filepath.Dir(b)
	)

	pathComponents := strings.Split(basepath, "/")

	if pathComponents[len(pathComponents)-1] == rootDir {
		return basepath
	}

	newBasepath := ""

	for _, v := range pathComponents {
		if v != "" {
			newBasepath += "/" + v
		}

		if v == rootDir {
			break
		}
	}

	return newBasepath

}

func NavigateBasepath(rootDir string) (err error) {

	return os.Chdir(GetBasepath(rootDir))
}

func NavigateAssets(rootDir, path string) (err error) {
	dir := GetBasepath(rootDir) + "/assets/" + path

	return os.Chdir(dir)
}
