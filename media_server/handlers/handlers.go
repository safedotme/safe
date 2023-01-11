package handlers

import (
	"encoding/json"
	"log"
	"media-server/models"
	"media-server/utils"
	"os"
	"strings"

	"github.com/AgoraIO-Community/go-tokenbuilder/rtctokenbuilder"
	"github.com/gin-gonic/gin"
)

// ⬇️ START

func StartRecording(c *gin.Context) {
	log.Printf("\n\nStart Recording Request:\n")

	// Will handle response
	authorized := utils.AuthorizeRequest(c)

	if !authorized {
		return
	}

	body, err := utils.ParseStartBody(c)

	if err != nil {
		return
	}

	// Triggers Start Recording through Agora

	endpoint := "<appId>/cloud_recording/resourceid/<resourceId>/mode/individual/start"
	bodyRequest := `
	{
		"cname":"<channelName>",
		"uid":"<recordingId>",
		"clientRequest":{
			"token": "<token>",
			"recordingConfig":{
				"channelType":1,
				"streamTypes":2,
				"streamMode": "standard",
				"videoStreamType": 0,
				"maxIdleTime":<maxIdleTime>,
				"subscribeAudioUids": ["<userUid>"],
				"subscribeVideoUids": ["<userUid>"],
				"subscribeUidGroup": 0
			},
			"storageConfig":{
				"vendor":6,
				"region":0,
				"bucket":"<bucketId>",
				"accessKey":"<bucketAccessKey>",
				"secretKey":"<bucketSecretKey>",
				"fileNamePrefix": [
                	"<dir1>",
                	"<dir2>"
            	]
			}
		}
	}
	`

	// Replace values in template

	// Setup Endpoint
	endpoint = strings.ReplaceAll(endpoint, `<appId>`, body.AppID)
	endpoint = strings.ReplaceAll(endpoint, `<resourceId>`, body.ResourceID)

	// Setup Body
	bodyRequest = strings.ReplaceAll(bodyRequest, `<channelName>`, body.ChannelName)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<recordingId>`, body.RecordingID)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<token>`, body.Token)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<maxIdleTime>`, body.MaxIdleTime)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<userUid>`, body.UserID)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<bucketAccessKey>`, body.Storage.BucketAccessKey)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<bucketId>`, body.Storage.BucketID)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<bucketSecretKey>`, body.Storage.BucketSecretKey)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<dir1>`, body.Storage.Dir1)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<dir2>`, body.Storage.Dir2)

	res, code, err := utils.Request(body.CustomerKey, body.CustomerSecret, endpoint, bodyRequest)

	if err != nil {
		c.AbortWithStatusJSON(code, gin.H{
			"status":  code,
			"message": "Failed to stop recording. " + err.Error() + "\n Server Response: " + string(res),
		})

		return
	}

	// Evaluate server response

	isValid := json.Valid(res)

	if !isValid {
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Agora response was invalid. Failed  parse body.",
		})

		return
	}

	var decoded models.StartResponse

	err = json.Unmarshal(res, &decoded)

	if err != nil {
		c.AbortWithStatusJSON(code, gin.H{
			"status":  code,
			"message": "Failed to stop recording. " + err.Error(),
		})

		return
	}

	c.JSON(200, gin.H{
		"status":      200,
		"resource_id": decoded.ResourceID,
		"sid":         decoded.SID,
	})

}

// ⬇️ STOP

func StopRecording(c *gin.Context) {
	log.Printf("\n\nStop Recording Request:\n")

	// Will handle response
	authorized := utils.AuthorizeRequest(c)

	if !authorized {
		return
	}

	body, err := utils.ParseStopBody(c)

	if err != nil {
		return
	}

	// Trigger Stop Recording through Agora

	endpoint := "<appId>/cloud_recording/resourceid/<resourceId>/sid/<sid>/mode/individual/stop"
	bodyRequest := `
		{
			"cname": "<channelName>",
			"uid": "<recordingId>",
			"clientRequest":{
				"async_stop": false
			}
		}
		`

	endpoint = strings.ReplaceAll(endpoint, "<appId>", body.AppID)
	endpoint = strings.ReplaceAll(endpoint, "<resourceId>", body.ResourceID)
	endpoint = strings.ReplaceAll(endpoint, "<sid>", body.SID)
	bodyRequest = strings.ReplaceAll(bodyRequest, "<channelName>", body.ChannelName)
	bodyRequest = strings.ReplaceAll(bodyRequest, "<recordingId>", body.RecordingID)

	res, code, err := utils.Request(body.CustomerKey, body.CustomerSecret, endpoint, bodyRequest)

	if err != nil {
		message := "Failed to stop recording. " + err.Error() + "\n Server Response: " + string(res)
		utils.Log(message, body.IncidentID)
		c.AbortWithStatusJSON(code, gin.H{
			"status":  code,
			"message": message,
		})

		return
	}

	// Evaluate server response

	isValid := json.Valid(res)

	if !isValid {
		message := "Agora response was invalid. Failed  parse body."
		utils.Log(message, body.IncidentID)
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": message,
		})

		return
	}

	var decoded models.StopResponse

	err = json.Unmarshal(res, &decoded)

	if err != nil {
		message := "Failed to stop recording. " + err.Error()
		utils.Log(message, body.IncidentID)
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": message,
		})

		return
	}

	// Generates slice of maps to send in response
	files := decoded.Response.Files[:]
	var mappedFiles = []string{}

	for i := 0; i < len(files); i++ {
		mappedFiles = append(mappedFiles, files[i].Filename)
	}

	uploaded := false

	if decoded.Response.UploadingStatus == "uploaded" {
		uploaded = true
	}

	// Trigger Processing
	err = utils.Process(body.ChannelName, "output", "watermarked", "thumbnail", body.BucketID)

	if err != nil {
		// Terminates directory either way
		rootDir, ok := os.LookupEnv("MEDIA_ROOTDIR")

		if !ok {
			message := "Failed to process footage. unable to load root directory env. env not found"
			utils.Log(message, body.IncidentID)
			c.AbortWithStatusJSON(400, gin.H{
				"status":  400,
				"message": message,
			})

			return
		}

		utils.TerminateDirectory(rootDir, body.ChannelName)

		// Aborts with error
		message := "Failed to process footage. " + err.Error()
		utils.Log(message, body.IncidentID)
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": message,
		})

		return
	}

	// Update values in Firebase
	err = utils.UploadChanges(body.Collection, body.IncidentID, body.ChannelName)

	if err != nil {
		message := "Failed to update Firebase. " + err.Error()
		utils.Log(message, body.IncidentID)
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": message,
		})
	}

	c.JSON(200, gin.H{
		"status": 200,
		"response": map[string]any{
			"resource_id":      decoded.ResourceID,
			"sid":              decoded.SID,
			"uploading_status": uploaded,
			"files":            mappedFiles,
			"processed":        true,
		},
	})
}

// ⬇️ RTC
func GetRTCToken(c *gin.Context) {
	log.Printf("\n\nRTC Token Request:\n")

	// Will handle response
	authorized := utils.AuthorizeRequest(c)

	if !authorized {
		return
	}

	body, err := utils.ParseRTCBody(c)

	if err != nil {
		return
	}

	var role rtctokenbuilder.Role

	if body.Role == "publisher" {
		role = rtctokenbuilder.RolePublisher
	} else {
		role = rtctokenbuilder.RoleSubscriber
	}

	timestamp, err := utils.GetExpireTimestamp(c.DefaultQuery("expiry", "3600"))

	if err != nil {
		// Handle err
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to generate timestamp. " + err.Error(),
		})

		return
	}

	// Generates token
	token, err := utils.GenerateRtcToken(body.AppID, body.AppCertificate, body.ChannelName, body.UserID, body.TokenType, role, timestamp)

	if err != nil {
		// Handle err
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to generate token. " + err.Error(),
		})

		return
	}

	// Request succeeded
	c.JSON(200, gin.H{
		"status": 200,
		"token":  token,
	})
}

// ⬇️ RID

func GetResourceID(c *gin.Context) {
	log.Printf("\n\nResource ID Request:\n")

	// Will handle response
	authorized := utils.AuthorizeRequest(c)

	if !authorized {
		return
	}

	body, err := utils.ParseRIDBody(c)

	if err != nil {
		return
	}

	// Generate ResourceID through Agora

	endpoint := "<appId>/cloud_recording/acquire"
	bodyRequest := `
	{
		"cname": "<channelName>",
		"uid": "<recordingId>",
		"clientRequest":{
		  "resourceExpiredHour": 24,
		  "scene": 0
	   }
	}
	`

	bodyRequest = strings.ReplaceAll(bodyRequest, `<channelName>`, body.ChannelName)
	bodyRequest = strings.ReplaceAll(bodyRequest, `<recordingId>`, body.RecordingID)
	endpoint = strings.ReplaceAll(endpoint, `<appId>`, body.AppID)

	res, code, err := utils.Request(body.CustomerKey, body.CustomerSecret, endpoint, bodyRequest)

	if err != nil {
		c.AbortWithStatusJSON(code, gin.H{
			"status":  code,
			"message": "Failed to generate ResourceID. " + err.Error() + "\n Server Response: " + string(res),
		})

		return
	}

	// Evaluate server response

	isValid := json.Valid(res)

	if !isValid {
		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Agora response was invalid. Failed  parse body.",
		})

		return
	}

	var decoded models.ResourceId

	err = json.Unmarshal(res, &decoded)

	if err != nil {
		c.AbortWithStatusJSON(code, gin.H{
			"status":  code,
			"message": "Failed to generate ResourceID. " + err.Error(),
		})

		return
	}

	c.JSON(200, gin.H{
		"status":      200,
		"resource_id": decoded.ResourceID,
	})
}
