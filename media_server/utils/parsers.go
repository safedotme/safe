package utils

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"media-server/models"

	"github.com/gin-gonic/gin"
)

// func ParseStopParams(c *gin.Context) (channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId, cred string) {
// 	channelName = Decode(c.Param("channelName"))
// 	customerKey = Decode(c.Param("customerKey"))
// 	customerSecret = Decode(c.Param("customerSecret"))
// 	appId = Decode(c.Param("appId"))
// 	recordingId = Decode(c.Param("recordingId"))
// 	sid = Decode(c.Param("sid"))
// 	resourceId = Decode(c.Param("resourceId"))
// 	cred = c.Param("cred")

// 	return channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId, cred
// }

// func ParseRidParams(c *gin.Context) (channelName, customerKey, customerSecret, appId, recordingId, cred string) {

// 	channelName = Decode(c.Param("channelName"))
// 	customerKey = Decode(c.Param("customerKey"))
// 	customerSecret = Decode(c.Param("customerSecret"))
// 	appId = Decode(c.Param("appId"))
// 	recordingId = Decode(c.Param("recordingId"))
// 	cred = c.Param("cred")

// 	return channelName, customerKey, customerSecret, appId, recordingId, cred
// }

// func ParseStartParams(c *gin.Context) (appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2, cred string) {
// 	appId = Decode(c.Param("appId"))
// 	channelName = Decode(c.Param("channelName"))
// 	recordingId = Decode(c.Param("recordingId"))
// 	resourceId = Decode(c.Param("resourceId"))
// 	customerKey = Decode(c.Param("customerKey"))
// 	customerSecret = Decode(c.Param("customerSecret"))
// 	token = Decode(c.Param("token"))
// 	maxIdleTime = Decode(c.Param("maxIdleTime"))

// 	bucketId = Decode(c.Param("bucketId"))
// 	bucketAccessKey = Decode(c.Param("bucketAccessKey"))
// 	bucketSecretKey = Decode(c.Param("bucketSecretKey"))
// 	userUid = Decode(c.Param("userUid"))
// 	dir1 = Decode(c.Param("dir1"))
// 	dir2 = Decode(c.Param("dir2"))
// 	cred = c.Param("cred")

// 	return appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2, cred
// }

// ⬇️ RID

func ParseRIDBody(c *gin.Context) (data models.RIDBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isEmpty := ContainsEmpty(data.AppID, data.ChannelName, data.CustomerKey, data.CustomerSecret, data.RecordingID)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}

// ⬇️ RTC

func ParseRTCBody(c *gin.Context) (data models.RTCBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isEmpty := ContainsEmpty(data.Role, data.UserID, data.AppCertificate, data.AppID, data.TokenType, data.ChannelName)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}
