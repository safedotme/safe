package main

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/AgoraIO-Community/go-tokenbuilder/rtctokenbuilder"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

var appID string
var appCertificate string

type ResourceId struct {
	ResourceID string `json:"resourceId"`
}

type StopResponse struct {
	ResourceID string         `json:"resourceId"`
	SID        string         `json:"sid"`
	Response   ServerResponse `json:"serverResponse"`
}

type ServerResponse struct {
	UploadingStatus string     `json:"uploadingStatus"`
	Files           []FileList `json:"fileList"`
}

type FileList struct {
	Filename       string `json:"fileName"`
	SliceStartTime string `json:"sliceStartTime"`
}

type StartResponse struct {
	ResourceID string `json:"resourceId"`
	SID        string `json:"sid"`
}

func setEnv(id string, cert string) {
	os.Setenv("APP_ID", id)
	os.Setenv("APP_CERTIFICATE", cert)
	// loads values from .env into the system
	if err := godotenv.Load(); err != nil {
		log.Print("No .env file found")
	}
}

func readEnv() {
	appIDEnv, appIDExists := os.LookupEnv("APP_ID")
	appCertEnv, appCertExists := os.LookupEnv("APP_CERTIFICATE")

	if !appIDExists || !appCertExists {
		log.Fatal("FATAL ERROR: ENV not properly configured, check appID and appCertificate")
	} else {
		appID = appIDEnv
		log.Println(appID)
		appCertificate = appCertEnv
	}
}

func main() {
	api := gin.Default()

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	api.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	api.Use(nocache())
	api.GET("rtc/:channelName/:role/:tokentype/:uid/:id/:cert/", getRtcToken)
	api.GET("rid/:channelName/:customerKey/:customerSecret/:appId/:recordingId/", getResourceID)
	api.GET("start/:appId/:channelName/:recordingId/:resourceId/:customerKey/:customerSecret/:token/:maxIdleTime/:bucketId/:bucketAccessKey/:bucketSecretKey/:userUid/:dir1/:dir2/", startRecording)
	api.GET("stop/:channelName/:customerKey/:customerSecret/:appId/:recordingId/:sid/:resourceId/", stopRecording)
	api.Run(":" + port) // listen and serve on localhost:8080
}

func nocache() gin.HandlerFunc {
	return func(c *gin.Context) {
		// set headers
		c.Header("Cache-Control", "private, no-cache, no-store, must-revalidate")
		c.Header("Expires", "-1")
		c.Header("Pragma", "no-cache")
		c.Header("Access-Control-Allow-Origin", "*")
	}
}

func stopRecording(c *gin.Context) {
	log.Printf("\n\nStop Recording:\n")

	channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId := parseStopParams(c)

	endpoint := "<appId>/cloud_recording/resourceid/<resourceId>/sid/<sid>/mode/individual/stop"
	body := `
	{
		"cname": "<channelName>",
		"uid": "<recordingId>",
		"clientRequest":{}
	}
	`

	endpoint = strings.ReplaceAll(endpoint, "<appId>", appId)
	endpoint = strings.ReplaceAll(endpoint, "<resourceId>", resourceId)
	endpoint = strings.ReplaceAll(endpoint, "<sid>", sid)
	body = strings.ReplaceAll(body, "<channelName>", channelName)
	body = strings.ReplaceAll(body, "<recordingId>", recordingId)

	res, err := request(customerKey, customerSecret, endpoint, body)

	if err != nil {
		log.Println(err) // Failed to stop recording
		c.Error(err)
		errMsg := "Error stopping session recording - " + err.Error()
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	checkValid := json.Valid(res)

	if !checkValid {
		errMsg := "Error stopping session recording - Invalid JSON"
		log.Println(errMsg) // token failed to generate
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	var decoded StopResponse

	json.Unmarshal(res, &decoded)

	if err != nil {
		log.Println(err) // Failed to stop recording
		c.Error(err)
		errMsg := "Error stopping session recording - " + err.Error()
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	c.JSON(200, gin.H{
		"resource_id":      decoded.ResourceID,
		"sid":              decoded.SID,
		"uploading_status": decoded.Response.UploadingStatus,
		"filename":         decoded.Response.Files[0].Filename,
		"sliceStartTime":   decoded.Response.Files[0].SliceStartTime,
	})
}

func getResourceID(c *gin.Context) {
	log.Printf("\n\nResource ID:\n")

	// Get Parameters
	channelName, customerKey, customerSecret, appId, recordingId := parseRidParams(c)

	endpoint := "<appId>/cloud_recording/acquire"
	body := `
	{
		"cname": "<channelName>",
		"uid": "<recordingId>",
		"clientRequest":{
		  "resourceExpiredHour": 24,
		  "scene": 0
	   }
	  }
	`

	body = strings.ReplaceAll(body, `<channelName>`, channelName)
	body = strings.ReplaceAll(body, `<recordingId>`, recordingId)
	endpoint = strings.ReplaceAll(endpoint, `<appId>`, appId)

	res, err := request(customerKey, customerSecret, endpoint, body)

	if err != nil {
		log.Println(err) // token failed to generate
		c.Error(err)
		errMsg := "Error Generating RID - " + err.Error()
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	checkValid := json.Valid(res)

	if !checkValid {
		errMsg := "Error Generating RID - Invalid JSON"
		log.Println(errMsg) // token failed to generate
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	var decoded ResourceId

	json.Unmarshal(res, &decoded)

	c.JSON(200, gin.H{
		"resource_id": decoded.ResourceID,
	})
}

func startRecording(c *gin.Context) {
	log.Printf("\n\nStart Recording:\n")

	appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2 := parseStartParams(c)

	endpoint := "<appId>/cloud_recording/resourceid/<resourceId>/mode/individual/start"
	body := `
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
				"subscribeVideoUids": ["<userUid>"],
				"subscribeAudioUids": ["<userUid>"],
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
	endpoint = strings.ReplaceAll(endpoint, `<appId>`, appId)
	endpoint = strings.ReplaceAll(endpoint, `<resourceId>`, resourceId)

	// Setup Body
	body = strings.ReplaceAll(body, `<channelName>`, channelName)
	body = strings.ReplaceAll(body, `<recordingId>`, recordingId)
	body = strings.ReplaceAll(body, `<token>`, token)
	body = strings.ReplaceAll(body, `<maxIdleTime>`, maxIdleTime)
	body = strings.ReplaceAll(body, `<userUid>`, userUid)
	body = strings.ReplaceAll(body, `<bucketAccessKey>`, bucketAccessKey)
	body = strings.ReplaceAll(body, `<bucketId>`, bucketId)
	body = strings.ReplaceAll(body, `<bucketSecretKey>`, bucketSecretKey)
	body = strings.ReplaceAll(body, `<dir1>`, dir1)
	body = strings.ReplaceAll(body, `<dir2>`, dir2)

	res, err := request(customerKey, customerSecret, endpoint, body)

	if err != nil {
		log.Println(err) // Failed to start recording
		c.Error(err)
		errMsg := "Error Recording Session - " + err.Error()
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	checkValid := json.Valid(res)

	if !checkValid {
		errMsg := "Error Recording Session - Invalid JSON"
		log.Println(errMsg) // Failed to start recording
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})

		return
	}

	var decoded StartResponse

	json.Unmarshal(res, &decoded)

	c.JSON(200, gin.H{
		"resource_id": decoded.ResourceID,
		"sid":         decoded.SID,
	})
}

func getRtcToken(c *gin.Context) {
	log.Printf("\n\nRTC Token:\n")
	// Get Parameters
	id, cert, channelName, tokentype, uidStr, role, expireTimestamp, err := parseRtcParams(c)

	setEnv(id, cert)
	readEnv()

	if err != nil {
		c.Error(err)
		c.AbortWithStatusJSON(400, gin.H{
			"message": "Error Generating RTC token: " + err.Error(),
			"status":  400,
		})
		return
	}

	rtcToken, tokenErr := generateRtcToken(channelName, uidStr, tokentype, role, expireTimestamp)

	if tokenErr != nil {
		log.Println(tokenErr) // token failed to generate
		c.Error(tokenErr)
		errMsg := "Error Generating RTC token - " + tokenErr.Error()
		c.AbortWithStatusJSON(400, gin.H{
			"status": 400,
			"error":  errMsg,
		})
	} else {
		log.Println("RTC Token generated")
		c.JSON(200, gin.H{
			"rtcToken": rtcToken,
		})
	}
}

func request(customerKey, customerSecret, endpoint, bodyBase string) (rid []byte, err error) {

	// Concatenate customer key and customer secret and use base64 to encode the concatenated string
	plainCredentials := customerKey + ":" + customerSecret
	base64Credentials := base64.StdEncoding.EncodeToString([]byte(plainCredentials))

	url := "https://api.agora.io/v1/apps/" + endpoint
	method := "POST"

	payload := strings.NewReader(bodyBase)

	client := &http.Client{}
	req, prob := http.NewRequest(method, url, payload)

	if prob != nil {
		fmt.Println(prob)
		return nil, prob
	}
	// Add Authorization header
	req.Header.Add("Authorization", "Basic "+base64Credentials)
	req.Header.Add("Content-Type", "application/json")

	// Send HTTP request
	res, prob := client.Do(req)
	if prob != nil {
		fmt.Println(prob)
		return nil, prob
	}
	defer res.Body.Close()

	body, prob := ioutil.ReadAll(res.Body)
	if prob != nil {
		fmt.Println(prob)
		return nil, prob
	}

	return body, prob
}

func parseStopParams(c *gin.Context) (channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId string) {
	channelName = c.Param("channelName")
	customerKey = c.Param("customerKey")
	customerSecret = c.Param("customerSecret")
	appId = c.Param("appId")
	recordingId = c.Param("recordingId")
	sid = c.Param("sid")
	resourceId = c.Param("resourceId")

	return channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId
}

func parseRidParams(c *gin.Context) (channelName, customerKey, customerSecret, appId, recordingId string) {

	channelName = c.Param("channelName")
	customerKey = c.Param("customerKey")
	customerSecret = c.Param("customerSecret")
	appId = c.Param("appId")
	recordingId = c.Param("recordingId")

	return channelName, customerKey, customerSecret, appId, recordingId
}

func parseStartParams(c *gin.Context) (appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2 string) {
	appId = c.Param("appId")
	channelName = c.Param("channelName")
	recordingId = c.Param("recordingId")
	resourceId = c.Param("resourceId")
	customerKey = c.Param("customerKey")
	customerSecret = c.Param("customerSecret")
	token = c.Param("token")
	maxIdleTime = c.Param("maxIdleTime")
	bucketId = c.Param("bucketId")
	bucketAccessKey = c.Param("bucketAccessKey")
	bucketSecretKey = c.Param("bucketSecretKey")
	userUid = c.Param("userUid")
	dir1 = c.Param("dir1")
	dir2 = c.Param("dir2")

	return appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2
}

func parseRtcParams(c *gin.Context) (id, cert, channelName, tokentype, uidStr string, role rtctokenbuilder.Role, expireTimestamp uint32, err error) {

	id = c.Param("id")
	cert = c.Param("cert")
	channelName = c.Param("channelName")
	roleStr := c.Param("role")
	tokentype = c.Param("tokentype")
	uidStr = c.Param("uid")
	expireTime := c.DefaultQuery("expiry", "3600")

	if roleStr == "publisher" {
		role = rtctokenbuilder.RolePublisher
	} else {
		role = rtctokenbuilder.RoleSubscriber
	}

	expireTime64, parseErr := strconv.ParseUint(expireTime, 10, 64)
	if parseErr != nil {
		// if string conversion fails return an error
		err = fmt.Errorf("failed to parse expireTime: %s, causing error: %s", expireTime, parseErr)
	}

	// set timestamps
	expireTimeInSeconds := uint32(expireTime64)
	currentTimestamp := uint32(time.Now().UTC().Unix())
	expireTimestamp = currentTimestamp + expireTimeInSeconds

	return id, cert, channelName, tokentype, uidStr, role, expireTimestamp, err
}

func generateRtcToken(channelName, uidStr, tokentype string, role rtctokenbuilder.Role, expireTimestamp uint32) (rtcToken string, err error) {
	log.Printf(appID, appCertificate)
	if tokentype == "userAccount" {
		log.Printf("Building Token with userAccount: %s\n", uidStr)
		rtcToken, err = rtctokenbuilder.BuildTokenWithUserAccount(appID, appCertificate, channelName, uidStr, role, expireTimestamp)
		return rtcToken, err

	} else if tokentype == "uid" {
		uid64, parseErr := strconv.ParseUint(uidStr, 10, 64)
		// check if conversion fails
		if parseErr != nil {
			err = fmt.Errorf("failed to parse uidStr: %s, to uint causing error: %s", uidStr, parseErr)
			return "", err
		}

		uid := uint32(uid64) // convert uid from uint64 to uint 32
		log.Printf("Building Token with uid: %d\n", uid)
		rtcToken, err = rtctokenbuilder.BuildTokenWithUID(appID, appCertificate, channelName, uid, role, expireTimestamp)
		return rtcToken, err

	} else {
		err = fmt.Errorf("failed to generate RTC token for Unknown Tokentype: %s", tokentype)
		log.Println(err)
		return "", err
	}
}
