package handlers

import (
	"log"
	"media-server/utils"

	"github.com/gin-gonic/gin"
)

// func StopRecording(c *gin.Context) {
// 	log.Printf("\n\nStop Recording:\n")

// 	channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId, cred := utils.ParseStopParams(c)

// 	if !utils.Validate(cred) {
// 		c.AbortWithStatusJSON(401, gin.H{
// 			"message": "Unauthorized",
// 			"status":  401,
// 		})
// 		return
// 	}

// 	endpoint := "<appId>/cloud_recording/resourceid/<resourceId>/sid/<sid>/mode/individual/stop"
// 	body := `
// 	{
// 		"cname": "<channelName>",
// 		"uid": "<recordingId>",
// 		"clientRequest":{}
// 	}
// 	`

// 	endpoint = strings.ReplaceAll(endpoint, "<appId>", appId)
// 	endpoint = strings.ReplaceAll(endpoint, "<resourceId>", resourceId)
// 	endpoint = strings.ReplaceAll(endpoint, "<sid>", sid)
// 	body = strings.ReplaceAll(body, "<channelName>", channelName)
// 	body = strings.ReplaceAll(body, "<recordingId>", recordingId)

// 	res, statusCode, err := utils.Request(customerKey, customerSecret, endpoint, body)

// 	if err != nil {
// 		log.Println(err) // Failed to stop recording
// 		c.Error(err)
// 		errMsg := "Error stopping session recording - " + err.Error()
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	if statusCode != 200 {
// 		log.Println("Response was not successful - returned ", statusCode) // Failed to stop recording
// 		errMsg := "Response was not successful - returned " + strconv.Itoa(statusCode)
// 		c.AbortWithStatusJSON(statusCode, gin.H{
// 			"status":   statusCode,
// 			"error":    errMsg,
// 			"response": string(res),
// 		})

// 		return
// 	}

// 	checkValid := json.Valid(res)

// 	if !checkValid {
// 		errMsg := "Error stopping session recording - Invalid JSON"
// 		log.Println(errMsg) // token failed to generate
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	var decoded models.StopResponse

// 	json.Unmarshal(res, &decoded)

// 	if err != nil {
// 		log.Println(err) // Failed to stop recording
// 		c.Error(err)
// 		errMsg := "Error stopping session recording - " + err.Error()
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	c.JSON(200, gin.H{
// 		"resource_id":      decoded.ResourceID,
// 		"sid":              decoded.SID,
// 		"uploading_status": decoded.Response.UploadingStatus,
// 		"filename":         decoded.Response.Files[0].Filename,
// 		"slice_start_time": decoded.Response.Files[0].SliceStartTime,
// 	})
// }

// func GetResourceID(c *gin.Context) {
// 	log.Printf("\n\nResource ID:\n")

// 	// Get Parameters
// 	channelName, customerKey, customerSecret, appId, recordingId, cred := utils.ParseRidParams(c)

// 	if !utils.Validate(cred) {
// 		c.AbortWithStatusJSON(401, gin.H{
// 			"message": "Unauthorized",
// 			"status":  401,
// 		})
// 		return
// 	}

// 	endpoint := "<appId>/cloud_recording/acquire"
// 	body := `
// 	{
// 		"cname": "<channelName>",
// 		"uid": "<recordingId>",
// 		"clientRequest":{
// 		  "resourceExpiredHour": 24,
// 		  "scene": 0
// 	   }
// 	  }
// 	`

// 	body = strings.ReplaceAll(body, `<channelName>`, channelName)
// 	body = strings.ReplaceAll(body, `<recordingId>`, recordingId)
// 	endpoint = strings.ReplaceAll(endpoint, `<appId>`, appId)

// 	res, statusCode, err := utils.Request(customerKey, customerSecret, endpoint, body)

// 	if err != nil {
// 		log.Println(err) // token failed to generate
// 		c.Error(err)
// 		errMsg := "Error Generating RID - " + err.Error()
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	if statusCode != 200 {
// 		log.Println("Response was not successful - returned ", statusCode) // Failed to stop recording
// 		errMsg := "Response was not successful - returned " + strconv.Itoa(statusCode)
// 		c.AbortWithStatusJSON(statusCode, gin.H{
// 			"status":   statusCode,
// 			"error":    errMsg,
// 			"response": string(res),
// 		})

// 		return
// 	}

// 	checkValid := json.Valid(res)

// 	if !checkValid {
// 		errMsg := "Error Generating RID - Invalid JSON"
// 		log.Println(errMsg) // token failed to generate
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	var decoded models.ResourceId

// 	json.Unmarshal(res, &decoded)

// 	c.JSON(200, gin.H{
// 		"resource_id": decoded.ResourceID,
// 	})
// }

// func StartRecording(c *gin.Context) {
// 	log.Printf("\n\nStart Recording:\n")

// 	appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2, cred := utils.ParseStartParams(c)

// 	if !utils.Validate(cred) {
// 		c.AbortWithStatusJSON(401, gin.H{
// 			"message": "Unauthorized",
// 			"status":  401,
// 		})
// 		return
// 	}

// 	endpoint := "<appId>/cloud_recording/resourceid/<resourceId>/mode/individual/start"
// 	body := `
// 	{
// 		"cname":"<channelName>",
// 		"uid":"<recordingId>",
// 		"clientRequest":{
// 			"token": "<token>",
// 			"recordingConfig":{
// 				"channelType":1,
// 				"streamTypes":2,
// 				"streamMode": "standard",
// 				"videoStreamType": 0,
// 				"maxIdleTime":<maxIdleTime>,
// 				"subscribeAudioUids": ["<userUid>"],
// 				"subscribeVideoUids": ["<userUid>"],
// 				"subscribeUidGroup": 0
// 			},
// 			"storageConfig":{
// 				"vendor":6,
// 				"region":0,
// 				"bucket":"<bucketId>",
// 				"accessKey":"<bucketAccessKey>",
// 				"secretKey":"<bucketSecretKey>",
// 				"fileNamePrefix": [
//                 	"<dir1>",
//                 	"<dir2>"
//             	]
// 			}
// 		}
// 	}
// 	`

// 	// Replace values in template

// 	// Setup Endpoint
// 	endpoint = strings.ReplaceAll(endpoint, `<appId>`, appId)
// 	endpoint = strings.ReplaceAll(endpoint, `<resourceId>`, resourceId)

// 	// Setup Body
// 	body = strings.ReplaceAll(body, `<channelName>`, channelName)
// 	body = strings.ReplaceAll(body, `<recordingId>`, recordingId)
// 	body = strings.ReplaceAll(body, `<token>`, token)
// 	body = strings.ReplaceAll(body, `<maxIdleTime>`, maxIdleTime)
// 	body = strings.ReplaceAll(body, `<userUid>`, userUid)
// 	body = strings.ReplaceAll(body, `<bucketAccessKey>`, bucketAccessKey)
// 	body = strings.ReplaceAll(body, `<bucketId>`, bucketId)
// 	body = strings.ReplaceAll(body, `<bucketSecretKey>`, bucketSecretKey)
// 	body = strings.ReplaceAll(body, `<dir1>`, dir1)
// 	body = strings.ReplaceAll(body, `<dir2>`, dir2)

// 	res, statusCode, err := utils.Request(customerKey, customerSecret, endpoint, body)

// 	if err != nil {
// 		log.Println(err) // Failed to start recording
// 		c.Error(err)
// 		errMsg := "Error Recording Session - " + err.Error()
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	if statusCode != 200 {
// 		log.Println("Response was not successful - returned ", statusCode) // Failed to stop recording
// 		errMsg := "Response was not successful - returned " + strconv.Itoa(statusCode)
// 		c.AbortWithStatusJSON(statusCode, gin.H{
// 			"status":   statusCode,
// 			"error":    errMsg,
// 			"response": string(res),
// 		})

// 		return
// 	}

// 	checkValid := json.Valid(res)

// 	if !checkValid {
// 		errMsg := "Error Recording Session - Invalid JSON"
// 		log.Println(errMsg) // Failed to start recording
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})

// 		return
// 	}

// 	var decoded models.StartResponse

// 	json.Unmarshal(res, &decoded)

// 	c.JSON(200, gin.H{
// 		"resource_id": decoded.ResourceID,
// 		"sid":         decoded.SID,
// 	})
// }

func GetRTCToken(c *gin.Context) {
	log.Printf("\n\nRTC Token Request:\n")

	// Will handle response
	authorized := utils.AuthorizeRequest(c)

	if !authorized {
		return
	}

	body := utils.ParseRTCBody(c)

	log.Printf(body.TokenType)

}

// // OLD
// func GetRtcToken(c *gin.Context) {
// 	log.Printf("\n\nRTC Token:\n")
// 	// Get Parameters
// 	id, cert, channelName, tokentype, uidStr, cred, role, expireTimestamp, err := utils.ParseRtcParams(c)

// 	if !utils.Validate(cred) {
// 		c.AbortWithStatusJSON(401, gin.H{
// 			"message": "Unauthorized",
// 			"status":  401,
// 		})
// 		return
// 	}

// 	utils.SetEnv(id, cert)
// 	appID, appCertificate := utils.ReadEnv()

// 	if err != nil {
// 		c.Error(err)
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"message": "Error Generating RTC token: " + err.Error(),
// 			"status":  400,
// 		})
// 		return
// 	}

// 	rtcToken, tokenErr := utils.GenerateRtcToken(appID, appCertificate, channelName, uidStr, tokentype, role, expireTimestamp)

// 	if tokenErr != nil {
// 		log.Println(tokenErr) // token failed to generate
// 		c.Error(tokenErr)
// 		errMsg := "Error Generating RTC token - " + tokenErr.Error()
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"status": 400,
// 			"error":  errMsg,
// 		})
// 	} else {
// 		log.Println("RTC Token generated")
// 		c.JSON(200, gin.H{
// 			"rtcToken": rtcToken,
// 		})
// 	}
// }
