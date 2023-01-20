package utils

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
)

func Merge(rootDir, path, outputName string) (err error) {
	log.Println("\nMerging to .mp4: " + path + "\n")

	err = NavigateBasepath(rootDir)

	if err != nil {
		return err
	}

	dir := "assets/" + path

	// Get .m3u8 File
	f, err := os.Open(dir)
	if err != nil {
		return err
	}

	files, err := f.Readdir(0)

	if err != nil {
		return err
	}

	cmdFile := ""

	for _, v := range files {
		filename := v.Name()

		if strings.Contains(filename, "av.m3u8") {
			cmdFile = filename
		}
	}

	if cmdFile == "" {
		return fmt.Errorf("command file not found in directory (av.m3u8)")
	}

	// Generate Merge Command

	err = NavigateAssets(rootDir, path)

	if err != nil {
		return err
	}

	mergeCmd := `ffmpeg -i {file} -vcodec copy -acodec copy -absf aac_adtstoasc {out}.mp4`

	mergeCmd = strings.ReplaceAll(mergeCmd, "{file}", cmdFile)
	mergeCmd = strings.ReplaceAll(mergeCmd, "{out}", outputName)

	// Merge files

	cmdComponents := strings.Split(mergeCmd, " ")

	cmd := exec.Command(cmdComponents[0], cmdComponents[1:]...)

	_, err = cmd.Output()

	if err != nil {
		return err
	}

	return nil
}

func GenerateThumbnail(rootDir, path, filename, thumbnailName string) (err error) {
	log.Println("\nGenerating thumbnail: " + path + "\n")

	err = NavigateAssets(rootDir, path)

	if err != nil {
		return err
	}

	mergeCmd := `ffmpeg -i {file}.mp4 -frames:v 1 {thumbnail}.png`

	mergeCmd = strings.ReplaceAll(mergeCmd, "{file}", filename)
	mergeCmd = strings.ReplaceAll(mergeCmd, "{thumbnail}", thumbnailName)

	// Merge files

	cmdComponents := strings.Split(mergeCmd, " ")

	cmd := exec.Command(cmdComponents[0], cmdComponents[1:]...)

	_, err = cmd.Output()

	if err != nil {
		return err
	}

	return nil
}

func AddWatermark(rootDir, path, sourceFilename, filename string) (err error) {
	log.Println("\nAdding watermark: " + path + "\n")

	err = NavigateAssets(rootDir, path)

	if err != nil {
		return err
	}

	mergeCmd := `ffmpeg -i {file}.mp4 -i ../watermark.png -filter_complex overlay=0:0 {out}.mp4`

	mergeCmd = strings.ReplaceAll(mergeCmd, "{file}", sourceFilename)
	mergeCmd = strings.ReplaceAll(mergeCmd, "{out}", filename)

	// Merge files

	cmdComponents := strings.Split(mergeCmd, " ")

	cmd := exec.Command(cmdComponents[0], cmdComponents[1:]...)

	_, err = cmd.Output()

	if err != nil {
		return err
	}

	return nil
}
