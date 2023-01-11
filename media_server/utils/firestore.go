package utils

import (
	"context"
	"fmt"
	"os"

	"cloud.google.com/go/firestore"
)

func UploadChanges(collection, id, path string) (err error) {
	projId, ok := os.LookupEnv("PROJECT_ID")

	if !ok {
		return fmt.Errorf("unable to load project id from env vars")
	}

	// Load firestore client
	ctx := context.Background()
	client, err := firestore.NewClient(ctx, projId)

	if err != nil {
		return err
	}

	// Open Collection & Update Values

	incident := client.Doc(collection + "/" + id)

	// ⬇️ Processed Footage
	_, err = incident.Update(ctx, []firestore.Update{{Path: "processed_footage", Value: true}})

	if err != nil {
		fmt.Println(err.Error())
		return err
	}

	// ⬇️ Path
	_, err = incident.Update(ctx, []firestore.Update{{Path: "path", Value: path}})

	if err != nil {
		fmt.Println(err.Error())
		return err
	}

	// ⬇️ Thumbnail
	_, err = incident.Update(ctx, []firestore.Update{{Path: "thumbnail", Value: path + "/raw/thumbnail.png"}})

	if err != nil {
		fmt.Println(err.Error())
		return err
	}

	return nil
}
