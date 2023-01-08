package utils

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"media-server/models"
	"os"
)

var devPath = "media_server"
var buildPath = "build"

func LoadKey(build bool) (keys models.LocalKeys, err error) {
	// LOAD KEYS FROM JSON
	path := buildPath

	if !build {
		path = devPath
	}

	jsonFile, err := os.Open(GetBasepath(path) + "/keys.json")

	if err != nil {
		return keys, err
	}

	defer jsonFile.Close()

	bytes, err := ioutil.ReadAll(jsonFile)

	if err != nil {
		return keys, err
	}

	json.Unmarshal(bytes, &keys)

	isEmpty := ContainsEmpty(
		keys.Build.Key,
		keys.Build.RootDir,
		keys.Build.Secret,
		keys.Build.GoogleCred,
		keys.Dev.Key, keys.Dev.RootDir,
		keys.Dev.Secret,
		keys.Dev.GoogleCred,
	)

	if isEmpty {
		return keys, fmt.Errorf("keys were not initialized. one or more keys were empty")
	}
	return keys, nil
}

func SetEnv(build bool) (err error) {
	raw, err := LoadKey(build)

	if err != nil {
		return err
	}

	var keys models.EnvType

	if build {
		keys = raw.Build
	} else {
		keys = raw.Dev
	}

	os.Setenv("MEDIA_KEY", keys.Key)
	os.Setenv("MEDIA_SECRET", keys.Secret)
	os.Setenv("MEDIA_ROOTDIR", keys.RootDir)
	os.Setenv("GOOGLE_APPLICATION_CREDENTIALS", GetBasepath(keys.RootDir)+keys.GoogleCred)

	return nil
}
