package utils

import (
	"context"
	"fmt"
	"io"
	"io/fs"
	"log"
	"os"
	"strings"

	"cloud.google.com/go/storage"
	"google.golang.org/api/iterator"
)

func Process(
	path,
	outputFilename,
	watermarkFilename,
	thumbnailFilename,
	bucketId string,
) error {

	// Get Root Directory
	rootDir, ok := os.LookupEnv("MEDIA_ROOTDIR")

	if !ok {
		return fmt.Errorf("unable to load root directory env. env not found")
	}

	// Initialize GCP Cloud Storage Client
	client, ctx, err := InitClient()

	if err != nil {
		return err
	}

	// Fetch objects from Cloud + Creates directory
	err = FetchObjects(bucketId, path, client, ctx)

	if err != nil {
		return fmt.Errorf("fetch objects: %v", err)
	}

	// Merge Files
	err = Merge(rootDir, path, outputFilename)

	if err != nil {
		return fmt.Errorf("merging files: %v", err)
	}

	// Generate thumbnail
	err = GenerateThumbnail(rootDir, path, outputFilename, thumbnailFilename)

	if err != nil {
		return fmt.Errorf("generating thumbnails: %v", err)
	}

	err = AddWatermark(rootDir, path, outputFilename, watermarkFilename)

	if err != nil {
		return fmt.Errorf("adding watermark: %v", err)
	}

	// Upload files to cloud + deletes directory
	err = UploadObjects(bucketId, path, client, ctx)

	if err != nil {
		return fmt.Errorf("uploading objects: %v", err)
	}

	return nil
}

func InitClient() (client *storage.Client, ctx context.Context, err error) {
	ctx = context.Background()

	// Creates a client.
	client, err = storage.NewClient(ctx)
	if err != nil {
		return client, ctx, err
	}

	defer client.Close()

	return client, ctx, nil
}

func FetchObjects(bucket, path string, client *storage.Client, ctx context.Context) error {
	var err error

	// Lists items in bucket
	var prefix = path + "/raw/"

	it := client.Bucket(bucket).Objects(ctx, &storage.Query{
		Prefix: prefix,
	})

	files := []string{}

	for {
		attrs, err := it.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return fmt.Errorf("Bucket(%q).Objects(): %v", bucket, err)
		}

		files = append(files, attrs.Name)
	}

	shouldProcess := true

	for _, file := range files {
		if strings.Contains(file, ".mp4") {
			shouldProcess = false
		}

		if strings.Contains(file, ".png") {
			shouldProcess = false
		}
	}

	if !shouldProcess {
		return fmt.Errorf("videos have already been processed")
	}

	rootDir, ok := os.LookupEnv("MEDIA_ROOTDIR")

	if !ok {
		return fmt.Errorf("unable to fetch root directory")
	}

	CreateDirectory(rootDir, path)

	for _, file := range files {
		err = DownloadFile(file, bucket, path, client, ctx)

		if err != nil {
			return err
		}
	}

	return nil

}

func RenameFile(file string) string {
	components := strings.Split(file, `/`)
	return components[len(components)-1]
}

func UploadObjects(
	bucket, path string,
	client *storage.Client,
	ctx context.Context,
) error {
	dir, ok := os.LookupEnv("MEDIA_ROOTDIR")

	if !ok {
		return fmt.Errorf("unable to load root directory though env")
	}

	f, err := os.Open(GetBasepath(dir) + "/assets/" + path)
	if err != nil {
		return err
	}

	files, err := f.Readdir(0)

	if err != nil {
		return err
	}

	uploadables := []fs.FileInfo{}

	for _, v := range files {
		filename := v.Name()

		shouldUpload := true

		if strings.Contains(filename, ".ts") {
			shouldUpload = false
		}

		if strings.Contains(filename, ".m3u8") {
			shouldUpload = false
		}

		if shouldUpload {
			uploadables = append(uploadables, v)
		}
	}

	for _, u := range uploadables {
		err = UploadFile(u, bucket, path, client, ctx)

		if err != nil {
			return err
		}
	}

	TerminateDirectory(dir, path)

	return nil
}

func UploadFile(
	file fs.FileInfo,
	bucket, path string,
	client *storage.Client,
	ctx context.Context,
) (err error) {
	log.Println("\nUploading file: ", file.Name()+"\n")

	dir, ok := os.LookupEnv("MEDIA_ROOTDIR")

	if !ok {
		return fmt.Errorf("unable to load root directory though env")
	}

	// Open local file.
	f, err := os.Open(GetBasepath(dir) + "/assets/" + path + "/" + file.Name())
	if err != nil {
		return fmt.Errorf("os.Open: %v", err)
	}
	defer f.Close()

	// Create path for image in cloud and uploads
	filePath := path + "/raw/" + file.Name()

	o := client.Bucket(bucket).Object(filePath)

	o = o.If(storage.Conditions{DoesNotExist: true})
	wc := o.NewWriter(ctx)

	// Returns error if anything goes wrong
	if _, err = io.Copy(wc, f); err != nil {
		return fmt.Errorf("io.Copy: %v", err)
	}
	if err := wc.Close(); err != nil {
		return fmt.Errorf("Writer.Close: %v", err)
	}

	if err != nil {
		log.Println(err.Error())
		return err
	}

	return nil
}

func DownloadFile(
	file, bucket, path string,
	client *storage.Client,
	ctx context.Context,
) (err error) {
	formatted := RenameFile(file)
	log.Println("\nDownloading file: ", file+"\n")

	rootDir, ok := os.LookupEnv("MEDIA_ROOTDIR")

	if !ok {
		return fmt.Errorf("unable to fetch root directory")
	}

	err = NavigateAssets(rootDir, path)

	if err != nil {
		return err
	}

	// Download file
	f, err := os.Create(formatted)

	if err != nil {
		return err
	}

	rc, err := client.Bucket(bucket).Object(file).NewReader(ctx)

	if err != nil {
		return err
	}

	defer rc.Close()

	if _, err := io.Copy(f, rc); err != nil {
		return fmt.Errorf("io.Copy: %v", err)
	}

	if err = f.Close(); err != nil {
		return fmt.Errorf("f.Close: %v", err)
	}

	return nil
}
